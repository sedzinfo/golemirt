theta <- seq(-6, 6, by = 0.1)

test_that("the 4PL reaches its asymptotes, and their midpoint at the difficulty", {
  expect_equal(prob_4pl(0), 0.5)
  expect_equal(prob_4pl(c(-100, 100), c = 0.2, d = 0.9), c(0.2, 0.9))
  expect_equal(prob_4pl(1, b = 1, c = 0.2, d = 0.9), 0.55)
  expect_equal(prob_4pl(1, a = 2, D = 1.702), stats::plogis(3.404))
})

test_that("the polytomous models give one column per category, with probabilities that sum to 1", {
  probs <- list(prob_gpcm(theta), prob_grm(theta), prob_grsm(theta), prob_nrm(theta))
  for (p in probs) {
    expect_equal(dim(p), c(length(theta), 5))
    expect_equal(rowSums(p), rep(1, length(theta)))
    expect_true(all(p >= 0))
  }
  expect_equal(colnames(prob_gpcm(theta)), as.character(1:5))
  expect_equal(colnames(prob_nrm(theta)), letters[1:5])
})

test_that("adjacent partial credit curves cross at the step parameters", {
  steps <- c(-2, -0.75, 0.75, 2)
  p <- unname(prob_gpcm(steps, a = 1.3, steps = steps))
  for (k in 1:4) expect_equal(p[k, k], p[k, k + 1])
})

test_that("the rating scale model is the partial credit model with steps b + thresholds", {
  expect_equal(
    prob_grsm(theta, a = 2, b = 0.5, thresholds = c(-1, 0, 1)),
    prob_gpcm(theta, a = 2, steps = c(-0.5, 0.5, 1.5))
  )
})

test_that("the outer graded response curves cross 0.5 at the outer difficulties", {
  b <- c(-2, -0.75, 0.75, 2)
  expect_equal(unname(prob_grm(-2, b = b)[, 1]), 0.5)
  expect_equal(unname(prob_grm(2, b = b)[, 5]), 0.5)
})

test_that("each nominal category is as likely as the reference category at its difficulty", {
  a <- c(-4, -2, 2, 4)
  b <- c(-3, -1, 1, 3)
  p <- unname(prob_nrm(b, a = a, b = b))
  for (k in 1:4) expect_equal(p[k, 1], p[k, k + 1])
})

test_that("the divide-by-total models stay finite for extreme parameters", {
  expect_false(anyNA(prob_gpcm(theta, a = 10, steps = rep(-10, 4), D = 1.702)))
  expect_false(anyNA(prob_grsm(theta, a = -10, b = 10, D = 1.702)))
  expect_false(anyNA(prob_nrm(theta, a = c(10, -10, 10, -10), D = 1.702)))
})

test_that("the three Thurstonian forms agree and cross 0.5 where their argument is 0", {
  eta <- seq(-6, 6, by = 0.5)
  scale <- sqrt(0.3 + 0.7)
  expect_equal(
    prob_tirt_pair(eta, gamma = 0.5, lambda_i = 1, lambda_k = 0.2, psi_i = 0.3, psi_k = 0.7),
    prob_tirt_intercept(eta, alpha = -0.5 / scale, beta_i = 1 / scale, beta_k = 0.2 / scale)
  )
  expect_equal(prob_tirt(2, gamma = 1, lambda = 0.5), 0.5)
  expect_equal(prob_tirt_pair(eta, lambda_i = 0.4, lambda_k = 0.4), rep(0.5, length(eta)))
})

test_that("the compensatory surface depends on the weighted sum, the non-compensatory one on both abilities", {
  grid <- seq(-4, 4, length.out = 9)
  compensatory <- prob_mirt(grid, grid, a = c(1, 1), b = c(0, 0), D = 1)
  expect_equal(compensatory[1, 9], 0.5) # theta1 = -4, theta2 = 4
  expect_equal(prob_mirt(1, -2, b = c(1, -2), c = 0.2, d = 0.8), matrix(0.5))
  expect_equal(prob_mirt(1, -2, b = c(1, -2), c = 0.2, d = 0.8, compensatory = FALSE), matrix(0.2 + 0.6 / 4))
  expect_equal(dim(prob_mirt(grid, grid[1:3])), c(9, 3))
})

test_that("info_mirt() is the squared gradient of the surface divided by P(1 - P)", {
  h <- 1e-5
  t1 <- c(-1, 0.3, 1.2)
  t2 <- c(-0.5, 0.8)
  for (compensatory in c(TRUE, FALSE)) {
    surface <- function(x, y) prob_mirt(x, y, a = c(1.4, 0.6), b = c(0.2, -0.3), c = 0.1, d = 0.95, compensatory = compensatory)
    p <- surface(t1, t2)
    d1 <- (surface(t1 + h, t2) - surface(t1 - h, t2)) / (2 * h)
    d2 <- (surface(t1, t2 + h) - surface(t1, t2 - h)) / (2 * h)
    expect_equal(
      info_mirt(t1, t2, a = c(1.4, 0.6), b = c(0.2, -0.3), c = 0.1, d = 0.95, compensatory = compensatory),
      (d1^2 + d2^2) / (p * (1 - p)),
      tolerance = 1e-6
    )
  }
  expect_true(all(info_mirt(t1, t2, c = 0.5, d = 0.5) == 0))
})

test_that("the item vector starts on the halfway line and points along the discriminations", {
  a <- c(2, 0.5)
  b <- c(1, -1)
  arrow <- item_vector(a, b)
  expect_equal(arrow$discrimination, sqrt(4.25))
  expect_equal(prob_mirt(arrow$start[1], arrow$start[2], a = a, b = b, c = 0.2, d = 1), matrix(0.6))
  expect_equal((arrow$end - arrow$start) / arrow$discrimination, a / arrow$discrimination)
  expect_equal(item_vector(), list(start = c(0, 0), end = c(1, 1), discrimination = sqrt(2), difficulty = 0))
})

test_that("model_name_4pl() names the model that the parameters define", {
  expect_equal(model_name_4pl(a = 1, c = 0, d = 1), "Rasch Model")
  expect_equal(model_name_4pl(a = 2, c = 0, d = 1), "1PL or 2PL Model")
  expect_equal(model_name_4pl(a = 1, c = 0.2, d = 1), "3PL Model")
  expect_equal(model_name_4pl(a = 1, c = 0, d = 0.9), "4PL Model (c = 0)")
  expect_equal(model_name_4pl(a = 1, c = 0.2, d = 0.9), "4PL Model")
})
