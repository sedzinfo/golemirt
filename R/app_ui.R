##########################################################################################
#
##########################################################################################
#' The application User-Interface
#'
#' Defines the top-level navbar layout: a Models menu with one tab per IRT
#' model and an Estimation menu with one tab per estimation method, each tab
#' being a Shiny module.
#'
#' @param request Internal parameter for \code{shiny}. DO NOT REMOVE.
#' @param analytics `TRUE` to add Google Analytics and its cookie banner,
#'   see `analytics_resources()`.
#' @param keep_alive `TRUE` to ping the server every 15 seconds while the
#'   page is open, so that proxies do not close idle connections.
#' @import shiny
#' @noRd
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(ui = app_ui, server = app_server)
#' }
app_ui <- function(request, analytics = FALSE, keep_alive = TRUE) {
  tagList(
    add_external_resources(analytics, keep_alive),
    navbarPage(
      title = "IRT Models and Estimation using IRTDemo",
      windowTitle = "IRT Explorer",
      collapsible = TRUE,
      # Bootstrap 5, whose classes the cookie banner of consent.js is styled with
      theme = bslib::bs_theme(version = 5),
      footer = if (analytics) analytics_footer(),
      navbarMenu(
        "Models",
        tabPanel("Rasch-4PL", mod_rasch_4pl_ui("rasch_4pl")),
        tabPanel("PCM-GPCM", mod_gpcm_ui("gpcm")),
        tabPanel("GRM", mod_grm_ui("grm")),
        tabPanel("RSM-GRSM", mod_grsm_ui("grsm")),
        tabPanel("NRM", mod_nrm_ui("nrm")),
        tabPanel("TIRT", mod_tirt_ui("tirt")),
        tabPanel("MIRT Dichotomous", mod_mirt_ui("mirt"))
      ),
      navbarMenu(
        "Estimation",
        tabPanel("MLE Rasch", mod_mle_rasch_ui("mle_rasch")),
        tabPanel("MLE 2PL", mod_mle_2pl_ui("mle_2pl")),
        tabPanel("MLE 3PL", mod_mle_3pl_ui("mle_3pl")),
        tabPanel("EAP-MAP Rasch", mod_eap_map_ui("eap_map"))
      )
    ),
    if (keep_alive) div(style = "display:none", textOutput("keep_alive"))
  )
}
##########################################################################################
#
##########################################################################################
#' Add external resources to the application
#'
#' Internally used to add JS/CSS/favicon resources inside the Shiny
#' application.
#'
#' @import shiny
#' @importFrom golem add_resource_path favicon bundle_resources
#' @noRd
#'
#' @examples
#' \dontrun{
#' # called from inside app_ui():
#' shiny::tagList(golem_add_external_resources(), shiny::fluidPage())
#' }
add_external_resources <- function(analytics = FALSE, keep_alive = TRUE) {
  addResourcePath("www", app_sys("app/www"))
  tags$head(
    tags$link(rel = "icon", type = "image/svg+xml", href = "www/favicon.svg"),
    tags$link(rel = "stylesheet", href = "www/styles.css"),
    if (keep_alive) tags$script(src = "www/keep_alive.js"),
    if (analytics) analytics_resources()
  )
}