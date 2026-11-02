// Peace Village — site configuration.
// Fill these in with your Supabase project's values (Supabase dashboard → Project Settings → API).
// The "anon" key is PUBLIC BY DESIGN (Supabase relies on Row Level Security, not secrecy of this key),
// so it is safe to commit this file to a public GitHub repo.

window.PEACE_VILLAGE_CONFIG = {
  SUPABASE_URL: "https://YOUR-PROJECT-REF.supabase.co",
  SUPABASE_ANON_KEY: "YOUR-ANON-PUBLIC-KEY",

  // Cloudflare Turnstile site key (Cloudflare dashboard → Turnstile → your widget → Site Key).
  // Safe to be public; it only identifies the widget, not a secret.
  TURNSTILE_SITE_KEY: "YOUR-TURNSTILE-SITE-KEY",

  // Your Bitcoin receiving address, shown as text + used to generate the QR code link.
  BTC_ADDRESS: "YOUR-BITCOIN-ADDRESS",
};
