##########################################################################################
#
##########################################################################################
#' Plot category response curves
#'
#' Draws the probability of each response category against ability, as in the
#' single-trait tabs of the Models menu: one coloured line per category with a
#' marker at every ability, a gray line at a probability of 0.5, and a legend
#' in which a click hides or shows a curve.
#'
#' @param theta Numeric vector of abilities.
#' @param probs Matrix of probabilities, one row for each value of \code{theta}
#'   and one column for each category, as returned by \code{\link{prob_gpcm}()}
#'   and the other \code{prob_*()} functions; the column names label the
#'   categories.
#' @param title Title of the plot.
#' @param subtitle Optional note, shown on a second, smaller line of the
#'   title.
#' @param ylab Title of the vertical axis.
#'
#' @return A \code{plotly} object.
#'
#' @export
#'
#' @examples
#' theta <- seq(-6, 6, by = 0.1)
#' plot_category_curves(theta, prob_grm(theta), "Graded Response Model")
#' p <- prob_4pl(theta, c = 0.2)
#' plot_category_curves(theta, cbind("1" = p, "0" = 1 - p), "3PL Model", ylab = "P(x)")
plot_category_curves <- function(theta, probs, title = "", subtitle = NULL, ylab = "P(X=m|theta)") {
  labels <- paste0("P(X=", colnames(probs), "|theta)")
  curves <- data.frame(
    theta = rep(theta, ncol(probs)),
    p = as.vector(probs),
    category = factor(rep(labels, each = length(theta)), levels = labels)
  )
  if (!is.null(subtitle)) title <- paste0(title, "<br><sup>", subtitle, "</sup>")
  p <- plotly::plot_ly(curves,
    x = ~theta, y = ~p, color = ~category, colors = category_colours[seq_along(labels)],
    type = "scatter", mode = "lines+markers"
  ) |>
    plotly::layout(
      title = list(text = title),
      xaxis = list(title = "\u03b8"),
      yaxis = list(title = ylab, range = c(0, 1)),
      legend = list(x = 0, y = 0.99),
      shapes = list(hline_shape(0.5))
    )
  # room above the plot for the second line of the title
  if (!is.null(subtitle)) p <- plotly::layout(p, margin = list(t = 60))
  p
}
##########################################################################################
#
##########################################################################################
#' Plot a Thurstonian IRT response function
#'
#' Draws a probability from \code{\link{prob_tirt}()} or its pair and
#' intercept forms against the trait, with a marker at every value and a gray
#' line at 0.5.
#'
#' @param eta Numeric vector of trait values.
#' @param p Probabilities, one for each value of \code{eta}.
#'
#' @return A \code{plotly} object.
#'
#' @export
#'
#' @examples
#' eta <- seq(-6, 6, by = 0.1)
#' plot_tirt(eta, prob_tirt(eta))
plot_tirt <- function(eta, p) {
  plotly::plot_ly(x = eta, y = p, type = "scatter", mode = "lines+markers") |>
    plotly::layout(
      xaxis = list(title = "\u03b7"),
      yaxis = list(title = "P(\u03b7)", range = c(0, 1)),
      shapes = list(hline_shape(0.5))
    )
}
##########################################################################################
#
##########################################################################################
#' Plot a surface over the ability plane
#'
#' Draws a matrix from \code{\link{prob_mirt}()} or \code{\link{info_mirt}()}
#' as an interactive 3-D surface, coloured from purple (low) to yellow (high),
#' that can be rotated and zoomed with the mouse.
#'
#' @param theta1,theta2 Abilities on the two dimensions.
#' @param z Matrix with one row for each value of \code{theta1} and one column
#'   for each value of \code{theta2}.
#' @param xlab,ylab,zlab Titles of the axes; \code{NULL} labels the abilities
#'   with the Greek letter theta, as theta1 and theta2.
#' @param zrange Range of the vertical axis, or \code{NULL} to fit the surface.
#' @param eye Position of the camera, as in plotly's \code{scene.camera.eye}.
#'
#' @return A \code{plotly} object.
#'
#' @export
#'
#' @examples
#' theta <- seq(-4, 4, length.out = 50)
#' plot_mirt_surface(theta, theta, prob_mirt(theta, theta))
#' plot_mirt_surface(theta, theta, info_mirt(theta, theta),
#'   zlab = "Information", zrange = NULL, eye = list(x = -1.5, y = 1.5, z = 1.5)
#' )
plot_mirt_surface <- function(theta1, theta2, z, xlab = NULL, ylab = NULL, zlab = "P(Y=1)",
                              zrange = c(0, 1), eye = list(x = 1.5, y = -1.5, z = 1.5)) {
  if (is.null(xlab)) xlab <- "\u{03b8}1"
  if (is.null(ylab)) ylab <- "\u{03b8}2"
  zaxis <- list(title = zlab)
  zaxis$range <- zrange
  # z has one row per theta1 value, but plotly draws matrix rows along y: transpose it so theta1 runs along x
  plotly::plot_ly(x = theta1, y = theta2, z = t(z), type = "surface", showscale = FALSE) |>
    plotly::layout(scene = list(
      xaxis = list(title = xlab),
      yaxis = list(title = ylab),
      zaxis = zaxis,
      camera = list(eye = eye)
    ))
}
##########################################################################################
#
##########################################################################################
#' Plot the contours of a two-dimensional item
#'
#' Draws the response surface of \code{\link{prob_mirt}()} seen from above, as
#' labelled contour lines of equal probability, with the zero lines of both
#' axes, a thick line at one probability (usually halfway between the
#' asymptotes) and, optionally, the item vector as a blue arrow. Both axes have
#' the same scale, so the angle of the arrow is true.
#'
#' @param theta1,theta2 Abilities on the two dimensions.
#' @param z Matrix with one row for each value of \code{theta1} and one column
#'   for each value of \code{theta2}.
#' @param nlevels Approximate number of contour levels.
#' @param level Probability of the thick line, or \code{NULL} for none; every
#'   piece of it is drawn, and none when the grid does not reach it.
#' @param arrow Item vector from \code{\link{item_vector}()}, or \code{NULL};
#'   it is drawn when it lies inside the plotted grid.
#' @param xlab,ylab Titles of the axes; \code{NULL} labels the abilities with
#'   the Greek letter theta, as theta1 and theta2.
#'
#' @return A \code{plotly} object.
#'
#' @export
#'
#' @examples
#' theta <- seq(-4, 4, length.out = 50)
#' plot_mirt_contour(theta, theta, prob_mirt(theta, theta), level = 0.5, arrow = item_vector())
plot_mirt_contour <- function(theta1, theta2, z, nlevels = 10, level = NULL, arrow = NULL,
                              xlab = NULL, ylab = NULL) {
  if (is.null(xlab)) xlab <- "\u{03b8}1"
  if (is.null(ylab)) ylab <- "\u{03b8}2"
  p <- plotly::plot_ly(
    x = theta1, y = theta2, z = t(z), type = "contour", ncontours = nlevels,
    contours = list(coloring = "lines", showlabels = TRUE),
    colorscale = list(c(0, 1), c("black", "black")), showscale = FALSE,
    hovertemplate = paste0(xlab, ": %{x:.2f}<br>", ylab, ": %{y:.2f}<br>P: %{z:.3f}<extra></extra>")
  )
  pieces <- if (is.null(level)) list() else grDevices::contourLines(theta1, theta2, z, levels = level)
  if (length(pieces) > 0) {
    # one path, broken by NA between the pieces
    p <- p |> plotly::add_paths(
      x = unlist(lapply(pieces, function(piece) c(piece$x, NA))),
      y = unlist(lapply(pieces, function(piece) c(piece$y, NA))),
      line = list(color = "black", width = 3), hoverinfo = "skip", inherit = FALSE
    )
  }
  inside <- function(point) {
    point[1] >= min(theta1) && point[1] <= max(theta1) && point[2] >= min(theta2) && point[2] <= max(theta2)
  }
  annotations <- list()
  if (!is.null(arrow) && inside(arrow$start) && inside(arrow$end)) {
    annotations <- list(list(
      x = arrow$end[1], y = arrow$end[2], ax = arrow$start[1], ay = arrow$start[2],
      xref = "x", yref = "y", axref = "x", ayref = "y",
      text = "", showarrow = TRUE, arrowhead = 2, arrowwidth = 1.5, arrowcolor = "blue"
    ))
  }
  p |> plotly::layout(
    showlegend = FALSE,
    xaxis = list(
      title = xlab, range = range(theta1), constrain = "domain",
      zeroline = TRUE, zerolinecolor = "black", zerolinewidth = 1
    ),
    yaxis = list(
      title = ylab, range = range(theta2), constrain = "domain", scaleanchor = "x",
      zeroline = TRUE, zerolinecolor = "black", zerolinewidth = 1
    ),
    annotations = annotations
  )
}
##########################################################################################
#
##########################################################################################
#' Plot a Newton-Raphson step
#'
#' Draws the log-likelihood from \code{\link{newton_raphson_rasch}()} with its
#' last step: the estimate the step starts from (red dot), the tangent to the
#' log-likelihood there (blue line), the estimate the step ends at (green dot)
#' and the triangle between the tangent and the horizontal axis, whose angle
#' is zero at the maximum.
#'
#' @param nr Result of \code{\link{newton_raphson_rasch}()}.
#'
#' @return A \code{plotly} object.
#'
#' @export
#'
#' @examples
#' plot_newton_raphson(newton_raphson_rasch(response_pattern(2), iterations = 2))
plot_newton_raphson <- function(nr) {
  step <- nr$steps[nrow(nr$steps), ]
  label_start <- "\u03b8\u0302<sup>0</sup>"
  label_end <- "\u03b8\u0302<sup>1</sup>"
  p <- plotly::plot_ly() |>
    plotly::add_lines(
      x = nr$theta, y = nr$loglik, line = list(color = "black"), name = "Log-likelihood",
      hovertemplate = "\u03b8: %{x:.3f}<br>LogLikelihood: %{y:.4f}<extra></extra>"
    ) |>
    plotly::add_lines(
      x = c(-6, 6), y = step$intercept + step$d1 * c(-6, 6),
      line = list(color = "blue"), name = "Tangent", hoverinfo = "skip"
    )
  if (isTRUE(round(abs(step$angle)) > 0)) {
    p <- p |> plotly::add_trace(
      type = "scatter", mode = "lines",
      x = c(step$crossing, step$start, step$start, step$crossing), y = c(0, 0, step$loglik_start, 0),
      fill = "toself", fillcolor = "rgba(0,0,0,0.15)", line = list(color = "black", width = 1),
      name = "Angle", hoverinfo = "skip"
    )
  }
  p |>
    plotly::add_markers(
      x = step$start, y = step$loglik_start, name = "Start",
      marker = list(color = "red", size = 12, line = list(color = "black", width = 1)),
      hovertemplate = paste0(label_start, ": %{x:.4f}<br>LogLikelihood: %{y:.4f}<extra></extra>")
    ) |>
    plotly::add_markers(
      x = step$end, y = step$loglik_end, name = "Next",
      marker = list(color = "green", size = 12, line = list(color = "black", width = 1)),
      hovertemplate = paste0(label_end, ": %{x:.4f}<br>LogLikelihood: %{y:.4f}<extra></extra>")
    ) |>
    plotly::layout(
      showlegend = FALSE,
      xaxis = list(title = "\u03b8", range = c(-6, 6), zeroline = FALSE),
      yaxis = list(title = "LogLikelihood", range = c(-15, 1), zeroline = FALSE),
      shapes = list(
        hline_shape(0),
        vline_shape(step$start, "gray", "dot"),
        vline_shape(step$end, "gray", "dot")
      ),
      annotations = list(
        list(x = step$start, y = step$loglik_start - 1, text = label_start, showarrow = FALSE),
        list(x = step$end, y = step$loglik_end - 1, text = label_end, showarrow = FALSE)
      )
    )
}
##########################################################################################
#
##########################################################################################
#' Plot a log-likelihood surface
#'
#' Draws a surface from \code{\link{loglik_surface}()} in 3-D, with a red dot
#' at its highest point: the maximum likelihood estimates of discrimination
#' and difficulty.
#'
#' @param loglik Matrix of log-likelihoods, one row for each value of \code{a}
#'   and one column for each value of \code{b}.
#' @param a,b The grids of discriminations and difficulties of the surface; by
#'   default those that \code{\link{loglik_surface}()} keeps with it.
#'
#' @return A \code{plotly} object.
#'
#' @export
#'
#' @examples
#' set.seed(1)
#' theta <- seq(-3, 3, length.out = 50)
#' plot_loglik_surface(loglik_surface(simulate_responses(theta, a = 1, b = -0.5), theta))
plot_loglik_surface <- function(loglik, a = attr(loglik, "a"), b = attr(loglik, "b")) {
  top <- surface_maximum(loglik, a, b)
  plotly::plot_ly() |>
    # surface z is indexed [y, x], so transpose the [a, b] matrix
    plotly::add_surface(
      x = a, y = b, z = t(loglik),
      colorscale = list(c(0, 1), c("#347AB6", "#347AB6")), showscale = FALSE,
      hovertemplate = "Discrimination: %{x:.2f}<br>Difficulty: %{y:.2f}<br>Log-Likelihood: %{z:.3f}<extra></extra>"
    ) |>
    plotly::add_trace(
      type = "scatter3d", mode = "markers", x = top$a, y = top$b, z = top$loglik,
      marker = list(color = "red", size = 7, line = list(color = "black", width = 1)),
      hovertemplate = "Maximum<br>Discrimination: %{x:.2f}<br>Difficulty: %{y:.2f}<br>Log-Likelihood: %{z:.3f}<extra></extra>"
    ) |>
    plotly::layout(
      showlegend = FALSE,
      scene = list(
        xaxis = list(title = "Discrimination"),
        yaxis = list(title = "Difficulty"),
        zaxis = list(title = "Log-Likelihood")
      )
    )
}
##########################################################################################
#
##########################################################################################
#' Plot log-likelihood surfaces for several lower asymptotes
#'
#' Draws one surface from \code{\link{loglik_surface}()} for each assumed lower
#' asymptote (guessing value), in different colours on one vertical scale, each
#' with a dot at its highest point. The legend gives the guessing value of each
#' colour, and a click on an entry hides or shows that surface.
#'
#' @param surfaces List of log-likelihood matrices, one for each value of
#'   \code{guesses}, on the same grids.
#' @param guesses The lower asymptotes assumed for the surfaces.
#' @param a,b The grids of discriminations and difficulties of the surfaces; by
#'   default those that \code{\link{loglik_surface}()} keeps with them.
#'
#' @return A \code{plotly} object.
#'
#' @export
#'
#' @examples
#' set.seed(1)
#' theta <- seq(-3, 3, length.out = 50)
#' grid <- seq(-3, 3, by = 0.15)
#' guesses <- c(0.1, 0.3, 0.5)
#' responses <- simulate_responses(theta, a = 1, b = -0.5, c = 0.4)
#' surfaces <- lapply(guesses, function(g) loglik_surface(responses, theta, grid, grid, c = g))
#' plot_loglik_surfaces(surfaces, guesses)
plot_loglik_surfaces <- function(surfaces, guesses = seq(0.05, 0.6, by = 0.05),
                                 a = attr(surfaces[[1]], "a"), b = attr(surfaces[[1]], "b")) {
  colours <- grDevices::hcl.colors(length(guesses), palette = "Dark 3")
  p <- plotly::plot_ly()
  for (g in seq_along(guesses)) {
    group <- paste0("c=", guesses[g])
    top <- surface_maximum(surfaces[[g]], a, b)
    # surface and its maximum share a legend group, so the legend toggles both
    p <- p |>
      plotly::add_surface(
        x = a, y = b, z = t(surfaces[[g]]),
        colorscale = list(c(0, 1), c(colours[g], colours[g])), showscale = FALSE, opacity = 0.7,
        name = group, legendgroup = group, showlegend = FALSE,
        hovertemplate = paste0(group, "<br>Discrimination: %{x:.2f}<br>Difficulty: %{y:.2f}<br>Log-Likelihood: %{z:.3f}<extra></extra>")
      ) |>
      plotly::add_trace(
        type = "scatter3d", mode = "markers", x = top$a, y = top$b, z = top$loglik,
        marker = list(color = colours[g], size = 6, line = list(color = "black", width = 1)),
        name = group, legendgroup = group,
        hovertemplate = paste0(group, " maximum<br>Discrimination: %{x:.2f}<br>Difficulty: %{y:.2f}<br>Log-Likelihood: %{z:.3f}<extra></extra>")
      )
  }
  p |>
    plotly::layout(
      legend = list(title = list(text = "Guessing")),
      scene = list(
        xaxis = list(title = "Discrimination"),
        yaxis = list(title = "Difficulty"),
        zaxis = list(title = "Log-Likelihood")
      )
    )
}
##########################################################################################
#
##########################################################################################
#' Plot the parts of an EAP and MAP estimation
#'
#' Draw the parts of an estimation from \code{\link{eap_map}()}:
#' \describe{
#'   \item{\code{plot_prior()}}{the prior weights at the quadrature points;}
#'   \item{\code{plot_tracelines()}}{the probability of each observed response
#'     across ability, blue for items answered correctly and red for items
#'     answered incorrectly;}
#'   \item{\code{plot_likelihood()}}{the likelihood, the product of those
#'     probabilities;}
#'   \item{\code{plot_posterior()}}{the posterior, with lines and values for the
#'     EAP (blue) and the MAP (red);}
#'   \item{\code{plot_eap_combined()}}{the prior (red), likelihood (blue) and
#'     posterior (black, rescaled to be comparable) in one plot, with dashed
#'     lines at the prior mean and the posterior mean.}
#' }
#'
#' @param estimate Result of \code{\link{eap_map}()}.
#'
#' @return A \code{plotly} object.
#'
#' @export
#'
#' @examples
#' estimate <- eap_map(response_pattern(2))
#' plot_prior(estimate)
#' plot_tracelines(estimate)
#' plot_likelihood(estimate)
#' plot_posterior(estimate)
#' plot_eap_combined(estimate)
plot_prior <- function(estimate) {
  x <- estimate$x
  plotly::plot_ly() |>
    plotly::add_bars(
      x = x, y = estimate$prior, width = abs(x[2] - x[1]),
      marker = list(color = "rgba(0,0,0,0.12)", line = list(color = "black", width = 1)),
      hovertemplate = "X<sub>r</sub>: %{x:.3f}<br>A(X<sub>r</sub>): %{y:.4f}<extra></extra>"
    ) |>
    plotly::add_lines(x = x, y = estimate$prior, line = list(color = "black"), hoverinfo = "skip") |>
    plotly::layout(
      title = "Prior Distribution of \u03b8",
      showlegend = FALSE,
      bargap = 0,
      xaxis = list(title = "X<sub>r</sub>", range = c(-6, 6)),
      yaxis = list(title = "A(X<sub>r</sub>)")
    )
}
##########################################################################################
#
##########################################################################################
#' @rdname plot_prior
#' @export
plot_tracelines <- function(estimate) {
  responses <- estimate$responses
  p <- plotly::plot_ly()
  for (i in seq_along(responses)) {
    response <- as.character(responses[i])
    # one legend entry for each response, from its first item
    p <- p |> plotly::add_lines(
      x = estimate$x, y = estimate$trace[, i],
      line = list(color = c("#DF536B", "#2297E6")[responses[i] + 1]),
      name = response, legendgroup = response, showlegend = !(responses[i] %in% responses[seq_len(i - 1)]),
      hovertemplate = paste0("Item ", i, "<br>X<sub>r</sub>: %{x:.3f}<br>P(X<sub>r</sub>): %{y:.4f}<extra></extra>")
    )
  }
  p |> plotly::layout(
    title = "Item Tracelines",
    legend = list(title = list(text = "Response")),
    xaxis = list(title = "X<sub>r</sub>", range = c(-3, 3)),
    yaxis = list(title = "P(X<sub>r</sub>)", range = c(0, 1))
  )
}
##########################################################################################
#
##########################################################################################
#' @rdname plot_prior
#' @export
plot_likelihood <- function(estimate) {
  plotly::plot_ly() |>
    plotly::add_lines(
      x = estimate$x, y = estimate$likelihood, line = list(color = "black"),
      hovertemplate = "X<sub>r</sub>: %{x:.3f}<br>L(X<sub>r</sub>): %{y:.5f}<extra></extra>"
    ) |>
    plotly::layout(
      title = "Likelihood",
      showlegend = FALSE,
      xaxis = list(title = "X<sub>r</sub>", range = c(-3, 3)),
      yaxis = list(title = "L(X<sub>r</sub>)")
    )
}
##########################################################################################
#
##########################################################################################
#' @rdname plot_prior
#' @export
plot_posterior <- function(estimate) {
  height <- max(estimate$posterior) * 0.9
  plotly::plot_ly() |>
    plotly::add_lines(
      x = estimate$x, y = estimate$posterior, line = list(color = "black"),
      hovertemplate = "X<sub>r</sub>: %{x:.3f}<br>A(X<sub>r</sub>) * L(X<sub>r</sub>): %{y:.6f}<extra></extra>"
    ) |>
    plotly::layout(
      title = "Posterior Distribution of \u03b8",
      showlegend = FALSE,
      xaxis = list(title = "X<sub>r</sub>", range = c(-2.5, 2.5)),
      yaxis = list(title = "A(X<sub>r</sub>) * L(X<sub>r</sub>)"),
      shapes = list(vline_shape(estimate$eap, "#2297E6"), vline_shape(estimate$map, "#DF536B")),
      annotations = list(
        list(x = -1.8, y = height, text = paste("EAP =", round(estimate$eap, 4)), showarrow = FALSE, font = list(color = "#2297E6")),
        list(x = 1.8, y = height, text = paste("MAP =", round(estimate$map, 4)), showarrow = FALSE, font = list(color = "#DF536B"))
      )
    )
}
##########################################################################################
#
##########################################################################################
#' @rdname plot_prior
#' @export
plot_eap_combined <- function(estimate) {
  x <- estimate$x
  plotly::plot_ly() |>
    plotly::add_lines(x = x, y = estimate$prior, line = list(color = "red"), name = "Prior") |>
    plotly::add_lines(x = x, y = estimate$likelihood, line = list(color = "blue"), name = "Likelihood") |>
    plotly::add_lines(x = x, y = 5 * estimate$posterior, line = list(color = "black"), name = "Posterior") |>
    plotly::layout(
      title = "Prior, Likelihood, and Posterior Distributions<br><sup>Note: Posterior distribution is rescaled for comparability!</sup>",
      legend = list(title = list(text = "Distribution")),
      xaxis = list(title = "X<sub>r</sub>", range = c(-4, 4)),
      yaxis = list(title = "f(X<sub>r</sub>)", range = c(0, 0.20)),
      shapes = list(vline_shape(estimate$prior_mean, "red", "dash"), vline_shape(estimate$eap, "black", "dash")),
      annotations = list(
        list(
          x = -3.5, y = 0.2, yanchor = "top", showarrow = FALSE, font = list(color = "black"),
          text = paste("Posterior Mean =", round(estimate$eap, 2))
        ),
        list(
          x = 3.5, y = 0.2, yanchor = "top", showarrow = FALSE, font = list(color = "red"),
          text = paste("Prior Mean =", estimate$prior_mean)
        )
      )
    )
}
