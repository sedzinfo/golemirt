##########################################################################################
#
##########################################################################################
#' PCM-GPCM module - UI
#'
#' Controls for the scaling constant, the discrimination and the four step
#' parameters of an item with five ordered categories, and its category
#' response curves.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_gpcm_ui("gpcm"))
#' }
mod_gpcm_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("by Metin Bulus"),
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("D"), label = "Scaling Constant", choices = list("1" = 1, "1.702" = 2), selected = 1),
        sliderInput(ns("a"), label = "Discrimination", min = -10, max = 10, value = 1, step = 0.5),
        sliderInput(ns("step1"), label = "Step parameter 1", min = -10, max = 10, value = -2, step = 0.1),
        sliderInput(ns("step2"), label = "Step parameter 2", min = -10, max = 10, value = -0.75, step = 0.1),
        sliderInput(ns("step3"), label = "Step parameter 3", min = -10, max = 10, value = 0.75, step = 0.1),
        sliderInput(ns("step4"), label = "Step parameter 4", min = -10, max = 10, value = 2, step = 0.1)
      ),
      mainPanel(plotly::plotlyOutput(ns("plot"), width = "100%", height = "700px"))
    )
  )
}
##########################################################################################
#
##########################################################################################
#' PCM-GPCM module - server
#'
#' Plots the category response curves of \code{\link{prob_gpcm}()}, titled
#' Partial Credit Model when the discrimination is 1 and Generalized Partial
#' Credit Model otherwise. A discrimination of 0 is rejected with a message in
#' place of the plot.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_gpcm_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_gpcm_server("gpcm")
#' }
#' }
mod_gpcm_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    theta <- seq(-6, 6, by = 0.1)

    output$plot <- plotly::renderPlotly({
      validate(need(input$a != 0, "Why would you have an item with 0(zero) discrimination!"))
      steps <- c(input$step1, input$step2, input$step3, input$step4)
      title <- if (input$a == 1) "Partial Credit Model (Masters,1982)" else "Generalized Partial Credit Model (Muraki,1992)"
      plot_category_curves(theta, prob_gpcm(theta, a = input$a, steps = steps, D = scaling_constant(input$D)),
        title,
        ylab = "P(x)"
      )
    })
  })
}
