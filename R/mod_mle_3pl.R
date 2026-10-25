##########################################################################################
#
##########################################################################################
#' MLE 3PL module - UI
#'
#' Controls for the true lower asymptote, discrimination and location of an
#' item, and the log-likelihood surfaces for twelve assumed lower asymptotes.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_mle_3pl_ui("mle_3pl"))
#' }
mod_mle_3pl_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("by Metin Bulus"),
    sidebarLayout(
      sidebarPanel(
        width = 3,
        sliderInput(ns("c"), label = "Lower Asymptote", min = 0.05, max = 0.6, value = 0.4, step = 0.05),
        sliderInput(ns("a"), label = "Discrimination", min = -3, max = 3, value = 1, step = 0.15),
        sliderInput(ns("b"), label = "Location", min = -3, max = 3, value = -0.5, step = 0.15)
      ),
      mainPanel(
        width = 9,
        plotly::plotlyOutput(ns("plot"), width = "100%", height = "800px")
      )
    )
  )
}
##########################################################################################
#
##########################################################################################
#' MLE 3PL module - server
#'
#' Simulates the responses of 50 people with abilities spread evenly from -3
#' to 3 to an item with the true parameters, again whenever a true value
#' changes, and plots their log-likelihood for every discrimination and
#' difficulty from -3 to 3 in steps of 0.15, once for each assumed lower
#' asymptote 0.05, 0.10, ..., 0.60.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_mle_3pl_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_mle_3pl_server("mle_3pl")
#' }
#' }
mod_mle_3pl_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    theta <- seq(-3, 3, length.out = 50)
    grid <- seq(-3, 3, by = 0.15)
    guesses <- seq(0.05, 0.6, by = 0.05)
    surfaces <- reactive({
      responses <- simulate_responses(theta, a = input$a, b = input$b, c = input$c)
      lapply(guesses, function(guess) loglik_surface(responses, theta, a = grid, b = grid, c = guess))
    })

    output$plot <- plotly::renderPlotly(plot_loglik_surfaces(surfaces(), guesses))
  })
}
