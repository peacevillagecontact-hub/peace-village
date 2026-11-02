// Loads approved contributions (ideas + resources + locations) from the unified view,
// then filters them client-side by free-text search, type, and time range — no extra
// network round-trips, since the whole (small, moderation-gated) dataset is already in hand.

let ALL_ITEMS = [];

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

document.addEventListener("DOMContentLoaded", async () => {
  const container = document.getElementById("resource-list");
  const client = PV.getClient();
  if (!client) {
    container.innerHTML = '<p class="form-note">Site isn\'t configured yet — see assets/js/config.js.</p>';
    return;
  }

  const { data, error } = await client
    .from("contributions_view")
    .select("*")
    .order("created_at", { ascending: false })
    .limit(100);

  if (error) {
    container.innerHTML = '<p class="form-note">Could not load resources: ' + PV.escapeHtml(error.message) + "</p>";
    return;
  }

  ALL_ITEMS = data || [];
  if (ALL_ITEMS.length === 0) {
    container.innerHTML = '<p class="form-note">Nothing here yet — be the first to contribute.</p>';
    return;
  }

  renderItems(ALL_ITEMS);

  document.getElementById("filter-search").addEventListener("input", applyFilters);
  document.getElementById("filter-type").addEventListener("change", applyFilters);
  document.getElementById("filter-time").addEventListener("change", applyFilters);
});
