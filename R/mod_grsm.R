##########################################################################################
#
##########################################################################################
#' RSM-GRSM module - UI
#'
#' Controls for the scaling constant, the discrimination, the difficulty and
#' the four thresholds of an item with five ordered categories, and its
#' category response curves.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_grsm_ui("grsm"))
#' }
mod_grsm_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("by Metin Bulus"),
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("D"), label = "Scaling Constant", choices = list("1" = 1, "1.702" = 2), selected = 1),
        sliderInput(ns("a"), label = "Discrimination", min = -10, max = 10, value = 1, step = 0.1),
        sliderInput(ns("b"), label = "Difficulty", min = -10, max = 10, value = 0, step = 0.1),
        sliderInput(ns("tau1"), label = "Threshold 1", min = -10, max = 10, value = -1, step = 0.1),
        sliderInput(ns("tau2"), label = "Threshold 2", min = -10, max = 10, value = -0.4, step = 0.1),
        sliderInput(ns("tau3"), label = "Threshold 3", min = -10, max = 10, value = 0.4, step = 0.1),
        sliderInput(ns("tau4"), label = "Threshold 4", min = -10, max = 10, value = 1, step = 0.1)
      ),
      mainPanel(plotly::plotlyOutput(ns("plot"), width = "100%", height = "700px"))
    )
  )
}
##########################################################################################
#
##########################################################################################
#' RSM-GRSM module - server
#'
#' Plots the category response curves of \code{\link{prob_grsm}()}, titled
#' Rating Scale Model when the discrimination is 1 and Generalized Rating Scale
#' Model otherwise. A discrimination of 0 is rejected with a message in place
#' of the plot.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_grsm_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_grsm_server("grsm")
#' }
#' }
mod_grsm_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    theta <- seq(-6, 6, by = 0.1)

    output$plot <- plotly::renderPlotly({
      validate(need(input$a != 0, "Why would you have an item with 0 (zero) discrimination!"))
      thresholds <- c(input$tau1, input$tau2, input$tau3, input$tau4)
      title <- if (input$a == 1) "Rating Scale Model (Andrich,1978)" else "Generalized Rating Scale Model (Muraki,1990)"
      plot_category_curves(
        theta,
        prob_grsm(theta, a = input$a, b = input$b, thresholds = thresholds, D = scaling_constant(input$D)),
        title
      )
    })
  })
}
