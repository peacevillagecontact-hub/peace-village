// Shared Supabase client. Loaded after the Supabase UMD script and config.js on every page.
// No build step: @supabase/supabase-js is loaded straight from a CDN as a <script> tag.

const PV = (() => {
  const cfg = window.PEACE_VILLAGE_CONFIG || {};
  let client = null;

  function getClient() {
    if (!client) {
      if (!window.supabase || !cfg.SUPABASE_URL || cfg.SUPABASE_URL.includes("YOUR-PROJECT-REF")) {
        console.error("Supabase is not configured yet — edit assets/js/config.js");
        return null;
      }
      client = window.supabase.createClient(cfg.SUPABASE_URL, cfg.SUPABASE_ANON_KEY);
    }
    return client;
  }

  function showAlert(el, message, kind) {
    if (!el) return;
    el.textContent = message;
    el.className = "alert show " + (kind === "error" ? "alert-error" : "alert-success");
  }

  function timeAgo(iso) {
    const d = new Date(iso);
    const diffSec = Math.max(1, Math.floor((Date.now() - d.getTime()) / 1000));
    const units = [
      ["year", 31536000], ["month", 2592000], ["day", 86400],
      ["hour", 3600], ["minute", 60], ["second", 1],
    ];
    for (const [name, secs] of units) {
      const val = Math.floor(diffSec / secs);
      if (val >= 1) return val + " " + name + (val > 1 ? "s" : "") + " ago";
    }
    return "just now";
  }

  function escapeHtml(str) {
    const div = document.createElement("div");
    div.textContent = str == null ? "" : String(str);
    return div.innerHTML;
  }

  // Cloudflare Turnstile token read from the rendered widget, if present on the page.
  function getTurnstileToken() {
    const input = document.querySelector('input[name="cf-turnstile-response"]');
    return input ? input.value : "";
  }

  return { getClient, showAlert, timeAgo, escapeHtml, getTurnstileToken, cfg };
})();
