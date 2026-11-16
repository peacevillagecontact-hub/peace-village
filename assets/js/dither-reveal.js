// Peace Village — cursor dither-reveal.
//
// Every element with class "dither-reveal" holds two stacked <img> layers: a plain
// ".color-layer" image defining the box, and a ".dither-layer" (dithered/colorless) image
// absolutely positioned on top. A CSS radial-gradient mask on the dither layer (driven by the
// --mx/--my/--r custom properties set below) carves out a circular window around the cursor,
// so the true-color layer underneath shows through only there; everywhere else stays dithered.
// On mouse-leave the window eases shut again. Vanilla JS, no framework, no dependencies —
// reimplemented from scratch for the live site. Visual technique only, credited on the About page.
(function () {
  "use strict";

  function initReveal(el) {
    var closeRaf = null;
    var radius = parseFloat(el.getAttribute("data-reveal-size")) || 24; // % of element size

    function setVars(mx, my, r) {
      el.style.setProperty("--mx", mx + "%");
      el.style.setProperty("--my", my + "%");
      el.style.setProperty("--r", r + "%");
    }

    function positionFromEvent(e) {
      var rect = el.getBoundingClientRect();
      var mx = ((e.clientX - rect.left) / rect.width) * 100;
      var my = ((e.clientY - rect.top) / rect.height) * 100;
      return { mx: mx, my: my };
    }

    function stopClosing() {
      if (closeRaf) {
        cancelAnimationFrame(closeRaf);
        closeRaf = null;
      }
    }

    el.addEventListener("mouseenter", function (e) {
      stopClosing();
      var p = positionFromEvent(e);
      setVars(p.mx, p.my, radius);
    });

    el.addEventListener("mousemove", function (e) {
      var p = positionFromEvent(e);
      setVars(p.mx, p.my, radius);
    });

    el.addEventListener("mouseleave", function (e) {
      stopClosing();
      var p = positionFromEvent(e);
      var start = radius;
      var startTime = performance.now();
      var duration = 280;

      function tick(now) {
        var t = Math.min(1, (now - startTime) / duration);
        var eased = 1 - Math.pow(1 - t, 3); // cubic ease-out
        var r = start * (1 - eased);
        setVars(p.mx, p.my, r);
        if (t < 1) {
          closeRaf = requestAnimationFrame(tick);
        } else {
          closeRaf = null;
        }
      }
      closeRaf = requestAnimationFrame(tick);
    });

    // Touch devices get no hover; show the real color image outright rather than an
    // unreachable dithered one.
    if (window.matchMedia && window.matchMedia("(hover: none)").matches) {
      setVars(50, 50, 150);
    }
  }

  function init() {
    var els = document.querySelectorAll(".dither-reveal");
    for (var i = 0; i < els.length; i++) initReveal(els[i]);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
