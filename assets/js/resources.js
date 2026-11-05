// Loads approved contributions (ideas + resources + locations) from the unified view,
// then filters them client-side by free-text search, type, and time range. Rows are
// fetched a page at a time (not all-at-once) so the page stays fast and light even once
// there are hundreds of approved entries — "Load more" pulls the next page from Supabase
// on demand; filtering only ever runs over the pages already fetched into ALL_ITEMS.
const PAGE_SIZE = 30;
let ALL_ITEMS = [];
let nextOffset = 0;
let reachedEnd = false;
let isLoadingPage = false;

function renderItems(items) {
  const container = document.getElementById("resource-list");
  if (items.length === 0) {
    container.innerHTML = '<p class="form-note">No contributions match your filters.</p>';
    return;
  }
  container.innerHTML = items
    .map((item) => {
      const tags = (item.tags || []).map((t) => `<span class="badge">${PV.escapeHtml(t)}</span>`).join(" ");
      return `
      <div class="card">
        <span class="badge" style="margin-bottom:0.5rem;">${PV.escapeHtml(item.category || item.type)}</span>
        <h3 style="margin:0.25rem 0;">${PV.escapeHtml(item.title)}</h3>
        <p style="font-size:0.9rem;">${PV.escapeHtml(item.description)}</p>
        ${item.location ? `<p class="form-note">📍 ${PV.escapeHtml(item.location)}</p>` : ""}
        ${item.link ? `<p><a href="${PV.escapeHtml(item.link)}" target="_blank" rel="noopener">Visit link →</a></p>` : ""}
        <div style="margin:0.5rem 0;">${tags}</div>
        <div class="post-meta">${PV.escapeHtml(item.guest_name || "Guest")} · ${PV.timeAgo(item.created_at)}</div>
      </div>`;
    })
    .join("");
}

function applyFilters() {
  const search = (document.getElementById("filter-search").value || "").trim().toLowerCase();
  const type = document.getElementById("filter-type").value;
  const time = document.getElementById("filter-time").value;
  const now = Date.now();
  const timeLimits = { week: 7, month: 30, year: 365 };

  const filtered = ALL_ITEMS.filter((item) => {
    if (type !== "all" && item.type !== type) return false;
    if (time !== "all") {
      const ageDays = (now - new Date(item.created_at).getTime()) / 86400000;
      if (ageDays > timeLimits[time]) return false;
    }
    if (search) {
      const haystack = [item.title, item.description, item.category, item.location, ...(item.tags || [])]
        .filter(Boolean)
        .join(" ")
        .toLowerCase();
      if (!haystack.includes(search)) return false;
    }
    return true;
  });

  renderItems(filtered);
}

function updateLoadMoreButton() {
  const btn = document.getElementById("load-more-btn");
  if (!btn) return;
  btn.hidden = reachedEnd;
  btn.disabled = isLoadingPage;
  btn.textContent = isLoadingPage ? "Loading…" : "Load more";
}

async function loadNextPage() {
  if (isLoadingPage || reachedEnd) return;
  isLoadingPage = true;
  updateLoadMoreButton();

  const client = PV.getClient();
  const { data, error } = await client
    .from("contributions_view")
    .select("*")
    .order("created_at", { ascending: false })
    .range(nextOffset, nextOffset + PAGE_SIZE - 1);

  isLoadingPage = false;
  if (error) {
    PV.showAlert(document.getElementById("resource-load-alert"), "Could not load more resources: " + error.message, "error");
    updateLoadMoreButton();
    return;
  }

  const page = data || [];
  ALL_ITEMS = ALL_ITEMS.concat(page);
  nextOffset += page.length;
  if (page.length < PAGE_SIZE) reachedEnd = true;
  applyFilters();
  updateLoadMoreButton();
}

document.addEventListener("DOMContentLoaded", async () => {
  const container = document.getElementById("resource-list");
  const client = PV.getClient();
  if (!client) {
    container.innerHTML = '<p class="form-note">Site isn\'t configured yet — see assets/js/config.js.</p>';
    return;
  }

  await loadNextPage();

  if (ALL_ITEMS.length === 0) {
    container.innerHTML = '<p class="form-note">Nothing here yet — be the first to contribute.</p>';
    return;
  }

  document.getElementById("filter-search").addEventListener("input", applyFilters);
  document.getElementById("filter-type").addEventListener("change", applyFilters);
  document.getElementById("filter-time").addEventListener("change", applyFilters);
  const loadMoreBtn = document.getElementById("load-more-btn");
  if (loadMoreBtn) loadMoreBtn.addEventListener("click", loadNextPage);

  // A link elsewhere on the site (e.g. the Start Here guide) can deep-link into a topic
  // with ?q=search+term. Load every page first so the filter has everything to search
  // over, not just the first batch — otherwise a topic that only exists on page 2+ would
  // silently show "no matches" until someone clicked Load more themselves.
  const params = new URLSearchParams(window.location.search);
  const q = params.get("q");
  if (q) {
    while (!reachedEnd) {
      // eslint-disable-next-line no-await-in-loop
      await loadNextPage();
    }
    document.getElementById("filter-search").value = q;
    applyFilters();
    container.scrollIntoView({ behavior: "smooth", block: "start" });
  }
});
