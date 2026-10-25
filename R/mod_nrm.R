##########################################################################################
#
##########################################################################################
#' NRM module - UI
#'
#' Controls for the scaling constant and the discriminations and difficulties
#' of the four categories after the reference category of an item with five
#' unordered categories, and its category response curves.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_nrm_ui("nrm"))
#' }
mod_nrm_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("Unknown Contributor"),
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("D"), label = "Scaling Constant", choices = list("1" = 1, "1.702" = 2), selected = 1),
        sliderInput(ns("a1"), label = "Discrimination 1", min = -10, max = 10, value = -4, step = 0.1),
        sliderInput(ns("a2"), label = "Discrimination 2", min = -10, max = 10, value = -2, step = 0.1),
        sliderInput(ns("a3"), label = "Discrimination 3", min = -10, max = 10, value = 2, step = 0.1),
        sliderInput(ns("a4"), label = "Discrimination 4", min = -10, max = 10, value = 4, step = 0.1),
        sliderInput(ns("b1"), label = "Difficulty 1", min = -10, max = 10, value = -4, step = 0.1),
        sliderInput(ns("b2"), label = "Difficulty 2", min = -10, max = 10, value = -2, step = 0.1),
        sliderInput(ns("b3"), label = "Difficulty 3", min = -10, max = 10, value = 2, step = 0.1),
        sliderInput(ns("b4"), label = "Difficulty 4", min = -10, max = 10, value = 4, step = 0.1)
      ),
      mainPanel(plotly::plotlyOutput(ns("plot"), width = "100%", height = "700px"))
    )
  )
}
##########################################################################################
#
##########################################################################################
#' NRM module - server
#'
#' Plots the category response curves of \code{\link{prob_nrm}()}, labelled
#' a to e, with a note on Baker's (1992) reparameterization under the title.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_nrm_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_nrm_server("nrm")
#' }
#' }
mod_nrm_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    theta <- seq(-6, 6, by = 0.1)

    output$plot <- plotly::renderPlotly({
      a <- c(input$a1, input$a2, input$a3, input$a4)
      b <- c(input$b1, input$b2, input$b3, input$b4)
      plot_category_curves(theta, prob_nrm(theta, a = a, b = b, D = scaling_constant(input$D)),
        "Nominal Response Model",
        subtitle = "Note: Baker's (1992) reparameterization used."
      )
    })
  })
}
