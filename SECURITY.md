# Security measures — Peace Village static site

Local, detailed record of every security control applied to this project, why it's there,
and what's intentionally out of scope. Kept in the repo (not just in the Claude Project
`manual.md`) so it travels with the code and survives independently of any AI session.

Status column: ✅ applied in code/config now · ⏳ needs a one-time manual step by the owner
(see README.md) · ❌ known gap, not yet addressed.

## 1. Database access control (Supabase Row Level Security)

| Control | Status | Detail |
|---|---|---|
| RLS enabled on every public table | ✅ | Applied directly in `001_initial_schema.sql`; verified live by running the migration and smoke-testing against the real Supabase REST API (see the row below on RETURNING). |
| Schema verified live, not assumed | ✅ | Ran on 2026-11-02 against the actual project (`sdgpqjcvikkweagafjha`): confirmed all 5 tables + `contributions_view` exist, confirmed a guest insert with `Prefer: return=minimal` (what the site's JS actually sends) succeeds, and confirmed an anonymous `select` on `ideas` returns `[]` while the row is still `pending`. |
| ⚠️ Gotcha: never chain `.select()` after `.insert()` in the JS | ✅ documented | Postgres RLS also enforces the SELECT policy on any row an INSERT tries to `RETURNING`. Since pending rows aren't SELECT-visible to anon (by design — see above), calling `.from(table).insert(row).select()` on the client would make a perfectly valid insert fail with a misleading "row violates row-level security policy" error. The current code (`contribute.js`/`forum.js`) never calls `.select()` after `.insert()` — it only reads back `{ error }` — so this doesn't affect the live site, but don't add `.select()` there without also loosening the SELECT policy (e.g. allowing a submitter to see their own just-submitted pending row) or you'll reintroduce this exact bug. |
| Public SELECT limited to `status = 'approved'` | ✅ | `supabase/migrations/001_initial_schema.sql` — applies to `ideas`, `resources`, `locations`, `forum_posts`. Pending/rejected rows are invisible to anonymous visitors; only the dashboard owner (via Supabase's own privileged connection, which bypasses RLS) sees everything. |
| `contacts` table: SELECT fully blocked for everyone except the owner | ✅ | `create policy "contacts_select_none" ... using (false)`. The "Connect" form is a private message to the owner, not public content — no `anon` role can read it back, ever. |
| Guest INSERT restricted to well-formed, pending-only rows | ✅ | Every insert policy requires `guest_name is not null and status = 'pending'` (or `name is not null` for `contacts`). The `status = 'pending'` check specifically blocks a malicious client from crafting a raw REST API call that inserts a row with `status: 'approved'` directly, bypassing moderation entirely — every guest-inserted row is forced to start as pending, no matter what the client sends. |
| No UPDATE/DELETE policy for anonymous role | ✅ | Only SELECT and INSERT policies exist for guests. A visitor cannot edit or delete anyone's submission, including their own, after submitting — moderation/correction is owner-only via the dashboard. |
| `contributions_view` uses `security invoker` | ✅ | Without this, a Postgres view runs with the *view owner's* privileges, which would silently bypass the underlying tables' RLS and leak pending rows. `security invoker` forces the view to respect the querying role's own RLS, so it only ever surfaces what `anon` is already allowed to see. |
| `anon` key safe to publish | ✅ (by design) | Supabase's security model is RLS-based, not key-secrecy-based. The anon/public key is meant to be embedded in client-side code (see `assets/js/config.js`) — it identifies the `anon` Postgres role, and that role's actual permissions are entirely defined by the RLS policies above. Committing it to a public GitHub repo is standard practice and does **not** weaken security, provided RLS stays correctly configured (which is the actual security boundary). |
| `service_role` key never used client-side | ✅ | This key bypasses RLS entirely and must never appear in any file under `assets/` or be committed. It isn't used anywhere in this static site — there is no backend to hold it. |
| `SECURITY DEFINER` functions not directly callable via public RPC | ✅ (fixed session 10) | See §1a below. |

### 1a. `SECURITY DEFINER` function privileges

Two functions in this project run as `SECURITY DEFINER` (they need elevated privileges to do their
job): `notify_new_entry()` (an `AFTER INSERT` trigger that fires the new-submission email webhook —
§ above, "New-submission alerts" in `manual.md`) and `rls_auto_enable()` (a DDL event trigger that
auto-enables RLS on any newly created table, as a defense-in-depth backstop against forgetting it).

Running the Supabase security advisor (`get_advisors`, type `security`) on 2026-11-05 (session 10)
flagged both: Postgres grants `EXECUTE` on a new function to the `PUBLIC` pseudo-role by default, and
the `anon`/`authenticated` roles inherit that through PUBLIC membership — so both functions were
directly callable by any anonymous client via `POST /rest/v1/rpc/notify_new_entry` /
`.../rpc/rls_auto_enable`, even though neither is meant to be invoked that way (both only ever run as
triggers, which is a separate internal mechanism from role-based RPC calls). In practice this was a
low-severity issue — `rls_auto_enable()` takes no useful input and only acts on DDL events, not RPC
calls, and `notify_new_entry()` ignores any arguments an RPC caller could supply — but there was no
reason to leave an unnecessary public entry point open.

**Fix** (two migrations, since the first attempt was incomplete — see each file's own comments):
1. `supabase/migrations/20261105163040_lock_down_security_definer_functions.sql` — revoked `EXECUTE`
   from `anon, authenticated` directly. This alone did **not** clear the advisor warning, because the
   implicit `PUBLIC` grant (see above) was still in effect.
2. `supabase/migrations/20261105163213_lock_down_security_definer_functions_v2.sql` — revoked
   `EXECUTE` from `PUBLIC` as well, which closed the gap.

**Verified after the fix**: `get_advisors(type: "security")` returned `{"lints":[]}` — no remaining
findings. A live test insert into `ideas` still triggered `notify_new_entry()` successfully (confirmed
via `net._http_response`), since trigger invocation doesn't go through the revoked RPC path — so the
new-submission email alerts are unaffected.

## 2. Anti-spam / anti-bot

| Control | Status | Detail |
|---|---|---|
| Cloudflare Turnstile on every guest-submission form | ✅ | 5 widget instances rendered from one Turnstile site (`Peace Village Static Site`, scoped to `peacevillagecontact-hub.github.io`, created 2026-11-02): idea, resource, connect, location, forum post. Free, privacy-respecting (no tracking cookies, unlike reCAPTCHA). Real site key is live in `config.js`. |
| Explicit-render pattern, not automatic | ✅ | Turnstile script loads last (bottom of `<body>`, `async defer`), after the page's own JS has defined `window.onloadTurnstileCallback`. This avoids a race condition where Turnstile's `async` script could fire before the callback exists, which would silently skip rendering the widget and leave the form unprotected. |
| Client validates a Turnstile response exists before insert | ✅ | `contribute.js` / `forum.js`: if a real site key is configured and no token is present, the submit handler blocks and shows an error instead of calling Supabase. |
| **Server-side Turnstile verification — NOT implemented** | ❌ | This is the one real gap. A static site with no backend cannot call Cloudflare's `siteverify` API (that requires a `TURNSTILE_SECRET_KEY`, which must stay server-side). **Current protection is client-side only**, which stops ordinary bots (they can't solve the challenge) but does **not** stop a determined attacker who reads the anon key from the page source and calls the Supabase REST API directly, bypassing the widget entirely. Mitigations that partially cover this gap, already in place: (a) nothing a spammer inserts is ever publicly visible without manual approval (see §1), so spam cannot deface the live site even if it reaches the database; (b) Supabase has its own platform-level rate limiting on the REST API. If spam volume becomes a real problem, the fix is a small serverless function (e.g. a free Cloudflare Worker or Supabase Edge Function) that verifies the Turnstile token server-side before writing — flagged in `manual.md` as a future improvement, intentionally deferred to keep this a zero-backend, zero-cost static site for now. |

## 3. Cross-site scripting (XSS)

| Control | Status | Detail |
|---|---|---|
| All user-submitted content rendered via `escapeHtml()` | ✅ | `supabase-client.js`'s `escapeHtml()` uses the browser's own DOM (`textContent` → `innerHTML` round-trip) to escape `<`, `>`, `&`, quotes, etc. — never custom regex, which is easy to get wrong. Applied to every field pulled from the database before it's inserted into a template string: forum post content, guest names, resource titles/descriptions/tags/locations, idea titles/descriptions. |
| `innerHTML` only ever receives pre-escaped content | ✅ | `forum.js` and `resources.js` build their HTML strings with every interpolated value passed through `PV.escapeHtml()` first — verified line-by-line in both files. |
| Link fields (`link`, `image_url`) still rendered as real `href`/`src`, not escaped-to-text | ⚠️ documented | These are inherently URLs, not display text, so they're placed directly in `href="${...}"` / `src="${...}"` (still HTML-attribute-escaped via `escapeHtml`, which prevents attribute-breakout XSS, but does **not** validate the URL scheme). A malicious submitter could in principle submit `javascript:alert(1)` as a link. Browsers generally refuse `javascript:` in `href`/`img src` contexts from untrusted markup in modern engines, and the moderation gate (§1) means this would require the owner to click "approve" on a suspicious-looking link — but the real protection is the human-moderation step, not the code. If this matters more later, add a scheme allow-list (`https?:` only) in the render functions before approval status is checked. |

## 4. Secrets & configuration

| Control | Status | Detail |
|---|---|---|
| No secrets committed to the repo | ✅ | `assets/js/config.js` currently holds only placeholder strings (`YOUR-PROJECT-REF`, etc.). The real Supabase anon key, when filled in, is safe to commit (§1) — it is not a secret by Supabase's own model. The Turnstile **site key** (public, meant for client-side use) is likewise safe to commit; the Turnstile **secret key** (if server-side verification is ever added, §2) must never be committed. |
| No `.env` / build step to misconfigure | ✅ | By design (plain HTML/CSS/JS, no bundler), there is no environment-variable injection step that could leak a secret into a public bundle — config values are visible in page source either way, which is expected and fine for all values actually used here. |

## 5. Transport & hosting

| Control | Status | Detail |
|---|---|---|
| HTTPS enforced | ✅ | GitHub Pages enables this automatically for the default `*.github.io` domain, and the repo's Pages settings confirm "Enforce HTTPS" is required/on (verified in Settings → Pages, 2026-11-02). All Supabase and Turnstile API calls from the browser are also HTTPS-only endpoints. |
| No custom domain (yet) | ✅ (by choice) | User explicitly deferred buying a domain; `*.github.io` ships with a valid cert by default, so there's nothing extra to configure here. |
| Static hosting = no server-side attack surface | ✅ | No server process, no database credentials on the host, no file uploads processed server-side — GitHub Pages just serves static files. The entire dynamic attack surface is Supabase's own API, governed by RLS (§1). |

## 6. Data privacy

| Control | Status | Detail |
|---|---|---|
| Contact-form messages (name/email/phone/message) are private by default | ✅ | See §1 `contacts_select_none` — this is the one table holding the most personally identifiable data (email, phone), and it's the one table with zero public read access. |
| No authentication system left exposed | ✅ | The old `auth.users`/login flow is unused by every page; no page collects or stores a password. Guest submissions only ever require a display name. |
| No leftover auth/profiles/notifications/realtime tables | ✅ | This Supabase project was created fresh for this rebuild and only ever had `001_initial_schema.sql` run against it — there is no old login/auth schema to clean up or worry about. |

## 7. Donation address provenance

**Updated 2026-11-02 (session 5): the donation addresses were replaced.** The original 4 addresses
(self-custody wallet addresses, ported from the old Vercel site) were fully removed and replaced with
6 addresses read directly from screenshots the owner uploaded of their own **Gate exchange** deposit
pages (`Deposit BTC/USDT to Gate`). Each address/network pair in `config.js`'s `DONATION_OPTIONS` was
read character-by-character from the uploaded image and cross-checked against the screenshot before
being committed. All 6 QR code images in `assets/images/` were freshly generated from those exact
address strings using the Python `qrcode` library (never copied as images), so each QR code is
guaranteed to encode exactly the address text shown next to it.

**Important difference from before — these are now custodial exchange deposit addresses, not
self-custody wallets.** Funds sent to any of these 6 addresses are deposited into the owner's Gate
account, not a wallet only the owner controls. This means:
- The owner is trusting Gate (a third-party exchange) to custody donated funds until withdrawn.
- 3 of the 6 addresses are the *same* address (`0xA9466...F32Ad`) — this is normal for a CEX, which
  reuses one deposit address across multiple EVM-compatible chains (BEP20, Arbitrum One) tied to the
  same account, but donors must still select the exact network shown, or funds can be lost.
- Each network lists Gate's own stated minimum deposit (e.g. 0.000006 BTC, 0.01 USDT) — a donation
  below that minimum may not be credited.

**The owner should still independently verify these addresses** (e.g. confirm them directly in their
own Gate account's deposit screen) before relying on this page for real donations — Claude has no way
to confirm the uploaded screenshots are current, unaltered, or actually the owner's own Gate account
beyond what was shown in the images.

## 8. What the owner still needs to do (see README.md for the exact steps)

Nothing blocking — all core setup (schema, keys, Turnstile, donations, hero image, GitHub Pages) is done.
Remaining, non-blocking items are tracked in `manual.md` (content gaps in `manifesto.html`/`about.html`,
optional pages, Gmail account mismatch). Ongoing: periodically check Supabase → Table Editor for pending
submissions and approve/reject.

## 9. Threat model summary (plain language)

- **A random bot spamming forms**: stopped by Turnstile (§2) in the common case; even if it gets through, nothing it submits is visible to the public until a human approves it (§1).
- **Someone reading the page source to find the Supabase key**: expected and harmless — the key only grants exactly what RLS allows (§1), which is "insert as guest" and "read approved rows," nothing more.
- **Someone trying to read other people's contact-form messages**: blocked at the database level (§1) — there is no policy that permits it, regardless of what key or client is used.
- **Someone submitting an XSS payload as their name/bio/post content**: neutralized on render by `escapeHtml()` (§3), and never shown publicly anyway unless approved (§1).
- **Someone bypassing Turnstile by calling the Supabase REST API directly**: not currently prevented (§2, the one open gap) — but contained by moderation (§1), since nothing reaches the public site without manual approval.
- **Someone calling an internal trigger function directly via public RPC**: closed in session 10 (§1a) — `notify_new_entry()` and `rls_auto_enable()` are no longer executable by `anon`/`authenticated`/`PUBLIC`, only by their own trigger mechanisms.
