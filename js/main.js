// MTN İzolasyon — interactivity: mobile nav, scroll-reveal, FAQ accordion, video tiles.
(function () {
  'use strict';

  /* ---- Mobile navigation toggle ---- */
  var toggle = document.querySelector('.nav-toggle');
  var nav = document.getElementById('primary-nav');
  if (toggle && nav) {
    toggle.addEventListener('click', function () {
      var open = nav.classList.toggle('is-open');
      toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
    // Close the menu after tapping a link.
    nav.addEventListener('click', function (e) {
      if (e.target.closest('a') && nav.classList.contains('is-open')) {
        nav.classList.remove('is-open');
        toggle.setAttribute('aria-expanded', 'false');
      }
    });
  }

  /* ---- Scroll reveal ---- */
  var revealEls = Array.prototype.slice.call(document.querySelectorAll('.reveal'));
  var prefersReduced = window.matchMedia &&
    window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  function show(el) { el.classList.add('is-visible'); }

  if (prefersReduced || !('IntersectionObserver' in window)) {
    revealEls.forEach(show);
  } else {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          show(entry.target);
          io.unobserve(entry.target);
        }
      });
    }, { threshold: 0.08, rootMargin: '0px 0px -6% 0px' });

    var vh = window.innerHeight || document.documentElement.clientHeight;
    revealEls.forEach(function (el) {
      // Reveal immediately anything already in (or near) the viewport on load.
      if (el.getBoundingClientRect().top < vh * 0.95) show(el);
      else io.observe(el);
    });
    // Safety net for embedded environments where IO never fires.
    setTimeout(function () { revealEls.forEach(show); io.disconnect(); }, 1600);
  }

  /* ---- FAQ accordion: keep only one item open at a time ---- */
  var faqItems = Array.prototype.slice.call(document.querySelectorAll('.faq-item'));
  faqItems.forEach(function (item) {
    item.addEventListener('toggle', function () {
      if (!item.open) return;
      faqItems.forEach(function (other) {
        if (other !== item) other.open = false;
      });
    });
  });

  /* ---- Video tiles: play button overlay + resume position ---- */
  var tiles = Array.prototype.slice.call(document.querySelectorAll('[data-video-tile]'));
  tiles.forEach(function (tile, index) {
    var video = tile.querySelector('video');
    var overlay = tile.querySelector('.video-tile__overlay');
    if (!video) return;

    function play() {
      var p = video.play();
      if (p && typeof p.catch === 'function') p.catch(function () {});
      if (overlay) overlay.classList.add('is-hidden');
    }

    if (overlay) overlay.addEventListener('click', play);

    video.addEventListener('click', function () {
      if (video.paused) play();
      else video.pause();
    });
    // Bring the big play affordance back once the clip finishes.
    video.addEventListener('ended', function () {
      if (overlay) overlay.classList.remove('is-hidden');
    });

    // Remember playback position per video (storage may be blocked/unavailable).
    var key = 'mtn_vid_' + (video.getAttribute('src') || ('tile-' + index));
    video.addEventListener('loadedmetadata', function () {
      var t = 0;
      try { t = parseFloat(localStorage.getItem(key) || '0'); } catch (e) {}
      if (t > 0 && video.duration && t < video.duration - 0.5) video.currentTime = t;
    });
    video.addEventListener('timeupdate', function () {
      if (!video.paused) {
        try { localStorage.setItem(key, String(video.currentTime)); } catch (e) {}
      }
    });
  });
})();
