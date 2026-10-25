theta <- seq(-6, 6, by = 0.1)
grid <- seq(-4, 4, length.out = 50)

test_that("every plot builds without warnings", {
  set.seed(3)
  people <- seq(-3, 3, length.out = 50)
  responses <- simulate_responses(people, a = 1, b = -0.5, c = 0.4)
  surfaces <- lapply(c(0.1, 0.4), function(guess) loglik_surface(responses, people, c = guess))
  estimate <- eap_map(response_pattern(2))
  plots <- list(
    plot_category_curves(theta, prob_gpcm(theta), "Partial Credit Model"),
    plot_category_curves(theta, cbind("1" = prob_4pl(theta)), "Rasch Model", ylab = "P(x)"),
    plot_tirt(theta, prob_tirt(theta)),
    plot_mirt_surface(grid, grid, prob_mirt(grid, grid)),
    plot_mirt_contour(grid, grid, prob_mirt(grid, grid), level = 0.5, arrow = item_vector()),
    plot_newton_raphson(newton_raphson_rasch(response_pattern(2), iterations = 3)),
    plot_loglik_surface(loglik_surface(responses, people)),
    plot_loglik_surfaces(surfaces, guesses = c(0.1, 0.4)),
    plot_prior(estimate),
    plot_tracelines(estimate),
    plot_likelihood(estimate),
    plot_posterior(estimate),
    plot_eap_combined(estimate)
  )
  for (p in plots) {
    expect_s3_class(p, "plotly")
    expect_no_warning(plotly::plotly_build(p))
  }
})

test_that("the category curves have one trace per category, in order, and the gray line at 0.5", {
  built <- plotly::plotly_build(plot_category_curves(theta, prob_grm(theta), "Graded Response Model"))$x
  expect_equal(vapply(built$data, function(trace) trace$name, ""), paste0("P(X=", 1:5, "|theta)"))
  expect_equal(built$layout$shapes[[1]]$y0, 0.5)
  expect_equal(built$layout$title$text, "Graded Response Model")
})

test_that("a subtitle goes on a second, smaller line of the title, with room above the plot", {
  built <- plotly::plotly_build(plot_category_curves(theta, prob_nrm(theta), "NRM", subtitle = "Note"))$x
  expect_equal(built$layout$title$text, "NRM<br><sup>Note</sup>")
  expect_equal(built$layout$margin$t, 60)
})

test_that("the contour plot draws the halfway line and the item vector only when they fit", {
  with <- plotly::plotly_build(plot_mirt_contour(grid, grid, prob_mirt(grid, grid), level = 0.5, arrow = item_vector()))$x
  expect_length(with$data, 2)
  expect_length(with$layout$annotations, 1)
  easy <- prob_mirt(grid, grid, b = c(-10, -10)) # above 0.5 everywhere on the grid
  without <- plotly::plotly_build(
    plot_mirt_contour(grid, grid, easy, level = 0.5, arrow = item_vector(b = c(-10, -10)))
  )$x
  expect_length(without$data, 1)
  expect_length(without$layout$annotations, 0)
})

test_that("each 3PL surface and its maximum share a legend group", {
  set.seed(4)
  people <- seq(-3, 3, length.out = 50)
  responses <- simulate_responses(people, a = 1, b = -0.5, c = 0.4)
  guesses <- c(0.05, 0.3, 0.6)
  surfaces <- lapply(guesses, function(guess) loglik_surface(responses, people, c = guess))
  built <- plotly::plotly_build(plot_loglik_surfaces(surfaces, guesses = guesses))$x
  expect_equal(vapply(built$data, function(trace) trace$legendgroup, ""), rep(paste0("c=", guesses), each = 2))
  expect_equal(vapply(built$data, function(trace) trace$type, ""), rep(c("surface", "scatter3d"), 3))
})

test_that("the Newton-Raphson plot shades the angle only away from the maximum", {
  far <- plotly::plotly_build(plot_newton_raphson(newton_raphson_rasch(response_pattern(2), iterations = 1)))$x
  near <- plotly::plotly_build(plot_newton_raphson(newton_raphson_rasch(response_pattern(2), iterations = 5)))$x
  expect_length(far$data, 5)
  expect_length(near$data, 4)
})
