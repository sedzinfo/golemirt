##########################################################################################
#
##########################################################################################
#' The application server-side logic
#'
#' Wires up the Shiny module server of each tab: the seven tabs of the Models
#' menu, then the four tabs of the Estimation menu.
#'
#' @param input,output,session Internal parameters for \code{shiny}.
#'   DO NOT REMOVE.
#'
#' @noRd
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(ui = app_ui, server = app_server)
#' }
app_server <- function(input, output, session) {
  mod_rasch_4pl_server("rasch_4pl")
  mod_gpcm_server("gpcm")
  mod_grm_server("grm")
  mod_grsm_server("grsm")
  mod_nrm_server("nrm")
  mod_tirt_server("tirt")
  mod_mirt_server("mirt")
  mod_mle_rasch_server("mle_rasch")
  mod_mle_2pl_server("mle_2pl")
  mod_mle_3pl_server("mle_3pl")
  mod_eap_map_server("eap_map")

  # answers the pings of keep_alive.js, so that proxies do not close an idle connection
  output$keep_alive <- renderText({
    req(input$count)
    paste("keep alive", input$count)
  })
}
