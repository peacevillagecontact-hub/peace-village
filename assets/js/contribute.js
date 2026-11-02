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

  // Static donation info
  const addrEl = document.getElementById("btc-address");
  if (addrEl) addrEl.textContent = PV.cfg.BTC_ADDRESS || "Set BTC_ADDRESS in assets/js/config.js";
});
