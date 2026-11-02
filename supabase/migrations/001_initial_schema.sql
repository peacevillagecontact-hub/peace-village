-- 001_initial_schema.sql
--
-- Full, self-contained schema for the Peace Village static site.
-- Run once, on a fresh/empty Supabase project (Dashboard → SQL Editor → New query → paste → Run).
--
-- Design: no user accounts. Every visitor submission is a guest row with a display name,
-- held as status='pending' until the project owner manually approves it in the Table Editor.
-- Nothing a guest submits is public until approved. See SECURITY.md for the full rationale.

-- 1) Tables -------------------------------------------------------------

create table public.ideas (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text not null,
  image_url text,
  guest_name text not null,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  created_at timestamptz not null default now()
);

create table public.resources (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null,
  description text not null,
  tags text[] default '{}'::text[],
  location text,
  link text,
  guest_name text not null,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  created_at timestamptz not null default now()
);

create table public.locations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  address text not null,
  description text not null,
  image_url text,
  tags text[] default '{}'::text[],
  guest_name text not null,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  created_at timestamptz not null default now()
);

-- Private contact-form messages to the project owner. Never shown publicly (see RLS below).
create table public.contacts (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  role text,
  email text not null,
  phone text,
  message text not null,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  created_at timestamptz not null default now()
);

create table public.forum_posts (
  id uuid primary key default gen_random_uuid(),
  content text not null,
  guest_name text not null,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  created_at timestamptz not null default now()
);

-- 2) Row Level Security --------------------------------------------------
-- RLS is the actual security boundary here (the anon key is public by design — see SECURITY.md).

alter table public.ideas enable row level security;
alter table public.resources enable row level security;
alter table public.locations enable row level security;
alter table public.contacts enable row level security;
alter table public.forum_posts enable row level security;

-- Public (anonymous) read: approved rows only.
create policy "ideas_select_approved" on public.ideas
  for select using (status = 'approved');

create policy "resources_select_approved" on public.resources
  for select using (status = 'approved');

create policy "locations_select_approved" on public.locations
  for select using (status = 'approved');

create policy "forum_posts_select_approved" on public.forum_posts
  for select using (status = 'approved');

-- contacts: private messages to the owner, never publicly readable, at any status.
create policy "contacts_select_none" on public.contacts
  for select using (false);

-- Guest insert: anyone can submit, but every row must carry a non-empty display name/identity
-- and always lands as 'pending' (the column default — guests cannot set status themselves
-- because INSERT policies below don't grant them a way to pass status, and even if they tried,
-- new rows always start 'pending' per the column default; nothing stops a malicious client from
-- explicitly inserting status='approved' in the same request, so the check below enforces it).
create policy "ideas_insert_guest" on public.ideas
  for insert with check (guest_name is not null and status = 'pending');

create policy "resources_insert_guest" on public.resources
  for insert with check (guest_name is not null and status = 'pending');

create policy "locations_insert_guest" on public.locations
  for insert with check (guest_name is not null and status = 'pending');

create policy "forum_posts_insert_guest" on public.forum_posts
  for insert with check (guest_name is not null and status = 'pending');

create policy "contacts_insert_guest" on public.contacts
  for insert with check (name is not null and status = 'pending');

-- No UPDATE/DELETE policies for the anon role on any table: guests cannot edit or delete
-- anything after submitting, including their own rows. Moderation is owner-only, via the
-- Supabase dashboard's privileged connection (which bypasses RLS entirely).

-- 3) Unified read view for the Resources page --------------------------
-- security invoker is required: without it the view would run with the view owner's
-- privileges and silently bypass the RLS policies above.

create or replace view public.contributions_view
with (security_invoker = true)
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

-- 4) Helpful indexes -----------------------------------------------------

create index ideas_status_created_idx on public.ideas (status, created_at desc);
create index resources_status_created_idx on public.resources (status, created_at desc);
create index locations_status_created_idx on public.locations (status, created_at desc);
create index forum_posts_status_created_idx on public.forum_posts (status, created_at desc);
