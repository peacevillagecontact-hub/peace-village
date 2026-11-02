// Loads approved contributions (ideas + resources + locations) from the unified view.

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
  if (!data || data.length === 0) {
    container.innerHTML = '<p class="form-note">Nothing here yet — be the first to contribute.</p>';
    return;
  }

  container.innerHTML = data
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
});
