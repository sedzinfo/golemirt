##########################################################################################
#
##########################################################################################
#' Rasch-4PL module - UI
#'
#' Controls for the scaling constant and the four parameters of a dichotomous
#' item, a choice of the probabilities to plot, a line naming the model that
#' the values define, and the item characteristic curve.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_rasch_4pl_ui("rasch_4pl"))
#' }
mod_rasch_4pl_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("by Metin Bulus"),
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("D"), label = "Scaling Constant", choices = list("1" = 1, "1.702" = 2), selected = 1),
        sliderInput(ns("a"), label = "Discrimination (a)", min = -10, max = 10, value = 1, step = 0.1),
        sliderInput(ns("b"), label = "Difficulty (b)", min = -10, max = 10, value = 0, step = 0.1),
        sliderInput(ns("c"), label = "Guessing (c)", min = 0, max = 1, value = 0, step = 0.01),
        sliderInput(ns("d"), label = "Inattentiveness (d)", min = 0, max = 1, value = 1, step = 0.01),
        selectInput(ns("probability"),
          label = "Modeled Probability",
          choices = list("P(X=1|theta)" = 1, "P(X|theta)" = 2), selected = 2
        ),
        textOutput(ns("feedback"))
      ),
      mainPanel(plotly::plotlyOutput(ns("plot"), width = "100%", height = "700px"))
    )
  )
}
##########################################################################################
#
##########################################################################################
#' Rasch-4PL module - server
#'
#' Names the model that the parameters define (Rasch, 1PL or 2PL, 3PL or 4PL)
#' and plots \eqn{P(X = 1 \mid \theta)}{P(X = 1 | theta)}, with
#' \eqn{P(X = 0 \mid \theta)}{P(X = 0 | theta)} when both probabilities are
#' chosen, from -6 to 6 in steps of 0.1.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_rasch_4pl_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_rasch_4pl_server("rasch_4pl")
#' }
#' }
mod_rasch_4pl_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    theta <- seq(-6, 6, by = 0.1)
    title <- reactive(model_name_4pl(input$a, input$c, input$d))

    output$feedback <- renderText({
      paste(title(), ": a=", input$a, " b=", input$b, " c=", input$c, " d=", input$d)
    })

    output$plot <- plotly::renderPlotly({
      p <- prob_4pl(theta, a = input$a, b = input$b, c = input$c, d = input$d, D = scaling_constant(input$D))
      probs <- if (input$probability == "1") cbind("1" = p) else cbind("1" = p, "0" = 1 - p)
      plot_category_curves(theta, probs, title(), ylab = "P(x)")
    })
  })
}
