# Peace Village

Static site (plain HTML/CSS/JS, no build step) for the Peace Village community project.
Backed by Supabase (database + file storage). Hosted free on GitHub Pages.

## What's here

- `index.html`, `manifesto.html`, `contribute.html`, `forum.html`, `resources.html`, `about.html` — the pages.
- `assets/css/style.css` — all styling, one file.
- `assets/js/config.js` — **edit this first** (Supabase + Turnstile keys, BTC address).
- `assets/js/*.js` — page logic (plain JavaScript, no framework, no build).
- `supabase/migrations/018_add_moderation_status.sql` — run this once in the Supabase SQL editor.

## One-time setup (do these in order)

1. **Supabase**: open your project at supabase.com/dashboard → SQL Editor → paste the contents of
   `supabase/migrations/018_add_moderation_status.sql` → Run.
2. **Supabase keys**: Project Settings → API → copy the "Project URL" and the "anon public" key into
   `assets/js/config.js`.
3. **Cloudflare Turnstile** (free spam protection): dashboard.cloudflare.com → Turnstile → Add widget →
   pick "Managed" → copy the **Site Key** into `assets/js/config.js`.
4. **Bitcoin donation**: put your BTC address in `assets/js/config.js` (`BTC_ADDRESS`), and add your QR
   code image as `assets/images/btc-qr.jpg` (copy it from the old site's `public/images/btc-qr-cropped.png`).
5. **Hero image**: add the homepage photo as `assets/images/hero.jpg` (copy from the old site's
   `public/images/IMG_1108.jpg`).
6. **GitHub Pages**: this repo's Settings → Pages → Source: "Deploy from a branch" → Branch: `main` / `/ (root)` → Save.
   Your site will be live at `https://peacevillagecontact-hub.github.io/peace-village/`.

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
