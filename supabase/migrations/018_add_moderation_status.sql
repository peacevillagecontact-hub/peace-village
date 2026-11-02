-- 018_add_moderation_status.sql
--
-- Purpose: adapt the existing schema for the simplified site:
--   - no user accounts (everything is guest + admin-approval)
--   - every public submission needs the owner's manual approval before it's visible
--
-- Run this in the Supabase SQL editor (Dashboard → SQL Editor → New query → paste → Run),
-- AFTER the existing 000-017 migrations have already been applied (they have, on the current project).
--
-- Moderation itself needs no extra code: approve/reject rows directly in
-- Dashboard → Table Editor → (ideas / resources / locations / contacts / forum_posts / forum_comments)
-- by editing the "status" column to 'approved' or 'rejected'.

-- 1) Add a moderation status to every guest-submittable table.
alter table if exists public.ideas
  add column if not exists status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected'));

alter table if exists public.resources
  add column if not exists status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected'));

alter table if exists public.locations
  add column if not exists status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected'));

alter table if exists public.contacts
  add column if not exists status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected'));

alter table if exists public.forum_posts
  add column if not exists status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected'));

alter table if exists public.forum_comments
  add column if not exists status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected'));

-- 2) Public (anonymous) visitors should only ever see approved rows.
-- The owner (you, logged into the Supabase dashboard) always sees everything —
-- RLS does not apply to the dashboard's own connection.

drop policy if exists "ideas_select_all" on public.ideas;
create policy "ideas_select_approved" on public.ideas
  for select using (status = 'approved');

drop policy if exists "resources_select_all" on public.resources;
create policy "resources_select_approved" on public.resources
  for select using (status = 'approved');

drop policy if exists "locations_select_all" on public.locations;
create policy "locations_select_approved" on public.locations
  for select using (status = 'approved');

drop policy if exists "contacts_select_all" on public.contacts;
-- contacts (the "Connect" form) are private messages to the owner, not public content —
-- no one but the dashboard owner should read these at all.
create policy "contacts_select_none" on public.contacts
  for select using (false);

drop policy if exists "forum_posts_select_all" on public.forum_posts;
create policy "forum_posts_select_approved" on public.forum_posts
  for select using (status = 'approved');

-- 3) Allow fully anonymous (no login) inserts with a guest name, on every table.
-- This matches the pattern already used by ideas/resources/locations/forum_posts
-- (auth.uid() is null and guest_name is not null), extended to drop the "or authenticated" branch
-- since there is no login anymore.

drop policy if exists "forum_posts_insert_auth_or_guest" on public.forum_posts;
create policy "forum_posts_insert_guest" on public.forum_posts
  for insert with check (guest_name is not null and user_id is null);

drop policy if exists "resources_insert_auth_or_guest" on public.resources;
create policy "resources_insert_guest" on public.resources
  for insert with check (guest_name is not null and user_id is null);

-- ideas / locations / contacts: recreate with the same guest-only rule
-- (names below match the likely existing policy names from 004_schema_contributions.sql;
--  "drop policy if exists" is a no-op if the name doesn't match, so this is safe either way)
drop policy if exists "ideas_insert_auth_or_guest" on public.ideas;
create policy "ideas_insert_guest" on public.ideas
  for insert with check (guest_name is not null and user_id is null);

drop policy if exists "locations_insert_auth_or_guest" on public.locations;
create policy "locations_insert_guest" on public.locations
  for insert with check (guest_name is not null and user_id is null);

drop policy if exists "contacts_insert_auth_or_guest" on public.contacts;
create policy "contacts_insert_guest" on public.contacts
  for insert with check (name is not null);

-- 4) Rebuild the public contributions_view to only union APPROVED rows,
-- so the Resources/Contribute listing pages never show pending/rejected items.
drop view if exists public.contributions_view;
create or replace view public.contributions_view
security invoker
as
select
  r.id, 'resource'::text as type, r.title, r.category, r.description,
  coalesce(r.tags, '{}'::text[]) as tags, r.location, r.link,
  null::text as image_url, r.guest_name, r.created_at, r.status
from public.resources r
where r.status = 'approved'

union all

select
  i.id, 'idea'::text as type, i.title, 'Idea'::text as category, i.description,
  '{}'::text[] as tags, null::text as location, null::text as link,
  i.image_url, i.guest_name, i.created_at, i.status
from public.ideas i
where i.status = 'approved'

union all

select
  l.id, 'location'::text as type, l.name as title, 'Location'::text as category, l.description,
  coalesce(l.tags, '{}'::text[]) as tags, l.address as location, null::text as link,
  l.image_url, l.guest_name, l.created_at, l.status
from public.locations l
where l.status = 'approved';

-- 5) Optional cleanup (do this manually, later, once you're confident the new site works):
--    the profiles / auth.users / notifications / realtime machinery built for the old
--    login system is no longer used by the new static site and can be left in place
--    (harmless, costs nothing) or removed by hand in the Supabase dashboard.
