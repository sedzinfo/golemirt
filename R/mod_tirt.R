##########################################################################################
#
##########################################################################################
#' TIRT module - UI
#'
#' Three sub-tabs, each named by the formula it plots: a single binary outcome
#' with the parameters of factor analysis, the choice of one item over another
#' in a pair, and the same comparison in intercept and slope form. Each has
#' sliders for its parameters and for the range of the trait axis.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_tirt_ui("tirt"))
#' }
mod_tirt_ui <- function(id) {
  ns <- NS(id)
  tagList(
    withMathJax(),
    tabsetPanel(
      tabPanel(
        "$$\\phi\\,\\left[\\frac{-\\gamma_l+\\lambda_l\\eta}{\\sqrt{\\psi^2_l}}\\right]$$",
        sidebarLayout(
          sidebarPanel(
            sliderInput(ns("gamma"), label = "$$\\gamma$$", min = -10, max = 10, value = 0, step = 0.1),
            sliderInput(ns("lambda"), label = "$$\\lambda$$", min = -10, max = 10, value = 0.5, step = 0.1),
            sliderInput(ns("range_single"), label = "$$\\eta$$", min = 1, max = 100, value = 6, step = 1),
            sliderInput(ns("psi"), label = "$$\\psi$$", min = 0, max = 10, value = 0.5, step = 0.1)
          ),
          mainPanel(plotly::plotlyOutput(ns("plot_single"), width = "100%", height = "700px"))
        )
      ),
      tabPanel(
        "$$\\phi\\,\\left[\\frac{-\\gamma+\\lambda_l\\eta_a-\\lambda_k\\eta_b}{\\sqrt{\\psi^2_i+\\psi^2_k}}\\right]$$",
        sidebarLayout(
          sidebarPanel(
            sliderInput(ns("gamma_pair"), label = "$$\\gamma$$", min = -10, max = 10, value = 0, step = 0.1),
            sliderInput(ns("lambda_i"), label = "$$\\lambda_i$$", min = -10, max = 10, value = 0.5, step = 0.1),
            sliderInput(ns("lambda_k"), label = "$$\\lambda_k$$", min = -10, max = 10, value = 0, step = 0.1),
            sliderInput(ns("range_pair"), label = "$$\\eta$$", min = 1, max = 100, value = 6, step = 1),
            sliderInput(ns("psi_i"), label = "$$\\psi_i$$", min = 0, max = 10, value = 0.5, step = 0.1),
            sliderInput(ns("psi_k"), label = "$$\\psi_k$$", min = 0, max = 10, value = 0.5, step = 0.1)
          ),
          mainPanel(plotly::plotlyOutput(ns("plot_pair"), width = "100%", height = "700px"))
        )
      ),
      tabPanel(
        "$$\\phi\\,\\left(\\alpha+\\left(\\beta_i-\\beta_k\\right)\\eta\\right)$$",
        sidebarLayout(
          sidebarPanel(
            sliderInput(ns("alpha"), label = "$$\\alpha$$", min = -10, max = 10, value = 0, step = 0.1),
            sliderInput(ns("beta_i"), label = "$$\\beta_i$$", min = -10, max = 10, value = 0.5, step = 0.1),
            sliderInput(ns("beta_k"), label = "$$\\beta_k$$", min = -10, max = 10, value = 0, step = 0.1),
            sliderInput(ns("range_intercept"), label = "$$\\eta$$", min = 1, max = 100, value = 6, step = 1)
          ),
          mainPanel(plotly::plotlyOutput(ns("plot_intercept"), width = "100%", height = "700px"))
        )
      )
    )
  )
}
##########################################################################################
#
##########################################################################################
#' TIRT module - server
#'
#' Plots \code{\link{prob_tirt}()}, \code{\link{prob_tirt_pair}()} and
#' \code{\link{prob_tirt_intercept}()} on the three sub-tabs, each from
#' \eqn{-\eta}{-eta} to \eqn{\eta}{eta} in steps of 0.1, where \eqn{\eta}{eta}
#' is the range set on the sub-tab.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_tirt_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_tirt_server("tirt")
#' }
#' }
mod_tirt_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$plot_single <- plotly::renderPlotly({
      eta <- seq(-input$range_single, input$range_single, by = 0.1)
      plot_tirt(eta, prob_tirt(eta, gamma = input$gamma, lambda = input$lambda, psi = input$psi))
    })

    output$plot_pair <- plotly::renderPlotly({
      eta <- seq(-input$range_pair, input$range_pair, by = 0.1)
      plot_tirt(eta, prob_tirt_pair(eta,
        gamma = input$gamma_pair, lambda_i = input$lambda_i, lambda_k = input$lambda_k,
        psi_i = input$psi_i, psi_k = input$psi_k
      ))
    })

    output$plot_intercept <- plotly::renderPlotly({
      eta <- seq(-input$range_intercept, input$range_intercept, by = 0.1)
      plot_tirt(eta, prob_tirt_intercept(eta, alpha = input$alpha, beta_i = input$beta_i, beta_k = input$beta_k))
    })
  })
}
