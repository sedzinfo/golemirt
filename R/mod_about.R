##########################################################################################
#
##########################################################################################
#' About page - UI
#'
#' A static page: what the app is for, where it comes from, the
#' acknowledgments, the references of the models and estimation methods, and
#' the license and links of the package. It has no inputs, so it has no
#' module server.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{tagList} of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_about_ui("about"))
#' }
mod_about_ui <- function(id) {
  ns <- NS(id)
  link <- function(href, text) tags$a(href = href, target = "_blank", rel = "noopener", text)
  references <- c(
    "Andrich, D. (1978). A rating formulation for ordered response categories. Psychometrika, 43(4), 561-573.",
    "Baker, F. B. (1992). Item Response Theory: Parameter Estimation Techniques. Marcel Dekker.",
    "Bulus, M., & Bonifay, W. (2022). irtDemo R Package: Pedagogical Interactive Web Applications for Estimation, Scoring, and Multi Dimensionality in Item Response Theory. Anadolu University Journal of Education Faculty, 6(1), 92-108.",
    "de Ayala, R. J. (2009). The Theory and Practice of Item Response Theory. Guilford Press.",
    "Magis, D. (2013). A note on the item information function of the four-parameter logistic model. Applied Psychological Measurement, 37(4), 304-315.",
    "Masters, G. N. (1982). A Rasch model for partial credit scoring. Psychometrika, 47(2), 149-174.",
    "Muraki, E. (1990). Fitting a polytomous item response model to Likert-type data. Applied Psychological Measurement, 14(1), 59-71.",
    "Muraki, E. (1992). A generalized partial credit model: Application of an EM algorithm. Applied Psychological Measurement, 16(2), 159-176."
  )
  div(
    id = ns("page"),
    class = "container py-4",
    style = "max-width: 860px;",
    h2("About"),
    p(
      strong("golemirt"), " is an interactive application for learning and teaching Item Response",
      " Theory (IRT). The ", strong("Models"), " menu draws the response curves of the main IRT models,",
      " so that you can see how each item parameter shapes them; the ", strong("Estimation"), " menu",
      " shows how abilities and item parameters are estimated, by maximum likelihood and by Bayesian",
      " EAP and MAP estimation. Every plot is an interactive chart that is redrawn as soon as a slider moves."
    ),
    p(
      "The default settings of the Estimation tabs reproduce the results of de Ayala (2009). Every",
      " model, estimation method and plot of the app is also an R function of the package."
    ),
    h3("Acknowledgments", class = "mt-4"),
    p(
      "The plots were originally developed by ", strong("Wes Bonifay"), " and ", strong("Metin Bulus"),
      " for the ", link("https://cran.r-project.org/package=irtDemo", "irtDemo"), " package on CRAN.",
      " ", strong("Dimitrios Zacharatos"), " modified and expanded them in the modelsirt and mleirt",
      " packages, which golemirt brings together in one app, rebuilding the visualisations with",
      " Plotly, adding further IRT models and improving the interface."
    ),
    p(
      "Special thanks to ", link("https://github.com/maisk", "Kostas Maistrelis"),
      " for contributing the implementation of the Thurstonian IRT curves."
    ),
    p(
      "The app is built with ",
      link("https://shiny.posit.co/", "Shiny"), ", ",
      link("https://thinkr-open.github.io/golem/", "golem"), ", ",
      link("https://rstudio.github.io/bslib/", "bslib"), " and ",
      link("https://plotly.com/r/", "plotly"), ", and uses ",
      link("https://cran.r-project.org/package=fGarch", "fGarch"),
      " for the skew-normal prior of the EAP-MAP tab. Thanks to their authors and to the R community."
    ),
    h3("References", class = "mt-4"),
    tags$ul(lapply(references, tags$li)),
    h3("License and source", class = "mt-4"),
    p(
      "golemirt is free software under the ",
      link("https://www.gnu.org/licenses/gpl-3.0.html", "GNU General Public License v3"), ".",
      " Source code: ", link("https://github.com/sedzinfo/golemirt", "github.com/sedzinfo/golemirt"),
      "; documentation: ", link("https://sedzinfo.github.io/golemirt/", "sedzinfo.github.io/golemirt"),
      "; issues and suggestions: ", link("https://github.com/sedzinfo/golemirt/issues", "the issues page"), "."
    ),
    p("Maintainer: Dimitrios Zacharatos.", class = "text-body-secondary")
  )
}
