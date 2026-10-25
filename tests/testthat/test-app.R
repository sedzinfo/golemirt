test_that("the page has the eleven tabs, in a Models and an Estimation menu", {
  html <- htmltools::renderTags(app_ui(NULL))$html
  expect_match(html, "IRT Models and Estimation using IRTDemo", fixed = TRUE)
  expect_match(html, "data-value=\"Models\"", fixed = TRUE)
  expect_match(html, "data-value=\"Estimation\"", fixed = TRUE)
  tabs <- c(
    "Rasch-4PL", "PCM-GPCM", "GRM", "RSM-GRSM", "NRM", "TIRT", "MIRT Dichotomous",
    "MLE Rasch", "MLE 2PL", "MLE 3PL", "EAP-MAP Rasch"
  )
  for (tab in tabs) expect_match(html, paste0(">", tab, "<"), fixed = TRUE)
})

test_that("run_app() returns a shiny app with the golem options", {
  app <- run_app(greeting = "hello")
  expect_s3_class(app, "shiny.appobj")
  expect_equal(app$appOptions$golem_options$greeting, "hello")
})

test_that("the server starts every module", {
  expect_no_error(testServer(app_server, {}))
})

test_that("Google Analytics and its cookie banner are in the page only when asked for", {
  page <- function(analytics) htmltools::renderTags(app_ui(NULL, analytics = analytics))
  with <- page(TRUE)
  expect_match(with$head, "https://sedzinfo.github.io/consent.js", fixed = TRUE)
  expect_match(with$head, "www/analytics.js", fixed = TRUE)
  expect_match(with$html, "#cookie-settings", fixed = TRUE)
  without <- page(FALSE)
  expect_no_match(without$head, "consent.js", fixed = TRUE)
  expect_no_match(without$html, "cookie-settings", fixed = TRUE)
})
