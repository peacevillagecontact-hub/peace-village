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
  TURNSTILE_SITE_KEY: "0x4AAAAAAFxM7P72eYlI4_wM",

  // Donation addresses, carried over from the original Vercel site's donate tab.
  // Each entry: display label, address, and the matching pre-generated QR image in assets/images/.
  DONATION_OPTIONS: [
    {
      key: "btc",
      label: "Bitcoin (Mainnet)",
      address: "bc1qk4zc5pjhqemp03yz93n4kf5vuf2u73k2wchf9g9dyw0eysumg76sqdg2e8",
      qrImage: "assets/images/btc-qr.png",
      note: "Network fee ~$2-15 · confirmation 10-60 min, varies by congestion.",
    },
    {
      key: "usdt-trc20",
      label: "USDT — TRC20 (Tron)",
      address: "THUHqUH1SKLJ6DLMWRynjVqxtjgKj2khWi",
      qrImage: "assets/images/usdt-trc20-qr.png",
      note: "Network fee ~$1-3 · confirmation 1-3 min · TRON network.",
    },
    {
      key: "usdt-arbitrum",
      label: "USDT — Arbitrum One",
      address: "0x4191d0d1dc7d1fbfe88693579e35809bc7199656",
      qrImage: "assets/images/usdt-arbitrum-qr.png",
      note: "Send only USDT on the Arbitrum One network to this address.",
    },
    {
      key: "usdt-sol",
      label: "USDT — SOL (Solana)",
      address: "8JekfK7GoySAGbhjyKh9EznfZqgwo3EqwYQZvkbF1i5k",
      qrImage: "assets/images/usdt-sol-qr.png",
      note: "Send only USDT on the Solana network to this address.",
    },
  ],
};
