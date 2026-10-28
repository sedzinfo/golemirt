// Dark mode: a moon/sun button at the right of the navbar switches the pages between light and dark.
// Bootstrap 5 restyles the page itself from data-bs-theme on <html>, and on the navbar, which sets its
// own; dark_mode.css styles the 2D charts, and the axes of the 3D charts, which WebGL draws out of the
// reach of CSS, are recolored here through plotly. The choice is remembered; without one, the setting
// of the system is followed.
(function() {
  const key = 'dark-mode';
  const saved = (function() { try { return localStorage.getItem(key); } catch (e) { return null; } })();
  const dark = saved === null ? window.matchMedia('(prefers-color-scheme: dark)').matches : saved === 'true';
  const theme = function(on) { return on ? 'dark' : 'light'; };
  const isDark = function() { return document.documentElement.classList.contains('dark-mode'); };
  // set before the page is drawn, so that it does not flash white
  document.documentElement.classList.toggle('dark-mode', dark);
  document.documentElement.setAttribute('data-bs-theme', theme(dark));

  // the axes of the 3D charts: light in dark mode, plotly's own colors otherwise
  const sceneColors = function(gd) {
    if (!gd._fullLayout || !window.Plotly) return;
    const on = isDark();
    const update = {};
    Object.keys(gd._fullLayout).filter(function(k) { return /^scene\d*$/.test(k); }).forEach(function(scene) {
      ['xaxis', 'yaxis', 'zaxis'].forEach(function(axis) {
        const color = ((gd.layout[scene] || {})[axis] || {}).color;
        // only when it changes, as relayout draws the chart again
        if (on ? color !== '#ddd' : color !== undefined) {
          update[scene + '.' + axis + '.color'] = on ? '#ddd' : null;
          update[scene + '.' + axis + '.gridcolor'] = on ? '#555' : null;
        }
      });
    });
    if (Object.keys(update).length) Plotly.relayout(gd, update);
  };

  $(function() {
    const navbar = $('nav.navbar').attr('data-bs-theme', theme(isDark()));
    const button = $('<a href="#" id="dark-mode-toggle" class="nav-link"></a>');
    const label = function() {
      const on = isDark();
      button.html(on ? '&#9728;' : '&#9790;').attr('title', on ? 'Light mode' : 'Dark mode');
    };
    label();
    button.on('click', function(e) {
      e.preventDefault();
      const on = document.documentElement.classList.toggle('dark-mode');
      document.documentElement.setAttribute('data-bs-theme', theme(on));
      navbar.attr('data-bs-theme', theme(on));
      try { localStorage.setItem(key, on); } catch (err) {}
      label();
      $('.js-plotly-plot').each(function() { sceneColors(this); });
    });
    // inside the collapsing part of the navbar, so that it sits on the row of the menus, at the right;
    // bslib lets each list of the navbar grow (flex-grow 1), which flex-grow-0 stops for this one
    let collapse = $('.navbar .navbar-collapse').first();
    if (!collapse.length) collapse = $('.navbar .container-fluid').first();
    collapse.append($('<ul class="nav navbar-nav ms-auto flex-grow-0"></ul>').append($('<li class="nav-item"></li>').append(button)));
    // a 3D chart drawn later, or drawn again
    $(document).on('plotly_afterplot', '.js-plotly-plot', function() { sceneColors(this); });
  });
})();
