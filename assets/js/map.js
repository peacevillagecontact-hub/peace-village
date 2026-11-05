// Loads approved locations that have map coordinates and plots them with Leaflet + OpenStreetMap
// tiles (no API key needed). Locations submitted without coordinates still show up as text
// elsewhere on the site — this page only plots the subset that has a pin.

document.addEventListener("DOMContentLoaded", async () => {
  const mapEl = document.getElementById("map");
  const statusEl = document.getElementById("map-status");
  const client = PV.getClient();

  if (!client) {
    mapEl.innerHTML = '<p class="form-note" style="padding:1rem;">Site isn\'t configured yet — see assets/js/config.js.</p>';
    return;
  }

  const { data, error } = await client
    .from("locations")
    .select("id, name, address, description, tags, latitude, longitude")
    .eq("status", "approved")
    .not("latitude", "is", null)
    .not("longitude", "is", null);

  if (error) {
    statusEl.textContent = "Could not load map locations: " + error.message;
    statusEl.className = "alert show alert-error";
    return;
  }

  const points = data || [];
  if (points.length === 0) {
    statusEl.textContent = "No pinned locations yet — be the first to add one on the Contribute page.";
    statusEl.className = "alert show alert-success";
    return;
  }

  // Centered on the average of all pins by default, World view as a fallback, then Leaflet's
  // fitBounds below adjusts the zoom so every pin is actually visible.
  const avgLat = points.reduce((sum, p) => sum + Number(p.latitude), 0) / points.length;
  const avgLng = points.reduce((sum, p) => sum + Number(p.longitude), 0) / points.length;

  const map = L.map("map").setView([avgLat, avgLng], 4);
  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 18,
    attribution: '© <a href="https://www.openstreetmap.org/copyright" target="_blank" rel="noopener">OpenStreetMap</a> contributors',
  }).addTo(map);

  const markers = [];
  points.forEach((p) => {
    const tags = (p.tags || []).map((t) => `<span class="badge">${PV.escapeHtml(t)}</span>`).join(" ");
    const popupHtml = `
      <div class="map-popup">
        <h3>${PV.escapeHtml(p.name)}</h3>
        ${p.address ? `<p>📍 ${PV.escapeHtml(p.address)}</p>` : ""}
        ${p.description ? `<p>${PV.escapeHtml(p.description)}</p>` : ""}
        <div>${tags}</div>
      </div>`;
    const marker = L.marker([Number(p.latitude), Number(p.longitude)]).addTo(map).bindPopup(popupHtml);
    markers.push(marker);
  });

  if (markers.length > 1) {
    map.fitBounds(L.featureGroup(markers).getBounds(), { padding: [30, 30] });
  }

  statusEl.textContent = `Showing ${points.length} location${points.length === 1 ? "" : "s"} on the map.`;
  statusEl.className = "alert show alert-success";
});
