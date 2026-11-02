// Loads approved forum posts (a page at a time, so hundreds of posts stay fast to load)
// and wires the guest-post form.

const PAGE_SIZE = 25;
let turnstileWidgetId;
let nextOffset = 0;
let reachedEnd = false;
let isLoadingPage = false;

window.onloadTurnstileCallback = function () {
  const siteKey = PV.cfg.TURNSTILE_SITE_KEY;
  const el = document.getElementById("turnstile-post");
  if (!siteKey || siteKey.includes("YOUR-TURNSTILE") || !el || !window.turnstile) return;
  turnstileWidgetId = window.turnstile.render(el, { sitekey: siteKey });
};

function renderPostsPage(posts, append) {
  const container = document.getElementById("posts");
  const html = posts
    .map(
      (p) => `
    <div class="post">
      <p style="margin:0;">${PV.escapeHtml(p.content)}</p>
      <div class="post-meta">${PV.escapeHtml(p.guest_name || "Guest")} · ${PV.timeAgo(p.created_at)}</div>
    </div>`
    )
    .join("");
  if (append) {
    container.insertAdjacentHTML("beforeend", html);
  } else {
    container.innerHTML = html;
  }
}

function updateLoadMoreButton() {
  const btn = document.getElementById("load-more-btn");
  if (!btn) return;
  btn.hidden = reachedEnd;
  btn.disabled = isLoadingPage;
  btn.textContent = isLoadingPage ? "Loading…" : "Load more";
}

async function loadPosts(append) {
  if (isLoadingPage || (append && reachedEnd)) return;
  const client = PV.getClient();
  const container = document.getElementById("posts");
  if (!client) {
    container.innerHTML = '<p class="form-note">Site isn\'t configured yet — see assets/js/config.js.</p>';
    return;
  }

  isLoadingPage = true;
  updateLoadMoreButton();

  const { data, error } = await client
    .from("forum_posts")
    .select("content, guest_name, created_at")
    .eq("status", "approved")
    .order("created_at", { ascending: false })
    .range(nextOffset, nextOffset + PAGE_SIZE - 1);

  isLoadingPage = false;

  if (error) {
    if (append) {
      PV.showAlert(document.getElementById("forum-load-alert"), "Could not load more posts: " + error.message, "error");
    } else {
      container.innerHTML = '<p class="form-note">Could not load posts: ' + PV.escapeHtml(error.message) + "</p>";
    }
    updateLoadMoreButton();
    return;
  }

  const page = data || [];
  if (!append && page.length === 0) {
    container.innerHTML = '<p class="form-note">No posts yet — be the first to share something.</p>';
    updateLoadMoreButton();
    return;
  }

  renderPostsPage(page, append);
  nextOffset += page.length;
  if (page.length < PAGE_SIZE) reachedEnd = true;
  updateLoadMoreButton();
}

document.addEventListener("DOMContentLoaded", () => {
  loadPosts(false);
  const loadMoreBtn = document.getElementById("load-more-btn");
  if (loadMoreBtn) loadMoreBtn.addEventListener("click", () => loadPosts(true));

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
