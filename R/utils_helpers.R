##########################################################################################
#
##########################################################################################
#' Scaling constant from a select input
#'
#' Turns the value of a Scaling Constant (or Item Response Function) select
#' input, \code{"1"} or \code{"2"}, into the scaling constant \eqn{D} of the
#' logistic function.
#'
#' @param choice Character, \code{"1"} or \code{"2"}.
#'
#' @return 1 for \code{"1"}, and 1.702 for \code{"2"}, which makes the logistic
#'   curve almost coincide with the normal ogive.
#'
#' @noRd
#'
#' @examples
#' scaling_constant("2")
#' #> [1] 1.702
scaling_constant <- function(choice) {
  switch(choice,
    "1" = 1,
    "2" = 1.702
  )
}
##########################################################################################
#
##########################################################################################
#' Axis title of an ability dimension
#'
#' The symbol of a dimension, with the name typed in by the user in front of it
#' when there is one, for example \code{"Math (theta1)"}.
#'
#' @param name Character, the name typed in; blank or \code{NULL} for none.
#' @param symbol Character, the symbol of the dimension.
#'
#' @return A character string.
#'
#' @noRd
#'
#' @examples
#' axis_title("Math", "theta1")
#' #> [1] "Math (theta1)"
#' axis_title(" ", "theta1")
#' #> [1] "theta1"
axis_title <- function(name, symbol) {
  if (is.null(name) || trimws(name) == "") symbol else paste0(name, " (", symbol, ")")
}
##########################################################################################
#
##########################################################################################
#' Horizontal line across a plotly plot
#'
#' A shape for the \code{shapes} argument of \code{plotly::layout()}, across
#' the whole width of the plot.
#'
#' @param y Height of the line, in the units of the y axis.
#' @param color Colour of the line.
#'
#' @return A list describing a plotly line shape.
#'
#' @noRd
#'
#' @examples
#' plotly::layout(plotly::plot_ly(), shapes = list(hline_shape(0.5)))
hline_shape <- function(y, color = "gray") {
  list(type = "line", xref = "paper", x0 = 0, x1 = 1, y0 = y, y1 = y, line = list(color = color, width = 1))
}
##########################################################################################
#
##########################################################################################
#' Vertical line across a plotly plot
#'
#' A shape for the \code{shapes} argument of \code{plotly::layout()}, across
#' the whole height of the plot.
#'
#' @param x Position of the line, in the units of the x axis.
#' @param color Colour of the line.
#' @param dash Line style: \code{"solid"}, \code{"dot"}, \code{"dash"}, ...
#'
#' @return A list describing a plotly line shape.
#'
#' @noRd
#'
#' @examples
#' plotly::layout(plotly::plot_ly(), shapes = list(vline_shape(0, "red", "dash")))
vline_shape <- function(x, color, dash = "solid") {
  list(type = "line", yref = "paper", y0 = 0, y1 = 1, x0 = x, x1 = x, line = list(color = color, dash = dash, width = 1))
}
##########################################################################################
#
##########################################################################################
#' Colours of the response categories
#'
#' The first colours of the ColorBrewer Set2 palette, which plotly uses by
#' default for a few categories; naming them avoids the warning plotly gives
#' when a plot has fewer than three categories.
#'
#' @noRd
category_colours <- c("#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854")
##########################################################################################
#
##########################################################################################
#' Credit line of a tab
#'
#' The line under the navigation bar that credits the author of a tab.
#'
#' @param text Character, the credit.
#'
#' @return An \code{h4} tag.
#'
#' @noRd
#'
#' @examples
#' credit_line("by Metin Bulus")
credit_line <- function(text) {
  h4(text, style = "margin: 10px 0 20px;")
}
