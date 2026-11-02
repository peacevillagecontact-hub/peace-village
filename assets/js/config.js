// Peace Village — site configuration.
// Fill these in with your Supabase project's values (Supabase dashboard → Project Settings → API).
// The "anon" key is PUBLIC BY DESIGN (Supabase relies on Row Level Security, not secrecy of this key),
// so it is safe to commit this file to a public GitHub repo.

window.PEACE_VILLAGE_CONFIG = {
  SUPABASE_URL: "https://sdgpqjcvikkweagafjha.supabase.co",
  // This is Supabase's new-format "publishable" key (replaces the legacy "anon" key — same
  // public-by-design model, see the comment above). Safe to commit.
  SUPABASE_ANON_KEY: "sb_publishable_XiqCO8Gw57enFFl0lDl-aQ_6uN6b-Sq",

  // Cloudflare Turnstile site key (Cloudflare dashboard → Turnstile → your widget → Site Key).
  // Safe to be public; it only identifies the widget, not a secret.
  TURNSTILE_SITE_KEY: "YOUR-TURNSTILE-SITE-KEY",

  // Your Bitcoin receiving address, shown as text + used to generate the QR code link.
  BTC_ADDRESS: "YOUR-BITCOIN-ADDRESS",
};
