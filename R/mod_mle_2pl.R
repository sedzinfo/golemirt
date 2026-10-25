##########################################################################################
#
##########################################################################################
#' MLE 2PL module - UI
#'
#' Controls for the true discrimination and location of an item, a note on
#' what the plot shows, and the log-likelihood surface.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_mle_2pl_ui("mle_2pl"))
#' }
mod_mle_2pl_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("by unknown contributor"),
    sidebarLayout(
      sidebarPanel(
        width = 3,
        sliderInput(ns("a"), label = "Discrimination", min = -3, max = 3, value = 1, step = 0.1),
        sliderInput(ns("b"), label = "Location", min = -3, max = 3, value = -0.5, step = 0.1),
        helpText("Values on the control panel are true values and projection of red dot corresponds to the intersection of discrimination and difficulty parameters that maximize the joint log-likelihood.")
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
#' MLE 2PL module - server
#'
#' Simulates the responses of 50 people with abilities spread evenly from -3
#' to 3 to an item with the true parameters, again whenever a true value
#' changes, and plots their log-likelihood for every discrimination and
#' difficulty from -3 to 3 in steps of 0.1, with its highest point.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_mle_2pl_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_mle_2pl_server("mle_2pl")
#' }
#' }
mod_mle_2pl_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    theta <- seq(-3, 3, length.out = 50)
    grid <- seq(-3, 3, by = 0.1)
    surface <- reactive({
      responses <- simulate_responses(theta, a = input$a, b = input$b)
      loglik_surface(responses, theta, a = grid, b = grid)
    })

    output$plot <- plotly::renderPlotly(plot_loglik_surface(surface()))
  })
}
