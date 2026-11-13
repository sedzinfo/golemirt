test_that("the page has the eleven tabs of the Models and Estimation menus, and the CAT tab", {
  html <- htmltools::renderTags(app_ui(NULL))$html
  expect_match(html, "IRT Models and Estimation using IRTDemo", fixed = TRUE)
  expect_match(html, "data-value=\"Models\"", fixed = TRUE)
  expect_match(html, "data-value=\"Estimation\"", fixed = TRUE)
  tabs <- c(
    "Rasch-4PL", "PCM-GPCM", "GRM", "RSM-GRSM", "NRM", "TIRT", "MIRT Dichotomous",
    "MLE Rasch", "MLE 2PL", "MLE 3PL", "EAP-MAP Rasch"
  )
  for (tab in tabs) expect_match(html, paste0(">", tab, "<"), fixed = TRUE)
  expect_match(html, "data-value=\"CAT\"", fixed = TRUE)
})

test_that("the About tab is in the navbar, with the acknowledgments", {
  html <- htmltools::renderTags(app_ui(NULL))$html
  expect_match(html, "data-value=\"About\"", fixed = TRUE)
  expect_match(html, ">Acknowledgments<", fixed = TRUE)
  expect_match(html, "Wes Bonifay", fixed = TRUE)
  expect_match(html, "Metin Bulus", fixed = TRUE)
  expect_match(html, "Kostas Maistrelis", fixed = TRUE)
  expect_match(html, "https://cran.r-project.org/package=irtDemo", fixed = TRUE)
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
  expect_match(with$head, "https://sedzinfo.github.io/shiny/analytics.js", fixed = TRUE)
  expect_match(with$html, "#cookie-settings", fixed = TRUE)
  without <- page(FALSE)
  expect_no_match(without$head, "consent.js", fixed = TRUE)
  expect_no_match(without$html, "cookie-settings", fixed = TRUE)
})

test_that("the page has the dark mode, and every file of inst/app/www that it names exists", {
  head <- htmltools::renderTags(app_ui(NULL, analytics = TRUE, keep_alive = TRUE))$head
  expect_match(head, "www/dark_mode.css", fixed = TRUE)
  expect_match(head, "https://sedzinfo.github.io/shiny/dark_mode.js", fixed = TRUE)
  # the files are added by name in add_external_resources(), so a renamed or missing one would go unnoticed
  files <- unique(regmatches(head, gregexpr("www/[A-Za-z0-9_.-]+", head))[[1]])
  expect_equal(files[!file.exists(file.path(app_sys("app"), files))], character())
})

test_that("the head has the description and the address of the live app for link previews", {
  head <- htmltools::renderTags(app_ui(NULL))$head
  expect_match(head, paste0("<meta name=\"description\" content=\"", app_meta$description, "\"/>"), fixed = TRUE)
  expect_match(head, "<meta property=\"og:url\" content=\"https://sedzinfo-golemirt.share.connect.posit.cloud/\"/>", fixed = TRUE)
  # search engines cut descriptions longer than about 160 characters
  expect_lte(nchar(app_meta$description), 160)
})

test_that("the page has the phone layout: its files, the short title, and the slider tabs marked plot-first", {
  rendered <- htmltools::renderTags(app_ui(NULL))
  expect_match(rendered$head, "www/mobile.css", fixed = TRUE)
  expect_match(rendered$head, "www/mobile.js", fixed = TRUE)
  expect_match(rendered$html, "<span class=\"d-md-none\">IRT Explorer</span>", fixed = TRUE)
  # one per slider tab with a single chart: 9 tabs, and the 3 of TIRT; not EAP-MAP, whose 4 charts
  # would not fit at the top of a phone's screen
  rows <- regmatches(rendered$html, gregexpr("class=\"row plot-first\"", rendered$html))[[1]]
  expect_length(rows, 12)
  eap <- htmltools::renderTags(mod_eap_map_ui("eap_map"))$html
  expect_no_match(eap, "plot-first", fixed = TRUE)
})

test_that("the files shared by the apps (analytics.js, keep_alive.js, dark_mode.js) come from sedzinfo.github.io, not from inst/app/www", {
  head <- htmltools::renderTags(app_ui(NULL, analytics = TRUE, keep_alive = TRUE))$head
  expect_match(head, "https://sedzinfo.github.io/shiny/analytics.js", fixed = TRUE)
  expect_no_match(head, "www/analytics.js", fixed = TRUE)
  expect_match(head, "https://sedzinfo.github.io/shiny/keep_alive.js", fixed = TRUE)
  expect_no_match(head, "www/keep_alive.js", fixed = TRUE)
  expect_match(head, "https://sedzinfo.github.io/shiny/dark_mode.js", fixed = TRUE)
  expect_no_match(head, "www/dark_mode.js", fixed = TRUE)
})
