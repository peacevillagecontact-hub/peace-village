// Wires the 4 guest-submission forms on contribute.html to Supabase, plus Turnstile anti-spam.

const turnstileWidgets = {};

window.onloadTurnstileCallback = function () {
  const siteKey = PV.cfg.TURNSTILE_SITE_KEY;
  if (!siteKey || siteKey.includes("YOUR-TURNSTILE")) return; // not configured yet — forms still work, just unprotected
  ["idea", "resource", "connect", "location"].forEach((key) => {
    const el = document.getElementById("turnstile-" + key);
    if (el && window.turnstile) {
      turnstileWidgets[key] = window.turnstile.render(el, { sitekey: siteKey });
    }
  });
};

function getTurnstileResponse(key) {
  if (window.turnstile && turnstileWidgets[key] !== undefined) {
    return window.turnstile.getResponse(turnstileWidgets[key]) || "";
  }
  return "";
}

function tagsToArray(str) {
  return (str || "")
    .split(",")
    .map((t) => t.trim())
    .filter(Boolean);
}

async function handleSubmit(formId, alertId, table, buildRow, turnstileKey) {
  const form = document.getElementById(formId);
  if (!form) return;
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const alertEl = document.getElementById(alertId);
    const client = PV.getClient();
    if (!client) {
      PV.showAlert(alertEl, "Site isn't configured yet — see assets/js/config.js.", "error");
      return;
    }
    const siteKey = PV.cfg.TURNSTILE_SITE_KEY;
    if (siteKey && !siteKey.includes("YOUR-TURNSTILE") && !getTurnstileResponse(turnstileKey)) {
      PV.showAlert(alertEl, "Please complete the verification check.", "error");
      return;
    }

    const data = new FormData(form);
    const row = buildRow(data);
    const btn = form.querySelector('button[type="submit"]');
    btn.disabled = true;

    const { error } = await client.from(table).insert(row);

    btn.disabled = false;
    if (error) {
      PV.showAlert(alertEl, "Something went wrong: " + error.message, "error");
    } else {
      PV.showAlert(alertEl, "Thank you! Your submission is pending review and will appear once approved.", "success");
      form.reset();
      if (window.turnstile && turnstileWidgets[turnstileKey] !== undefined) {
        window.turnstile.reset(turnstileWidgets[turnstileKey]);
      }
    }
  });
}

document.addEventListener("DOMContentLoaded", () => {
  // Tabs
  document.querySelectorAll(".tab-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".tab-btn").forEach((b) => b.classList.remove("active"));
      document.querySelectorAll(".tab-panel").forEach((p) => p.classList.remove("active"));
      btn.classList.add("active");
      document.getElementById("panel-" + btn.dataset.tab).classList.add("active");
    });
  });

  // Idea form -> public.ideas
  handleSubmit("form-idea", "alert-idea", "ideas", (d) => ({
    title: d.get("title"),
    description: d.get("description"),
    image_url: d.get("image_url") || null,
    guest_name: d.get("guest_name"),
  }), "idea");

  // Resource form -> public.resources
  handleSubmit("form-resource", "alert-resource", "resources", (d) => ({
    title: d.get("title"),
    category: d.get("category"),
    description: d.get("description"),
    tags: tagsToArray(d.get("tags")),
    location: d.get("location") || null,
    link: d.get("link") || null,
    guest_name: d.get("guest_name"),
  }), "resource");

  // Connect form -> public.contacts (private — not shown publicly)
  handleSubmit("form-connect", "alert-connect", "contacts", (d) => ({
    name: d.get("name"),
    role: d.get("role"),
    email: d.get("email"),
    phone: d.get("phone") || null,
    message: d.get("message"),
  }), "connect");

  // Location form -> public.locations
  handleSubmit("form-location", "alert-location", "locations", (d) => ({
    name: d.get("name"),
    address: d.get("address"),
    description: d.get("description"),
    image_url: d.get("image_url") || null,
    guest_name: d.get("guest_name"),
  }), "location");

  // Static multi-chain donation info (BTC + USDT on TRC20/Arbitrum One/SOL).
  renderDonationOptions();
});

// Live BTC/USD price, fetched once from CoinGecko's free public API (no key required,
// CORS-enabled). Used only to power the calculator below — never trusted for anything
// that touches money server-side, since there is no server here.
let BTC_PRICE_USD = null;
let btcPriceFetchStarted = false;

async function fetchBtcPrice() {
  if (btcPriceFetchStarted) return;
  btcPriceFetchStarted = true;
  try {
    const res = await fetch("https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd");
    if (!res.ok) throw new Error("price API returned " + res.status);
    const json = await res.json();
    BTC_PRICE_USD = json?.bitcoin?.usd || null;
  } catch (e) {
    BTC_PRICE_USD = null; // calculator below degrades gracefully — address/QR still work without it
  }
}

function renderBtcCalculator(container) {
  if (!BTC_PRICE_USD) {
    container.hidden = true;
    container.innerHTML = "";
    return;
  }
  container.hidden = false;
  container.innerHTML = `
    <div class="btc-price-row">
      <span>Bitcoin price</span>
      <strong>$${BTC_PRICE_USD.toLocaleString("en-US")}</strong>
    </div>
    <div class="btc-calc-row">
      <div class="field" style="margin-bottom:0;">
        <label for="btc-calc-usd">Amount (USD)</label>
        <input type="number" id="btc-calc-usd" min="0" step="any" placeholder="e.g. 50">
      </div>
      <div class="field" style="margin-bottom:0;">
        <label for="btc-calc-btc">Amount (BTC)</label>
        <input type="number" id="btc-calc-btc" min="0" step="any" placeholder="e.g. 0.00065">
      </div>
    </div>
    <p class="form-note">Calculator only — for your reference. Price refreshes when you reload the page.</p>
  `;
  const usdInput = document.getElementById("btc-calc-usd");
  const btcInput = document.getElementById("btc-calc-btc");
  usdInput.addEventListener("input", () => {
    const usd = parseFloat(usdInput.value);
    btcInput.value = isFinite(usd) && usd >= 0 ? (usd / BTC_PRICE_USD).toFixed(8) : "";
  });
  btcInput.addEventListener("input", () => {
    const btc = parseFloat(btcInput.value);
    usdInput.value = isFinite(btc) && btc >= 0 ? (btc * BTC_PRICE_USD).toFixed(2) : "";
  });
}

function renderDonationOptions() {
  const options = PV.cfg.DONATION_OPTIONS || [];
  const tabsEl = document.getElementById("donate-network-tabs");
  const displayEl = document.getElementById("donate-display");
  const calcEl = document.getElementById("btc-calculator");
  if (!tabsEl || !displayEl || options.length === 0) return;

  function show(key) {
    const opt = options.find((o) => o.key === key) || options[0];
    tabsEl.querySelectorAll(".tab-btn").forEach((b) => b.classList.toggle("active", b.dataset.key === opt.key));
    displayEl.innerHTML = `
      <img src="${PV.escapeHtml(opt.qrImage)}" alt="${PV.escapeHtml(opt.label)} donation QR code">
      <code class="btc-address">${PV.escapeHtml(opt.address)}</code>
      <p class="form-note">${PV.escapeHtml(opt.note)}</p>
    `;
    if (calcEl) {
      if (opt.key.startsWith("btc")) {
        renderBtcCalculator(calcEl);
      } else {
        calcEl.hidden = true;
        calcEl.innerHTML = "";
      }
    }
  }

  const networkEmoji = (key) => (key.startsWith("btc") ? "₿" : "💵");
  tabsEl.innerHTML = options
    .map((o, i) => `<button type="button" class="tab-btn${i === 0 ? " active" : ""}" data-key="${PV.escapeHtml(o.key)}">${networkEmoji(o.key)} ${PV.escapeHtml(o.label)}</button>`)
    .join("");
  tabsEl.querySelectorAll(".tab-btn").forEach((btn) => {
    btn.addEventListener("click", () => show(btn.dataset.key));
  });

  fetchBtcPrice().then(() => show(document.querySelector("#donate-network-tabs .tab-btn.active")?.dataset.key || options[0].key));
  show(options[0].key);
}
