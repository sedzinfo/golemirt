##########################################################################################
#
##########################################################################################
#' Response pattern of a raw score
#'
#' The pattern in which the first \code{score} of \code{n} items are answered
#' correctly, as the Estimation tabs of the app assume: a raw score of 2 on
#' five items is the pattern 11000.
#'
#' @param score Raw score, from 0 to \code{n}.
#' @param n Number of items.
#'
#' @return A numeric vector of \code{n} ones and zeros.
#'
#' @export
#'
#' @examples
#' response_pattern(2)
response_pattern <- function(score, n = 5) {
  rep(c(1, 0), c(score, n - score))
}
##########################################################################################
#
##########################################################################################
#' Simulate dichotomous responses
#'
#' Draws one response of each person to an item, correct with the probability
#' given by \code{\link{prob_4pl}()} (with \eqn{D = 1} and \eqn{d = 1}).
#'
#' @param theta Numeric vector of the abilities of the people.
#' @param a Discrimination of the item.
#' @param b Difficulty (location) of the item.
#' @param c Lower asymptote of the item.
#'
#' @return An integer vector of ones (correct) and zeros (incorrect), one for
#'   each value of \code{theta}.
#'
#' @export
#'
#' @examples
#' set.seed(1)
#' simulate_responses(seq(-3, 3, length.out = 10), a = 1, b = -0.5)
simulate_responses <- function(theta, a = 1, b = 0, c = 0) {
  stats::rbinom(length(theta), 1, prob_4pl(theta, a = a, b = b, c = c))
}
##########################################################################################
#
##########################################################################################
#' Log-likelihood surface of an item's discrimination and difficulty
#'
#' The log-likelihood of the responses of people with known abilities to one
#' item, for every combination of discrimination and difficulty on a grid,
#' under the three-parameter logistic model with a known lower asymptote (the
#' two-parameter logistic model when \code{c = 0}) and \eqn{D = 1}.
#'
#' @param responses Ones and zeros, the responses of the people.
#' @param theta Abilities of the people.
#' @param a Grid of discriminations.
#' @param b Grid of difficulties.
#' @param c Lower asymptote assumed for the item.
#'
#' @return A matrix with one row for each value of \code{a} and one column for
#'   each value of \code{b}, which keeps the two grids as its attributes
#'   \code{a} and \code{b}.
#'
#' @export
#'
#' @examples
#' set.seed(1)
#' theta <- seq(-3, 3, length.out = 50)
#' surface <- loglik_surface(simulate_responses(theta, a = 1, b = -0.5), theta)
#' surface_maximum(surface)
loglik_surface <- function(responses, theta, a = seq(-3, 3, by = 0.1), b = seq(-3, 3, by = 0.1), c = 0) {
  loglik <- matrix(0, length(a), length(b))
  for (j in seq_along(theta)) {
    z <- outer(a, theta[j] - b)
    # log(1 - P) as log(1 - c) + log(1 - logistic(z)), which stays exact when P is close to 1
    loglik <- loglik + if (responses[j] == 1) {
      log(c + (1 - c) * stats::plogis(z))
    } else {
      log(1 - c) + stats::plogis(z, lower.tail = FALSE, log.p = TRUE)
    }
  }
  structure(loglik, a = a, b = b)
}
##########################################################################################
#
##########################################################################################
#' Highest point of a log-likelihood surface
#'
#' The maximum likelihood estimates of discrimination and difficulty on the
#' grid of a surface from \code{\link{loglik_surface}()}.
#'
#' @param loglik Matrix of log-likelihoods, one row for each value of \code{a}
#'   and one column for each value of \code{b}.
#' @param a,b The grids of discriminations and difficulties of the surface; by
#'   default those that \code{\link{loglik_surface}()} keeps with it.
#'
#' @return A list with \code{a}, \code{b} and \code{loglik}, the
#'   discrimination, difficulty and log-likelihood at the highest point; at a
#'   tie, the first in column order.
#'
#' @export
#'
#' @examples
#' set.seed(1)
#' theta <- seq(-3, 3, length.out = 50)
#' surface <- loglik_surface(simulate_responses(theta, a = 1, b = -0.5), theta)
#' surface_maximum(surface)
surface_maximum <- function(loglik, a = attr(loglik, "a"), b = attr(loglik, "b")) {
  cell <- which(loglik == max(loglik), arr.ind = TRUE)[1, ]
  list(a = a[cell[1]], b = b[cell[2]], loglik = loglik[cell[1], cell[2]])
}
##########################################################################################
#
##########################################################################################
#' Log-likelihood of a response pattern under the Rasch model
#'
#' The log of the probability of the given responses to items with known
#' difficulties, at each ability,
#' \deqn{LL(\theta) = \sum_i \left[u_i (\theta - b_i) - \log(1 + \exp(\theta - b_i))\right],}{LL(theta) = sum over items of (u_i * (theta - b_i) - log(1 + exp(theta - b_i))),}
#' where \eqn{u_i} is 1 for a correct response and 0 for an incorrect one. Its
#' maximum is the maximum likelihood estimate of ability, which
#' \code{\link{newton_raphson_rasch}()} looks for.
#'
#' @param theta Numeric vector of abilities.
#' @param responses Ones and zeros, the responses to the items.
#' @param b Difficulties of the items.
#'
#' @return A numeric vector of log-likelihoods, one for each value of
#'   \code{theta}.
#'
#' @export
#'
#' @examples
#' loglik_rasch(c(-1, 0, 1), response_pattern(2), b = c(-1.90, -0.60, -0.25, 0.30, 0.45))
loglik_rasch <- function(theta, responses, b) {
  z <- outer(theta, b, "-")
  # u * z - log(1 + exp(z)) is the log of exp(u * z) / (1 + exp(z)), the probability of response u
  rowSums(sweep(z, 2, responses, "*") - log1p(exp(z)))
}
##########################################################################################
#
##########################################################################################
#' Newton-Raphson steps towards the maximum likelihood estimate of ability
#'
#' Computes the log-likelihood of a response pattern under the Rasch model on a
#' fine grid of abilities, fits a smoothing spline to it, and takes Newton-Raphson
#' steps
#' \eqn{\theta_1 = \theta_0 - LL'(\theta_0) / LL''(\theta_0)}{theta1 = theta0 - LL'(theta0) / LL''(theta0)}
#' with the derivatives of the spline, as the MLE Rasch tab of the app does.
#' For a raw score of 0 or of all items the log-likelihood has no maximum, and
#' the steps move away.
#'
#' @param responses Ones and zeros, the responses to the items.
#' @param b Difficulties of the items; the default is the five items of de
#'   Ayala (2009, p. 22).
#' @param start Starting value of the estimate.
#' @param iterations Number of steps.
#' @param theta Grid of abilities on which the log-likelihood is computed.
#'
#' @return A list with \code{theta} and \code{loglik}, the grid and its
#'   log-likelihoods, and \code{steps}, a data frame with one row per step:
#'   \code{iteration}, the number of the step;
#'   \code{start} and \code{end}, the estimates the step starts from and ends
#'   at; \code{loglik_start} and \code{loglik_end}, the log-likelihood there;
#'   \code{d1} and \code{d2}, the first and second derivatives at the start;
#'   \code{intercept} and \code{crossing}, where the tangent at the start
#'   crosses the vertical and horizontal axes; and \code{angle}, the acute
#'   angle in degrees between the tangent and the horizontal axis.
#'
#' @references de Ayala, R. J. (2009). \emph{The Theory and Practice of Item
#'   Response Theory}. New York: Guilford Press.
#'
#' @export
#'
#' @examples
#' nr <- newton_raphson_rasch(response_pattern(2), iterations = 5)
#' nr$steps[, c("start", "end")]
newton_raphson_rasch <- function(responses, b = c(-1.90, -0.60, -0.25, 0.30, 0.45), start = 0, iterations = 1,
                                 theta = seq(-6, 6, by = 0.001)) {
  loglik <- loglik_rasch(theta, responses, b)
  spline <- stats::smooth.spline(theta, loglik)
  steps <- vector("list", iterations)
  for (i in seq_len(iterations)) {
    y0 <- stats::predict(spline, x = start, deriv = 0)$y
    d1 <- stats::predict(spline, x = start, deriv = 1)$y
    d2 <- stats::predict(spline, x = start, deriv = 2)$y
    end <- start - d1 / d2
    intercept <- y0 - d1 * start
    crossing <- -intercept / d1
    steps[[i]] <- data.frame(
      iteration = i,
      start = start,
      end = end,
      loglik_start = y0,
      loglik_end = stats::predict(spline, x = end, deriv = 0)$y,
      d1 = d1,
      d2 = d2,
      intercept = intercept,
      crossing = crossing,
      angle = atan(y0 / (crossing - start)) * 180 / pi
    )
    start <- end
  }
  list(theta = theta, loglik = loglik, steps = do.call(rbind, steps))
}
##########################################################################################
#
##########################################################################################
#' Prior weights at quadrature points
#'
#' The density of a skew-normal prior (\code{fGarch::dsnorm()}, which is the
#' normal density when \code{skew = 1}) at the quadrature points, rescaled to
#' sum to 1.
#'
#' @param x Quadrature points.
#' @param mean,sd Mean and standard deviation of the prior.
#' @param skew Skewness parameter of the prior, \code{xi} in
#'   \code{fGarch::dsnorm()}.
#'
#' @return A numeric vector of weights, one for each value of \code{x}.
#'
#' @export
#'
#' @examples
#' prior_weights(seq(-4, 4, length.out = 10))
prior_weights <- function(x, mean = 0, sd = 1, skew = 1) {
  density <- fGarch::dsnorm(x, mean = mean, sd = sd, xi = skew)
  density / sum(density)
}
##########################################################################################
#
##########################################################################################
#' EAP and MAP estimates of ability by quadrature
#'
#' Bayesian estimation of a person's ability from a response pattern, at
#' quadrature points \eqn{X_r} spread evenly from -4 to 4. With prior weights
#' \eqn{A(X_r)} and likelihood \eqn{L(X_r)}, the expected a posteriori estimate
#' \deqn{EAP = \frac{\sum_r X_r L(X_r) A(X_r)}{\sum_r L(X_r) A(X_r)}}{EAP = sum(X_r * L(X_r) * A(X_r)) / sum(L(X_r) * A(X_r))}
#' is the mean of the posterior distribution, and the maximum a posteriori
#' estimate is the quadrature point where the posterior
#' \eqn{L(X_r) A(X_r)} is highest. The defaults replicate de Ayala (2009,
#' p. 79).
#'
#' @param responses Ones and zeros, the responses to the items.
#' @param b Difficulties of the items; the default is the five items of de
#'   Ayala (2009, Table 4.4).
#' @param a Discriminations of the items: 1 for the Rasch model.
#' @param quadrature Number of quadrature points.
#' @inheritParams prior_weights
#'
#' @return A list with \code{x}, the quadrature points; \code{prior}, the prior
#'   weights; \code{trace}, the probability of each observed response at each
#'   point (one column per item); \code{likelihood}; \code{posterior}, the
#'   product of prior and likelihood; \code{eap}, \code{psd} (the posterior
#'   standard deviation) and \code{map}; and \code{responses} and
#'   \code{prior_mean}, as given.
#'
#' @references de Ayala, R. J. (2009). \emph{The Theory and Practice of Item
#'   Response Theory}. New York: Guilford Press.
#'
#' @export
#'
#' @examples
#' estimate <- eap_map(response_pattern(2))
#' c(EAP = estimate$eap, MAP = estimate$map)
eap_map <- function(responses, b = c(-2.155, -0.245, 0.206, 0.984, 1.211), a = rep(1, length(b)),
                    quadrature = 10, mean = 0, sd = 1, skew = 1) {
  x <- seq(-4, 4, length.out = quadrature)
  prior <- prior_weights(x, mean = mean, sd = sd, skew = skew)
  trace <- vapply(seq_along(b), function(i) {
    p <- prob_4pl(x, a = a[i], b = b[i])
    if (responses[i] == 1) p else 1 - p
  }, numeric(length(x)))
  likelihood <- apply(trace, 1, prod)
  posterior <- prior * likelihood
  eap <- sum(x * posterior) / sum(posterior)
  list(
    x = x,
    prior = prior,
    trace = trace,
    likelihood = likelihood,
    posterior = posterior,
    eap = eap,
    psd = sqrt(sum((x - eap)^2 * posterior) / sum(posterior)),
    map = x[which.max(posterior)],
    responses = responses,
    prior_mean = mean
  )
}
