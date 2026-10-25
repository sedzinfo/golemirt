##########################################################################################
#
##########################################################################################
#' MLE Rasch module - UI
#'
#' Controls for the raw score, the starting value and the Newton-Raphson
#' iteration to show, notes on the response patterns and item difficulties
#' assumed, the log-likelihood plot and the numbers of the step.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_mle_rasch_ui("mle_rasch"))
#' }
mod_mle_rasch_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("by unknown contributor"),
    sidebarLayout(
      sidebarPanel(
        width = 4,
        sliderInput(ns("score"), label = "Raw Score (r)", min = 0, max = 5, value = 2, step = 1),
        sliderInput(ns("start"), label = "Starting Value", min = -2, max = 2, value = 0, step = 0.5),
        sliderInput(ns("iteration"), label = "Iteration", min = 1, max = 5, value = 1, step = 1),
        strong("Note:"),
        p("Respondent's raw score are assumed to come from following patterns:
          r=0,p=00000;r=1,p=10000;r=2,p=11000;
          r=3,p=11100;r=4,p=11110;r=5,p=11111."),
        p("Item difficulties for five item instrument are assumed to be known (-1.90,-0.60,-0.25,0.30,0.45) and are provided in de Ayala (2009,p.22)."),
        p("This app replicates person locations in Table 2.2 in de Ayala (2009,p.28)")
      ),
      mainPanel(
        width = 8,
        plotly::plotlyOutput(ns("plot"), height = "800px"),
        verbatimTextOutput(ns("step"))
      )
    )
  )
}
##########################################################################################
#
##########################################################################################
#' MLE Rasch module - server
#'
#' Takes the chosen number of Newton-Raphson steps with
#' \code{\link{newton_raphson_rasch}()} and shows the last one, in a plot and
#' as numbers.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_mle_rasch_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_mle_rasch_server("mle_rasch")
#' }
#' }
mod_mle_rasch_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    nr <- reactive({
      newton_raphson_rasch(response_pattern(input$score), start = input$start, iterations = input$iteration)
    })

    output$plot <- plotly::renderPlotly(plot_newton_raphson(nr()))

    output$step <- renderText({
      step <- nr()$steps[input$iteration, ]
      paste0(
        "Newton-Raphson step:\n",
        "theta1=theta0-(LL' / LL'')\n",
        round(step$end, 4), "=", round(step$start, 4), "-(", round(step$d1, 4), " / ", round(step$d2, 4), ")\n\n",
        "Acute angle with abscissa=", round(step$angle), " degrees"
      )
    })
  })
}
