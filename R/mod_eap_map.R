##########################################################################################
#
##########################################################################################
#' EAP-MAP Rasch module - UI
#'
#' Controls for the raw score, the number of quadrature points and the mean,
#' standard deviation and skewness of the prior, notes on the response
#' patterns and item difficulties assumed, and two sub-tabs: four separate
#' plots of the prior, trace lines, likelihood and posterior, and one plot that
#' combines them.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_eap_map_ui("eap_map"))
#' }
mod_eap_map_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("by Metin Bulus & Wes Bonifay"),
    sidebarLayout(
      sidebarPanel(
        width = 3,
        sliderInput(ns("score"), label = "Raw Score (r)", min = 0, max = 5, value = 2, step = 1),
        sliderInput(ns("quadrature"), label = "Quadrature Points", min = 10, max = 100, value = 10, step = 10),
        sliderInput(ns("mean"), label = "Prior Mean", min = -2, max = 2, value = 0, step = 0.1),
        sliderInput(ns("sd"), label = "Prior SD", min = 0.1, max = 2, value = 1, step = 0.1),
        sliderInput(ns("skew"), label = "Prior Skewness", min = 0.5, max = 2, value = 1, step = 0.1),
        helpText("Respondent's raw score are assumed to come from following patterns: r=0,patt=00000; r=1,patt=10000; r=2,patt=11000; r=3,patt=11100; r=4,patt=11110; and r=5,patt=11111."),
        helpText("Note: Default values replicate the analysis by de Ayala (2009,p. 79) where difficulty parameters for Item 1-5 are fixed at -2.155,-.245,.206,.984,and 1.211.")
      ),
      mainPanel(
        width = 9,
        tabsetPanel(
          tabPanel(
            "Separate",
            fluidRow(
              column(width = 6, plotly::plotlyOutput(ns("prior"))),
              column(width = 6, plotly::plotlyOutput(ns("tracelines"))),
              column(width = 6, plotly::plotlyOutput(ns("likelihood"))),
              column(width = 6, plotly::plotlyOutput(ns("posterior")))
            )
          ),
          tabPanel("Combined", plotly::plotlyOutput(ns("combined"), width = "100%", height = "800px"))
        )
      )
    )
  )
}
##########################################################################################
#
##########################################################################################
#' EAP-MAP Rasch module - server
#'
#' Estimates the ability of the chosen raw score with \code{\link{eap_map}()}
#' and draws the five plots of \code{\link{plot_prior}()} and its siblings.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_eap_map_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_eap_map_server("eap_map")
#' }
#' }
mod_eap_map_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    estimate <- reactive({
      eap_map(response_pattern(input$score),
        quadrature = input$quadrature, mean = input$mean, sd = input$sd, skew = input$skew
      )
    })

    output$prior <- plotly::renderPlotly(plot_prior(estimate()))
    output$tracelines <- plotly::renderPlotly(plot_tracelines(estimate()))
    output$likelihood <- plotly::renderPlotly(plot_likelihood(estimate()))
    output$posterior <- plotly::renderPlotly(plot_posterior(estimate()))
    output$combined <- plotly::renderPlotly(plot_eap_combined(estimate()))
  })
}
