##########################################################################################
#
##########################################################################################
#' Four-parameter logistic item response function
#'
#' The probability of a correct (or keyed) response to a dichotomous item,
#' \deqn{P(X = 1 \mid \theta) = c + \frac{d - c}{1 + \exp(-D a (\theta - b))},}{P(X = 1 | theta) = c + (d - c) / (1 + exp(-D * a * (theta - b))),}
#' which is the Rasch model when \eqn{a = 1}, \eqn{c = 0} and \eqn{d = 1}, the
#' 2PL when \eqn{c = 0} and \eqn{d = 1}, and the 3PL when \eqn{d = 1}.
#'
#' @param theta Numeric vector of abilities.
#' @param a Discrimination.
#' @param b Difficulty (location).
#' @param c Lower asymptote (guessing).
#' @param d Upper asymptote (inattentiveness).
#' @param D Scaling constant: 1 keeps the logistic metric, and 1.702 makes the
#'   curve almost coincide with the normal ogive.
#'
#' @return A numeric vector of probabilities, one for each value of
#'   \code{theta}.
#'
#' @export
#'
#' @examples
#' prob_4pl(c(-2, 0, 2))
#' prob_4pl(c(-2, 0, 2), a = 1.5, b = 0.5, c = 0.2, D = 1.702)
prob_4pl <- function(theta, a = 1, b = 0, c = 0, d = 1, D = 1) {
  c + (d - c) / (1 + exp(-D * a * (theta - b)))
}
##########################################################################################
#
##########################################################################################
#' Probabilities from category exponents
#'
#' Turns each row of exponents \eqn{z_k} into the probabilities
#' \eqn{\exp(z_k) / \sum_h \exp(z_h)}{exp(z_k) / sum(exp(z_h))}, which sum to 1.
#' The row maximum is subtracted first, so that large exponents do not
#' overflow.
#'
#' @param z Numeric matrix, one row per ability and one column per category.
#'
#' @return A matrix of the same size as \code{z}.
#'
#' @noRd
#'
#' @examples
#' divide_by_total(cbind(0, c(-1, 0, 1)))
divide_by_total <- function(z) {
  e <- exp(z - apply(z, 1, max))
  e / rowSums(e)
}
##########################################################################################
#
##########################################################################################
#' Category response curves of the generalized partial credit model
#'
#' The probabilities of the categories \eqn{1, \ldots, m + 1}{1, ..., m + 1} of
#' an item with \eqn{m} step parameters,
#' \deqn{P(X = k \mid \theta) = \frac{\exp\left(\sum_{v=1}^{k-1} D a (\theta - \delta_v)\right)}{\sum_{h=1}^{m+1} \exp\left(\sum_{v=1}^{h-1} D a (\theta - \delta_v)\right)},}{P(X = k | theta) = exp(sum over v = 1, ..., k - 1 of D * a * (theta - delta_v)) / (sum over h = 1, ..., m + 1 of exp(sum over v = 1, ..., h - 1 of D * a * (theta - delta_v))),}
#' where an empty sum is 0. With \eqn{a = 1} this is the partial credit model
#' (Masters, 1982), otherwise the generalized partial credit model (Muraki,
#' 1992). The curves of categories \eqn{k} and \eqn{k + 1} cross at
#' \eqn{\theta = \delta_k}{theta = delta_k}.
#'
#' @inheritParams prob_4pl
#' @param steps Step parameters \eqn{\delta_1, \ldots, \delta_m}{delta_1, ..., delta_m}.
#'
#' @return A matrix with one row for each value of \code{theta} and one column
#'   for each category, named \code{1} to \code{m + 1}.
#'
#' @references Masters, G. N. (1982). A Rasch model for partial credit scoring.
#'   \emph{Psychometrika}, 47(2), 149-174.
#'
#'   Muraki, E. (1992). A generalized partial credit model: Application of an EM
#'   algorithm. \emph{Applied Psychological Measurement}, 16(2), 159-176.
#'
#' @export
#'
#' @examples
#' prob_gpcm(c(-2, 0, 2))
#' prob_gpcm(c(-2, 0, 2), a = 1.5, steps = c(-1, 0, 1))
prob_gpcm <- function(theta, a = 1, steps = c(-2, -0.75, 0.75, 2), D = 1) {
  z <- D * a * outer(theta, steps, "-")
  # the exponent of each category sums the steps up to it
  for (k in seq_along(steps)[-1]) z[, k] <- z[, k - 1] + z[, k]
  p <- divide_by_total(cbind(0, z))
  colnames(p) <- seq_len(ncol(p))
  p
}
##########################################################################################
#
##########################################################################################
#' Category response curves of the generalized rating scale model
#'
#' A partial credit model whose step parameters are split into the difficulty
#' of the item and thresholds shared by the items of a response scale:
#' \eqn{\delta_v = b + \tau_v}{delta_v = b + tau_v} in \code{\link{prob_gpcm}()}.
#' With \eqn{a = 1} this is the rating scale model (Andrich, 1978), otherwise
#' the generalized rating scale model (Muraki, 1990).
#'
#' @inheritParams prob_4pl
#' @param thresholds Thresholds \eqn{\tau_1, \ldots, \tau_m}{tau_1, ..., tau_m}.
#'
#' @return A matrix with one row for each value of \code{theta} and one column
#'   for each category, named \code{1} to \code{m + 1}.
#'
#' @references Andrich, D. (1978). A rating formulation for ordered response
#'   categories. \emph{Psychometrika}, 43(4), 561-573.
#'
#'   Muraki, E. (1990). Fitting a polytomous item response model to Likert-type
#'   data. \emph{Applied Psychological Measurement}, 14(1), 59-71.
#'
#' @export
#'
#' @examples
#' prob_grsm(c(-2, 0, 2))
#' prob_grsm(c(-2, 0, 2), b = 1, thresholds = c(-0.5, 0.5))
prob_grsm <- function(theta, a = 1, b = 0, thresholds = c(-1, -0.4, 0.4, 1), D = 1) {
  prob_gpcm(theta, a = a, steps = b + thresholds, D = D)
}
##########################################################################################
#
##########################################################################################
#' Category response curves of the graded response model
#'
#' The probability of a response above each boundary between adjacent
#' categories is
#' \eqn{P^*_k(\theta) = 1 / (1 + \exp(-D a (\theta - b_k)))}{P*_k(theta) = 1 / (1 + exp(-D * a * (theta - b_k)))},
#' and the probability of each category is the difference between successive
#' boundary curves, with \eqn{P^*_0 = 1}{P*_0 = 1} and
#' \eqn{P^*_{m+1} = 0}{P*_(m+1) = 0}. The difficulties must increase, or some
#' probabilities would be negative.
#'
#' @inheritParams prob_4pl
#' @param b Increasing difficulties of the boundaries, \eqn{b_1, \ldots, b_m}{b_1, ..., b_m}.
#'
#' @return A matrix with one row for each value of \code{theta} and one column
#'   for each category, named \code{1} to \code{m + 1}.
#'
#' @export
#'
#' @examples
#' prob_grm(c(-2, 0, 2))
#' prob_grm(c(-2, 0, 2), a = 2, b = c(-1, 1))
prob_grm <- function(theta, a = 1.5, b = c(-2, -0.75, 0.75, 2), D = 1) {
  above <- 1 / (1 + exp(-D * a * outer(theta, b, "-")))
  p <- cbind(1, above) - cbind(above, 0)
  colnames(p) <- seq_len(ncol(p))
  p
}
##########################################################################################
#
##########################################################################################
#' Category response curves of the nominal response model
#'
#' The probabilities of the unordered categories of an item, with the first
#' category as the reference, whose exponent is 0, and each of the others with
#' its own discrimination and difficulty (the parameterization of Baker, 1992):
#' \deqn{P(X = k \mid \theta) = \frac{\exp(z_k)}{\sum_h \exp(z_h)}, \quad z_1 = 0, \quad z_k = D a_k (\theta - b_k).}{P(X = k | theta) = exp(z_k) / sum(exp(z_h)), with z_1 = 0 and z_k = D * a_k * (theta - b_k).}
#'
#' @inheritParams prob_4pl
#' @param a Discriminations of the categories after the first.
#' @param b Difficulties of the categories after the first.
#'
#' @return A matrix with one row for each value of \code{theta} and one column
#'   for each category, named \code{a}, \code{b}, \code{c}, ...
#'
#' @references Baker, F. B. (1992). \emph{Item Response Theory: Parameter
#'   Estimation Techniques}. New York: Marcel Dekker.
#'
#' @export
#'
#' @examples
#' prob_nrm(c(-2, 0, 2))
prob_nrm <- function(theta, a = c(-4, -2, 2, 4), b = c(-4, -2, 2, 4), D = 1) {
  z <- D * sweep(outer(theta, b, "-"), 2, a, "*")
  p <- divide_by_total(cbind(0, z))
  colnames(p) <- letters[seq_len(ncol(p))]
  p
}
##########################################################################################
#
##########################################################################################
#' Probit response functions of Thurstonian IRT
#'
#' The probability of a binary outcome as the standard normal distribution
#' function \eqn{\Phi}{Phi} of the latent trait \eqn{\eta}{eta}, in three forms:
#' \describe{
#'   \item{\code{prob_tirt()}}{a single outcome, with the parameters of factor
#'     analysis,
#'     \eqn{\Phi((-\gamma + \lambda \eta) / \sqrt{\psi})}{Phi((-gamma + lambda * eta) / sqrt(psi))};}
#'   \item{\code{prob_tirt_pair()}}{the choice of item \eqn{i} over item \eqn{k},
#'     \eqn{\Phi((-\gamma + \lambda_i \eta - \lambda_k \eta) / \sqrt{\psi_i + \psi_k})}{Phi((-gamma + lambda_i * eta - lambda_k * eta) / sqrt(psi_i + psi_k))};}
#'   \item{\code{prob_tirt_intercept()}}{the same comparison in intercept and
#'     slope form, \eqn{\Phi(\alpha + (\beta_i - \beta_k) \eta)}{Phi(alpha + (beta_i - beta_k) * eta)}.}
#' }
#'
#' @param eta Numeric vector of trait values.
#' @param gamma Threshold.
#' @param lambda,lambda_i,lambda_k Factor loadings.
#' @param psi,psi_i,psi_k Error (unique) variances.
#' @param alpha Intercept.
#' @param beta_i,beta_k Slopes.
#'
#' @return A numeric vector of probabilities, one for each value of \code{eta}.
#'
#' @export
#'
#' @examples
#' eta <- c(-2, 0, 2)
#' prob_tirt(eta)
#' # the pair and intercept forms agree when alpha = -gamma / sqrt(psi_i + psi_k)
#' # and each beta = lambda / sqrt(psi_i + psi_k)
#' prob_tirt_pair(eta, gamma = 0.5, lambda_i = 1, lambda_k = 0.2)
#' prob_tirt_intercept(eta, alpha = -0.5, beta_i = 1, beta_k = 0.2)
prob_tirt <- function(eta, gamma = 0, lambda = 0.5, psi = 0.5) {
  stats::pnorm((-gamma + lambda * eta) / sqrt(psi))
}
##########################################################################################
#
##########################################################################################
#' @rdname prob_tirt
#' @export
prob_tirt_pair <- function(eta, gamma = 0, lambda_i = 0.5, lambda_k = 0, psi_i = 0.5, psi_k = 0.5) {
  stats::pnorm((-gamma + lambda_i * eta - lambda_k * eta) / sqrt(psi_i + psi_k))
}
##########################################################################################
#
##########################################################################################
#' @rdname prob_tirt
#' @export
prob_tirt_intercept <- function(eta, alpha = 0, beta_i = 0.5, beta_k = 0) {
  stats::pnorm(alpha + (beta_i - beta_k) * eta)
}
##########################################################################################
#
##########################################################################################
#' Response surface of a two-dimensional dichotomous item
#'
#' The probability of a correct response to an item that measures two
#' abilities. In the compensatory model it is a logistic function of a
#' weighted sum of the abilities,
#' \deqn{P(\theta_1, \theta_2) = c + \frac{d - c}{1 + \exp(-D (a_1 (\theta_1 - b_1) + a_2 (\theta_2 - b_2)))},}{P(theta1, theta2) = c + (d - c) / (1 + exp(-D * (a_1 * (theta1 - b_1) + a_2 * (theta2 - b_2)))),}
#' so that a high ability on one dimension can make up for a low ability on the
#' other; in the non-compensatory model it is the product of one logistic
#' function for each ability, so that a low ability on either dimension keeps
#' the probability low.
#'
#' @param theta1,theta2 Numeric vectors of abilities on the two dimensions.
#' @param a Discriminations on the two dimensions.
#' @param b Locations on the two dimensions.
#' @param c Lower asymptote.
#' @param d Upper asymptote.
#' @param D Scaling constant.
#' @param compensatory \code{TRUE} for the compensatory model, \code{FALSE}
#'   for the non-compensatory one.
#'
#' @return A matrix with one row for each value of \code{theta1} and one column
#'   for each value of \code{theta2}.
#'
#' @export
#'
#' @examples
#' theta <- seq(-4, 4, length.out = 5)
#' prob_mirt(theta, theta)
#' prob_mirt(theta, theta, a = c(2, 0.5), compensatory = FALSE)
prob_mirt <- function(theta1, theta2, a = c(1, 1), b = c(0, 0), c = 0, d = 1, D = 1.702, compensatory = TRUE) {
  if (compensatory) {
    z <- D * outer(a[1] * (theta1 - b[1]), a[2] * (theta2 - b[2]), "+")
    c + (d - c) / (1 + exp(-z))
  } else {
    c + (d - c) * outer(prob_4pl(theta1, a[1], b[1], D = D), prob_4pl(theta2, a[2], b[2], D = D))
  }
}
##########################################################################################
#
##########################################################################################
#' Information surface of a two-dimensional dichotomous item
#'
#' The item information at each point: the squared slope of the response
#' surface of \code{\link{prob_mirt}()}, in the direction in which it rises
#' fastest, divided by \eqn{P (1 - P)},
#' \deqn{I(\theta_1, \theta_2) = \frac{(\partial P / \partial \theta_1)^2 + (\partial P / \partial \theta_2)^2}{P (1 - P)}.}{I(theta1, theta2) = ((dP/dtheta1)^2 + (dP/dtheta2)^2) / (P * (1 - P)).}
#' For the compensatory model this is the information of the four-parameter
#' logistic model (Magis, 2013) along the item vector,
#' \eqn{D^2 A^2 (P - c)^2 (d - P)^2 / ((d - c)^2 P (1 - P))}{D^2 * A^2 * (P - c)^2 * (d - P)^2 / ((d - c)^2 * P * (1 - P))},
#' with \eqn{A = \sqrt{a_1^2 + a_2^2}}{A = sqrt(a_1^2 + a_2^2)}. Where \eqn{P}
#' is exactly 0 or 1, or \eqn{c = d}, the surface is flat and the information
#' is 0.
#'
#' @inheritParams prob_mirt
#'
#' @return A matrix with one row for each value of \code{theta1} and one column
#'   for each value of \code{theta2}.
#'
#' @references Magis, D. (2013). A note on the item information function of the
#'   four-parameter logistic model. \emph{Applied Psychological Measurement},
#'   37(4), 304-315.
#'
#' @export
#'
#' @examples
#' theta <- seq(-4, 4, length.out = 5)
#' info_mirt(theta, theta)
info_mirt <- function(theta1, theta2, a = c(1, 1), b = c(0, 0), c = 0, d = 1, D = 1.702, compensatory = TRUE) {
  p <- prob_mirt(theta1, theta2, a = a, b = b, c = c, d = d, D = D, compensatory = compensatory)
  if (compensatory) {
    slope2 <- D^2 * sum(a^2) * ((p - c) * (d - p) / (d - c))^2
  } else {
    # the logistic part of each ability, spread over the grid: theta1 down the rows, theta2 across the columns
    l1 <- outer(prob_4pl(theta1, a[1], b[1], D = D), rep(1, length(theta2)))
    l2 <- outer(rep(1, length(theta1)), prob_4pl(theta2, a[2], b[2], D = D))
    slope2 <- ((d - c) * D * a[1] * l1 * (1 - l1) * l2)^2 + ((d - c) * D * a[2] * l2 * (1 - l2) * l1)^2
  }
  info <- slope2 / (p * (1 - p))
  info[!is.finite(info)] <- 0
  info
}
##########################################################################################
#
##########################################################################################
#' Item vector of a compensatory two-dimensional item
#'
#' The arrow that represents a compensatory item in the ability plane. It
#' points in the direction in which the probability rises fastest, at the
#' angle \eqn{\arccos(a_1 / A)}{arccos(a_1 / A)} to the \eqn{\theta_1}{theta1}
#' axis; its length is the multidimensional discrimination
#' \eqn{A = \sqrt{a_1^2 + a_2^2}}{A = sqrt(a_1^2 + a_2^2)}; and it starts on the
#' line where the probability is halfway between the asymptotes, at the
#' signed distance \eqn{(a_1 b_1 + a_2 b_2) / A}{(a_1 * b_1 + a_2 * b_2) / A},
#' the multidimensional difficulty, from the origin.
#'
#' @inheritParams prob_mirt
#'
#' @return A list with \code{start} and \code{end}, the coordinates of the two
#'   ends of the arrow, \code{discrimination}, the multidimensional
#'   discrimination \eqn{A}, and \code{difficulty}, the multidimensional
#'   difficulty.
#'
#' @export
#'
#' @examples
#' item_vector(a = c(1, 1), b = c(0, 0))
#' item_vector(a = c(2, 0.5), b = c(1, -1))
item_vector <- function(a = c(1, 1), b = c(0, 0)) {
  discrimination <- sqrt(sum(a^2))
  difficulty <- sum(a * b) / discrimination
  direction <- a / discrimination
  list(
    start = difficulty * direction,
    end = (difficulty + discrimination) * direction,
    discrimination = discrimination,
    difficulty = difficulty
  )
}
##########################################################################################
#
##########################################################################################
#' Name of the dichotomous model that parameters define
#'
#' @param a,c,d Discrimination and lower and upper asymptotes.
#'
#' @return \code{"Rasch Model"}, \code{"1PL or 2PL Model"}, \code{"3PL Model"},
#'   \code{"4PL Model (c = 0)"} (no guessing, an upper asymptote below 1 for
#'   slipping) or \code{"4PL Model"}.
#'
#' @noRd
#'
#' @examples
#' model_name_4pl(a = 1, c = 0.2, d = 1)
#' #> [1] "3PL Model"
model_name_4pl <- function(a, c, d) {
  if (c == 0 && d == 1) {
    if (a == 1) "Rasch Model" else "1PL or 2PL Model"
  } else if (d == 1) {
    "3PL Model"
  } else if (c == 0) {
    "4PL Model (c = 0)"
  } else {
    "4PL Model"
  }
}
