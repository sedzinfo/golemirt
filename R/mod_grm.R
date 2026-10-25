##########################################################################################
#
##########################################################################################
#' GRM module - UI
#'
#' Controls for the scaling constant, the discrimination and the four
#' difficulties of an item with five ordered categories, and its category
#' response curves. The ranges of the difficulty sliders do not overlap, which
#' keeps the difficulties in increasing order, as the model requires.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_grm_ui("grm"))
#' }
mod_grm_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("Unknown Contributor"),
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("D"), label = "Scaling Constant", choices = list("1" = 1, "1.702" = 2), selected = 1),
        sliderInput(ns("a"), label = "Discrimination", min = 0, max = 10, value = 1.5, step = 0.1),
        sliderInput(ns("b1"), label = "Difficulty 1", min = -2.5, max = -1.5, value = -2, step = 0.1),
        sliderInput(ns("b2"), label = "Difficulty 2", min = -1.25, max = -0.25, value = -0.75, step = 0.1),
        sliderInput(ns("b3"), label = "Difficulty 3", min = 0, max = 1.25, value = 0.75, step = 0.1),
        sliderInput(ns("b4"), label = "Difficulty 4", min = 1.5, max = 2.5, value = 2, step = 0.1)
      ),
      mainPanel(plotly::plotlyOutput(ns("plot"), width = "100%", height = "700px"))
    )
  )
}
##########################################################################################
#
##########################################################################################
#' GRM module - server
#'
#' Plots the category response curves of \code{\link{prob_grm}()}.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_grm_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_grm_server("grm")
#' }
#' }
mod_grm_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    theta <- seq(-6, 6, by = 0.1)

    output$plot <- plotly::renderPlotly({
      b <- c(input$b1, input$b2, input$b3, input$b4)
      plot_category_curves(theta, prob_grm(theta, a = input$a, b = b, D = scaling_constant(input$D)),
        "Graded Response Model"
      )
    })
  })
}
