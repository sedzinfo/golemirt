test_that("response_pattern() answers the first items correctly", {
  expect_equal(response_pattern(2), c(1, 1, 0, 0, 0))
  expect_equal(response_pattern(0), rep(0, 5))
  expect_equal(response_pattern(3, n = 3), rep(1, 3))
})

test_that("simulate_responses() draws one response of each person", {
  set.seed(1)
  responses <- simulate_responses(seq(-3, 3, length.out = 50), a = 1, b = -0.5, c = 0.4)
  expect_length(responses, 50)
  expect_true(all(responses %in% c(0, 1)))
  expect_equal(simulate_responses(c(-50, 50), a = 1, b = 0), c(0, 1))
})

test_that("loglik_surface() matches the cell-by-cell computation of mleirt", {
  set.seed(2)
  theta <- seq(-3, 3, length.out = 50)
  a <- seq(-3, 3, by = 0.5)
  b <- seq(-3, 3, by = 0.75)
  for (c in c(0, 0.25)) {
    responses <- simulate_responses(theta, a = 1, b = -0.5, c = c)
    cell_by_cell <- matrix(NA, length(a), length(b))
    for (m in seq_along(a)) {
      for (n in seq_along(b)) {
        p <- c + (1 - c) * exp(a[m] * (theta - b[n])) / (1 + exp(a[m] * (theta - b[n])))
        cell_by_cell[m, n] <- sum(log(ifelse(responses == 1, p, 1 - p)))
      }
    }
    surface <- loglik_surface(responses, theta, a, b, c = c)
    expect_equal(surface, cell_by_cell, ignore_attr = TRUE)
    expect_equal(attr(surface, "a"), a)
    expect_equal(attr(surface, "b"), b)
  }
})

test_that("surface_maximum() finds the highest cell", {
  loglik <- matrix(c(-5, -3, -4, -1, -2, -6), nrow = 2)
  expect_equal(surface_maximum(loglik, a = c(0.5, 1), b = c(-1, 0, 1)), list(a = 1, b = 0, loglik = -1))
})

test_that("loglik_rasch() is the log of the product of the response probabilities", {
  b <- c(-1, 0, 1)
  responses <- c(1, 0, 1)
  p <- stats::plogis(0.3 - b)
  expect_equal(loglik_rasch(0.3, responses, b), sum(log(ifelse(responses == 1, p, 1 - p))))
})

test_that("the Newton-Raphson steps converge on the maximum likelihood estimate", {
  b <- c(-1.90, -0.60, -0.25, 0.30, 0.45)
  for (score in 1:4) {
    responses <- response_pattern(score)
    exact <- stats::uniroot(function(t) sum(responses - stats::plogis(t - b)), c(-6, 6), tol = 1e-10)$root
    steps <- newton_raphson_rasch(responses, start = 0, iterations = 5)$steps
    expect_equal(nrow(steps), 5)
    expect_equal(steps$end[5], exact, tolerance = 1e-3)
    expect_lt(abs(steps$angle[5]), 1)
    expect_equal(steps$start[-1], steps$end[-5])
  }
})

test_that("the Newton-Raphson steps move away for zero and perfect scores", {
  expect_true(all(diff(newton_raphson_rasch(response_pattern(0), iterations = 4)$steps$end) < 0))
  expect_true(all(diff(newton_raphson_rasch(response_pattern(5), iterations = 4)$steps$end) > 0))
})

test_that("prior_weights() is the normalized normal density when the skewness is 1", {
  x <- seq(-4, 4, length.out = 10)
  expect_equal(prior_weights(x), stats::dnorm(x) / sum(stats::dnorm(x)))
  expect_equal(sum(prior_weights(x, mean = 1, sd = 0.5, skew = 1.5)), 1)
})

test_that("eap_map() finds the posterior mean and mode", {
  estimate <- eap_map(response_pattern(2))
  expect_length(estimate$x, 10)
  expect_equal(estimate$trace[, 1], stats::plogis(estimate$x + 2.155)) # item 1 answered correctly
  expect_equal(estimate$trace[, 5], 1 - stats::plogis(estimate$x - 1.211)) # item 5 answered incorrectly
  expect_equal(estimate$likelihood, apply(estimate$trace, 1, prod))
  expect_equal(estimate$eap, sum(estimate$x * estimate$posterior) / sum(estimate$posterior))
  expect_equal(estimate$map, estimate$x[which.max(estimate$posterior)])
  expect_equal(estimate$prior_mean, 0)
})

test_that("a narrower prior pulls the EAP towards the prior mean, and EAP stays finite for extreme scores", {
  expect_lt(abs(eap_map(response_pattern(4), sd = 0.5)$eap), abs(eap_map(response_pattern(4), sd = 2)$eap))
  expect_true(is.finite(eap_map(response_pattern(0))$eap))
  expect_true(is.finite(eap_map(response_pattern(5))$eap))
})
