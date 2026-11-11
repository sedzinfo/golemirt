// Phones and touch screens. Desktop browsers, with a mouse, are not changed.
//
// - The collapsed navbar (narrow screens) closes when a tab is chosen, as Bootstrap leaves it open
//   over the page.
// - Touch screens: on a 2D chart, plotly's default drag (zoom) takes the finger, so the page cannot be
//   scrolled over the chart, and a chart fills most of a phone's screen. There, dragging is switched
//   off (tapping still shows the values, two fingers still zoom). 3D charts keep it, as turning them
//   is what they are for.
// - Small touch screens (narrower than 768px, or lower than 600px, a phone held sideways): the
//   legend, which the charts put inside the plot at the top left, where it covers curves, goes under
//   the chart; mobile.css hides plotly's toolbar there.
// - Where bslib stacks a sidebar above its page (narrower than 576px: the settings of CAT), the main
//   button of the sidebar (Start) scrolls to the page below, where the test begins.
(function() {
  $(function() {
    $(document).on('click', '.navbar-collapse.show a[data-value]:not(.dropdown-toggle)', function() {
      const collapse = $(this).closest('.navbar-collapse')[0];
      if (window.bootstrap && bootstrap.Collapse) bootstrap.Collapse.getOrCreateInstance(collapse).hide();
    });
    const stacked = window.matchMedia && window.matchMedia('(max-width: 575.98px)');
    $(document).on('click', '.bslib-sidebar-layout > .sidebar .btn-primary', function() {
      if (!stacked || !stacked.matches) return;
      const main = $(this).closest('.bslib-sidebar-layout').children('.main')[0];
      // after the server has drawn the first question
      if (main) setTimeout(function() { main.scrollIntoView({ behavior: 'smooth', block: 'start' }); }, 400);
    });
  });

  if (!window.matchMedia || !window.matchMedia('(pointer: coarse)').matches) return;
  const small = window.matchMedia('(max-width: 767.98px), (max-height: 600px)');

  const relax = function(gd) {
    if (!window.Plotly || !gd._fullLayout) return;
    const full = gd._fullLayout;
    const update = {};
    const is3d = Object.keys(full).some(function(k) { return /^scene\d*$/.test(k); });
    if (!is3d && full.dragmode !== false) update.dragmode = false;
    if (small.matches && !is3d && full.showlegend && (full.legend || {}).orientation !== 'h') {
      update['legend.orientation'] = 'h';
      update['legend.x'] = 0;
      update['legend.xanchor'] = 'left';
      // about 58px under the plot, below the title of the x axis, whatever the chart's height
      update['legend.y'] = -Math.min(0.4, 58 / full._size.h);
      update['legend.yanchor'] = 'top';
    }
    // only when something changes, as relayout draws the chart again (and fires plotly_afterplot)
    if (Object.keys(update).length) Plotly.relayout(gd, update);
  };

  $(function() {
    // every chart, also when it is drawn again after a slider moves
    $(document).on('plotly_afterplot', '.js-plotly-plot', function() { relax(this); });
  });
})();
