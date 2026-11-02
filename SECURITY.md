# Security measures — Peace Village static site

Local, detailed record of every security control applied to this project, why it's there,
and what's intentionally out of scope. Kept in the repo (not just in the Claude Project
`manual.md`) so it travels with the code and survives independently of any AI session.

Status column: ✅ applied in code/config now · ⏳ needs a one-time manual step by the owner
(see README.md) · ❌ known gap, not yet addressed.

## 1. Database access control (Supabase Row Level Security)

| Control | Status | Detail |
|---|---|---|
| RLS enabled on every public table | ✅ | Inherited from the original 17 migrations (000–017); this project never disables RLS. |
| Public SELECT limited to `status = 'approved'` | ✅ | `018_add_moderation_status.sql` — applies to `ideas`, `resources`, `locations`, `forum_posts`. Pending/rejected rows are invisible to anonymous visitors; only the dashboard owner (via Supabase's own privileged connection, which bypasses RLS) sees everything. |
| `contacts` table: SELECT fully blocked for everyone except the owner | ✅ | `create policy "contacts_select_none" ... using (false)`. The "Connect" form is a private message to the owner, not public content — no `anon` or `authenticated` role can read it back, ever. |
| Guest INSERT restricted to well-formed guest rows | ✅ | Every insert policy requires `guest_name is not null and user_id is null` (or `name is not null` for `contacts`). This blocks a visitor from impersonating a logged-in user's `user_id`, since none exists for guest sessions anyway. |
| No UPDATE/DELETE policy for anonymous role | ✅ | Only SELECT and INSERT policies exist for guests. A visitor cannot edit or delete anyone's submission, including their own, after submitting — moderation/correction is owner-only via the dashboard. |
| `contributions_view` uses `security invoker` | ✅ | Without this, a Postgres view runs with the *view owner's* privileges, which would silently bypass the underlying tables' RLS and leak pending rows. `security invoker` forces the view to respect the querying role's own RLS, so it only ever surfaces what `anon` is already allowed to see. |
| `anon` key safe to publish | ✅ (by design) | Supabase's security model is RLS-based, not key-secrecy-based. The anon/public key is meant to be embedded in client-side code (see `assets/js/config.js`) — it identifies the `anon` Postgres role, and that role's actual permissions are entirely defined by the RLS policies above. Committing it to a public GitHub repo is standard practice and does **not** weaken security, provided RLS stays correctly configured (which is the actual security boundary). |
| `service_role` key never used client-side | ✅ | This key bypasses RLS entirely and must never appear in any file under `assets/` or be committed. It isn't used anywhere in this static site — there is no backend to hold it. |

## 2. Anti-spam / anti-bot

| Control | Status | Detail |
|---|---|---|
| Cloudflare Turnstile on every guest-submission form | ✅ | 5 widgets total: idea, resource, connect, location, forum post. Free, privacy-respecting (no tracking cookies, unlike reCAPTCHA). |
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
| Old auth/profiles/notifications/realtime tables | ⏳ | Still present in the database (harmless, unused) per migration 018's closing comment. Optional manual cleanup later — leaving them doesn't create a public-facing risk since no RLS policy on them grants anonymous access beyond what already existed before this migration. |

## 7. What the owner still needs to do (see README.md for the exact steps)

1. Run `supabase/migrations/018_add_moderation_status.sql` in the Supabase SQL editor.
2. Fill in real `SUPABASE_URL` / `SUPABASE_ANON_KEY` in `assets/js/config.js`.
3. Create a Cloudflare Turnstile widget and fill in `TURNSTILE_SITE_KEY`.
4. Add the BTC QR code image and `BTC_ADDRESS`.
5. Periodically check Supabase → Table Editor for pending submissions and approve/reject.

## 8. Threat model summary (plain language)

- **A random bot spamming forms**: stopped by Turnstile (§2) in the common case; even if it gets through, nothing it submits is visible to the public until a human approves it (§1).
- **Someone reading the page source to find the Supabase key**: expected and harmless — the key only grants exactly what RLS allows (§1), which is "insert as guest" and "read approved rows," nothing more.
- **Someone trying to read other people's contact-form messages**: blocked at the database level (§1) — there is no policy that permits it, regardless of what key or client is used.
- **Someone submitting an XSS payload as their name/bio/post content**: neutralized on render by `escapeHtml()` (§3), and never shown publicly anyway unless approved (§1).
- **Someone bypassing Turnstile by calling the Supabase REST API directly**: not currently prevented (§2, the one open gap) — but contained by moderation (§1), since nothing reaches the public site without manual approval.
