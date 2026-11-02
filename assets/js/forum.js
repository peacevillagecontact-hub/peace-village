// Loads approved forum posts and wires the guest-post form.

let turnstileWidgetId;

window.onloadTurnstileCallback = function () {
  const siteKey = PV.cfg.TURNSTILE_SITE_KEY;
  const el = document.getElementById("turnstile-post");
  if (!siteKey || siteKey.includes("YOUR-TURNSTILE") || !el || !window.turnstile) return;
  turnstileWidgetId = window.turnstile.render(el, { sitekey: siteKey });
};

async function loadPosts() {
  const client = PV.getClient();
  const container = document.getElementById("posts");
  if (!client) {
    container.innerHTML = '<p class="form-note">Site isn\'t configured yet — see assets/js/config.js.</p>';
    return;
  }
  const { data, error } = await client
    .from("forum_posts")
    .select("content, guest_name, created_at")
    .eq("status", "approved")
    .order("created_at", { ascending: false })
    .limit(50);

  if (error) {
    container.innerHTML = '<p class="form-note">Could not load posts: ' + PV.escapeHtml(error.message) + "</p>";
    return;
  }
  if (!data || data.length === 0) {
    container.innerHTML = '<p class="form-note">No posts yet — be the first to share something.</p>';
    return;
  }
  container.innerHTML = data
    .map(
      (p) => `
    <div class="post">
      <p style="margin:0;">${PV.escapeHtml(p.content)}</p>
      <div class="post-meta">${PV.escapeHtml(p.guest_name || "Guest")} · ${PV.timeAgo(p.created_at)}</div>
    </div>`
    )
    .join("");
}

document.addEventListener("DOMContentLoaded", () => {
  loadPosts();

  const form = document.getElementById("form-post");
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const alertEl = document.getElementById("alert-post");
    const client = PV.getClient();
    if (!client) {
      PV.showAlert(alertEl, "Site isn't configured yet.", "error");
      return;
    }
    const siteKey = PV.cfg.TURNSTILE_SITE_KEY;
    if (siteKey && !siteKey.includes("YOUR-TURNSTILE")) {
      const token = window.turnstile ? window.turnstile.getResponse(turnstileWidgetId) : "";
      if (!token) {
        PV.showAlert(alertEl, "Please complete the verification check.", "error");
        return;
      }
    }

    const data = new FormData(form);
    const btn = form.querySelector('button[type="submit"]');
    btn.disabled = true;
    const { error } = await client.from("forum_posts").insert({
      content: data.get("content"),
      guest_name: data.get("guest_name"),
    });
    btn.disabled = false;

    if (error) {
      PV.showAlert(alertEl, "Something went wrong: " + error.message, "error");
    } else {
      PV.showAlert(alertEl, "Thanks! Your post is pending review.", "success");
      form.reset();
      if (window.turnstile && turnstileWidgetId !== undefined) window.turnstile.reset(turnstileWidgetId);
    }
  });
});
