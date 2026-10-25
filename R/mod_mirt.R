##########################################################################################
#
##########################################################################################
#' MIRT Dichotomous module - UI
#'
#' Controls for the item response function, the compensatory or
#' non-compensatory model, the locations and discriminations of a dichotomous
#' item on two dimensions, its asymptotes and optional names for the
#' dimensions; and three sub-tabs with its response surface, its contour plot
#' (with a slider for the number of contour levels) and its information
#' surface.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_mirt_ui("mirt"))
#' }
mod_mirt_ui <- function(id) {
  ns <- NS(id)
  tagList(
    credit_line("Unknown Contributor"),
    sidebarLayout(
      sidebarPanel(
        width = 3,
        selectInput(ns("D"),
          label = "Item Response Function",
          choices = list("Logistic (D = 1)" = 1, "Normal ogive approximation (D = 1.702)" = 2), selected = 2
        ),
        selectInput(ns("compensatory"), label = "Compensatory", choices = list("Yes" = 1, "No" = 2), selected = 1),
        sliderInput(ns("b1"), label = "\u{03b8}1 location", min = -10, max = 10, value = 0, step = 0.1),
        sliderInput(ns("b2"), label = "\u{03b8}2 location", min = -10, max = 10, value = 0, step = 0.1),
        sliderInput(ns("a1"), label = "\u{03b8}1 discrimination", min = -10, max = 10, value = 1, step = 0.1),
        sliderInput(ns("a2"), label = "\u{03b8}2 discrimination", min = -10, max = 10, value = 1, step = 0.1),
        sliderInput(ns("c"), label = "Lower Asymptote", min = 0, max = 0.4, value = 0, step = 0.1),
        sliderInput(ns("d"), label = "Upper Asymptote", min = 0, max = 1, value = 1, step = 0.1),
        textInput(ns("name1"), label = "Name of \u{03b8}1 (optional)", value = ""),
        textInput(ns("name2"), label = "Name of \u{03b8}2 (optional)", value = "")
      ),
      mainPanel(
        width = 9,
        tabsetPanel(
          tabPanel(
            "Item Response Surface",
            plotly::plotlyOutput(ns("surface"), width = "100%", height = "700px")
          ),
          tabPanel(
            "Contour Plot",
            inputPanel(sliderInput(ns("nlevels"), label = "N Contour Levels", min = 10, max = 100, value = 10, step = 1)),
            plotly::plotlyOutput(ns("contour"), width = "100%", height = "700px")
          ),
          tabPanel(
            "Information Plot",
            plotly::plotlyOutput(ns("information"), width = "100%", height = "700px")
          )
        )
      )
    )
  )
}
##########################################################################################
#
##########################################################################################
#' MIRT Dichotomous module - server
#'
#' Computes the response surface of \code{\link{prob_mirt}()} and the
#' information of \code{\link{info_mirt}()} on a grid of 50 by 50 abilities
#' from -4 to 4, and plots them as surfaces and contours. The contour plot
#' marks the line where the probability is halfway between the asymptotes and,
#' for the compensatory model, the \code{\link{item_vector}()}. A
#' discrimination of 0 is rejected with a message in place of the plots.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   \code{\link{mod_mirt_ui}()}.
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_mirt_server("mirt")
#' }
#' }
mod_mirt_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    theta <- seq(-4, 4, length.out = 50)
    item <- reactive({
      validate(need(input$a1 != 0 && input$a2 != 0, "Select a discrimination value other than 0 (zero)!"))
      list(
        a = c(input$a1, input$a2),
        b = c(input$b1, input$b2),
        c = input$c,
        d = input$d,
        D = scaling_constant(input$D),
        compensatory = input$compensatory == "1"
      )
    })
    xlab <- reactive(axis_title(input$name1, "\u{03b8}1"))
    ylab <- reactive(axis_title(input$name2, "\u{03b8}2"))
    surface <- reactive(do.call(prob_mirt, c(list(theta1 = theta, theta2 = theta), item())))

    output$surface <- plotly::renderPlotly({
      plot_mirt_surface(theta, theta, surface(), xlab(), ylab())
    })

    output$contour <- plotly::renderPlotly({
      arrow <- if (item()$compensatory) item_vector(item()$a, item()$b)
      plot_mirt_contour(theta, theta, surface(), input$nlevels, (item()$c + item()$d) / 2, arrow, xlab(), ylab())
    })

    output$information <- plotly::renderPlotly({
      info <- do.call(info_mirt, c(list(theta1 = theta, theta2 = theta), item()))
      plot_mirt_surface(theta, theta, info, xlab(), ylab(),
        zlab = "Information", zrange = NULL, eye = list(x = -1.5, y = 1.5, z = 1.5)
      )
    })
  })
}
