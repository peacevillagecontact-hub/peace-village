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

  // Donation addresses — Gate exchange deposit addresses, read directly from the owner's
  // own Gate deposit-QR screenshots (uploaded 2026-11-02). See SECURITY.md §7: these are
  // CUSTODIAL exchange deposit addresses (funds land in the owner's Gate account), not
  // self-custody wallets like the previous version of this page used.
  // Each entry: display label, address, and the matching freshly-generated QR image in assets/images/.
  // coin / network / minDeposit are shown as separate labeled rows on the Donate tab
  // (matching the owner's own Gate deposit screenshots field-for-field). Gate's screenshots
  // do not display a network-fee figure for any of these 6 deposit pages, so none is shown
  // here either — a number wasn't invented to fill that row.
  DONATION_OPTIONS: [
    {
      key: "btc-mainnet",
      label: "Bitcoin (BTC Network)",
      coin: "BTC",
      network: "Bitcoin",
      address: "1LpLcoecC3x9HvvebLG83Po4snGJg2dF1M",
      minDeposit: "0.000006 BTC",
      qrImage: "assets/images/btc-mainnet-qr.png",
    },
    {
      key: "btc-bep20",
      label: "BTC — BNB Smart Chain (BEP20)",
      coin: "BTC",
      network: "BNB Smart Chain (BEP20)",
      address: "0xA9466EA263aa9bAf86948A2B1C602427783F32Ad",
      minDeposit: "0.000006 BTC",
      qrImage: "assets/images/btc-bep20-qr.png",
    },
    {
      key: "usdt-trc20",
      label: "USDT — Tron (TRC20)",
      coin: "USDT",
      network: "Tron (TRC20)",
      address: "TRQFaC2icdVGhZV53TuZyGXjmDMDNUiwbd",
      minDeposit: "0.01 USDT",
      qrImage: "assets/images/usdt-trc20-qr.png",
    },
    {
      key: "usdt-arbitrum",
      label: "USDT — Arbitrum One",
      coin: "USDT",
      network: "Arbitrum One",
      address: "0xA9466EA263aa9bAf86948A2B1C602427783F32Ad",
      minDeposit: "0.01 USDT",
      qrImage: "assets/images/usdt-arbitrum-qr.png",
    },
    {
      key: "usdt-bep20",
      label: "USDT — BNB Smart Chain (BEP20)",
      coin: "USDT",
      network: "BNB Smart Chain (BEP20)",
      address: "0xA9466EA263aa9bAf86948A2B1C602427783F32Ad",
      minDeposit: "0.01 USDT",
      qrImage: "assets/images/usdt-bep20-qr.png",
    },
    {
      key: "usdt-sol",
      label: "USDT — Solana (SOL)",
      coin: "USDT",
      network: "Solana",
      address: "Djucxnipvv9FSsksEqVxW2xs641W4AFRfp7Tz7cQn2U4",
      minDeposit: "0.01 USDT",
      qrImage: "assets/images/usdt-sol-qr.png",
    },
  ],
};
