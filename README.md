# Peace Village

Static site (plain HTML/CSS/JS, no build step) for the Peace Village community project.
Backed by Supabase (database + file storage). Hosted free on GitHub Pages.

## What's here

- `index.html`, `manifesto.html`, `contribute.html`, `forum.html`, `resources.html`, `about.html` — the pages.
- `assets/css/style.css` — all styling, one file.
- `assets/js/config.js` — site configuration (Supabase, Turnstile, donation addresses). Already filled in — see below.
- `assets/js/*.js` — page logic (plain JavaScript, no framework, no build).
- `supabase/migrations/001_initial_schema.sql` — run this once in the Supabase SQL editor (already run for you — see below).

## One-time setup (do these in order)

1. **Supabase**: ✅ already done — `supabase/migrations/001_initial_schema.sql` has been run against your
   `peacevillagecontact-hub's Project` Supabase project (tables, RLS policies, and the `contributions_view`
   are live). If you ever need to re-create them from scratch (e.g. a new Supabase project), paste that
   file's contents into SQL Editor → New query → Run.
2. **Supabase keys**: ✅ already done — real `SUPABASE_URL` and the project's publishable key are in `config.js`.
3. **Cloudflare Turnstile**: ✅ already done — a widget was created for `peacevillagecontact-hub.github.io`
   and its Site Key is in `config.js`. The matching Secret key stays in the Cloudflare dashboard only
   (Turnstile → this widget) — it's not used anywhere since there's no server-side verification yet
   (see SECURITY.md §2 for why, and the mitigation).
4. **Donations**: ✅ already done — `config.js`'s `DONATION_OPTIONS` carries the real BTC, USDT-TRC20,
   USDT-Arbitrum One and USDT-SOL addresses (ported from the old Vercel site's donate tab), each with a
   freshly-generated QR image in `assets/images/`. To change an address or add a network, edit that array.
5. **Hero image**: ✅ already done — `assets/images/hero.jpg` (from the old site's homepage photo).
6. **GitHub Pages**: ✅ already done — live at `https://peacevillagecontact-hub.github.io/peace-village/`.

## Moderating submissions (no extra tool needed)

Every guest submission (ideas, resources, locations, forum posts, contact messages) lands in Supabase
with `status = 'pending'` and is **not shown on the site** until approved. To approve or reject:

Supabase dashboard → Table Editor → pick the table (`ideas`, `resources`, `locations`, `forum_posts`,
`contacts`) → edit the `status` cell on a row to `approved` or `rejected`.

That's it — no admin panel to build or maintain.

## Updating the site later

Edit any `.html`/`.css`/`.js` file directly (they're plain text, no build/compile step), commit, and push
to `main` — GitHub Pages redeploys automatically within a minute or two.

## Security

See `SECURITY.md` in this repo for a detailed breakdown of every security control applied
(RLS policies, anti-spam, XSS prevention, secrets handling, HTTPS) and the one known gap
(no server-side Turnstile verification, since there's no backend) — plus how it's mitigated.

## What changed from the old Vercel/Next.js site

See the project's `manual.md` (in the Claude Project "Website Development - Peace Village") for the
full list of decisions and what was intentionally dropped (user accounts/login, the BTCPay dynamic
invoice API, realtime notifications) and why.
