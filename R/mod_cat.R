##########################################################################################
#
##########################################################################################
#' CAT module - UI
#'
#' The adaptive test with its workings in view. A sidebar holds the settings: the
#' questionnaire (one of the examples, one for each IRT model, or a csv of your own,
#' see \code{\link{read_questionnaire}}), the scales and the standard error at which
#' each one stops. The main area has, side by side, the current item and a chart of the
#' estimate and standard error after every answer, then the progress of each scale and
#' the history of every answer given.
#'
#' @param id Character. Module namespace id.
#'
#' @return A \code{bslib} sidebar layout.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_cat_ui("cat"))
#' }
mod_cat_ui <- function(id) {
  ns <- NS(id)
  examples <- example_questionnaires()
  bslib::layout_sidebar(
    fillable = FALSE,
    sidebar = bslib::sidebar(
      title = "Settings",
      width = 320,
      # on phones the settings sit above the test, not behind a toggle, as the test starts there
      open = list(desktop = "open", mobile = "always-above"),
      selectInput(ns("source"), "Questionnaire",
        choices = c(names(examples), "Your own csv file\u2026" = "upload"),
        selected = names(examples)[1], width = "100%"
      ),
      conditionalPanel(
        sprintf("input['%s'] == 'upload'", ns("source")),
        fileInput(ns("upload"), NULL, accept = c(".csv", "text/csv"), placeholder = "No file chosen", width = "100%")
      ),
      uiOutput(ns("source_info")),
      checkboxGroupInput(ns("scales_include"), "Scales", choices = character(0)),
      sliderInput(ns("se_threshold"), "Stop a scale at standard error",
        min = 0.10, max = 0.70, value = 0.45, step = 0.01, width = "100%"
      ),
      uiOutput(ns("threshold_note")),
      actionButton(ns("start"), "Start / restart the test", class = "btn-primary w-100"),
      p(
        class = "small text-body-secondary mt-2 mb-0",
        "\u03b8 and SE are standardized per scale (divided by the sd of the \u03b8 distribution",
        " of the calibration), so a threshold is the same target in every scale."
      )
    ),
    # two rows, each side by side from 1200px wide and stacked below that, where the
    # tables would be too narrow: the item and the chart, then the progress and
    # the history
    bslib::layout_columns(
      col_widths = bslib::breakpoints(sm = 12, xl = c(5, 7)),
      bslib::card(
        bslib::card_header(uiOutput(ns("status"), inline = TRUE)),
        bslib::card_body(
          uiOutput(ns("question_ui")),
          uiOutput(ns("submit_ui")),
          uiOutput(ns("summary_ui"))
        )
      ),
      bslib::card(
        full_screen = TRUE,
        bslib::card_header("\u03b8 and SE after each answer"),
        bslib::card_body(plotly::plotlyOutput(ns("traj_plot"), height = "400px"))
      )
    ),
    bslib::layout_columns(
      col_widths = bslib::breakpoints(sm = 12, xl = c(5, 7)),
      bslib::card(
        bslib::card_header("Progress by scale"),
        bslib::card_body(
          # the smaller type of Bootstrap keeps the tables whole in the half-width cards
          div(class = "small", style = "overflow-x: auto;", tableOutput(ns("progress_table"))),
          uiOutput(ns("overall_ui"))
        )
      ),
      bslib::card(
        bslib::card_header("Response history"),
        bslib::card_body(
          style = "max-height: 420px; overflow: auto;",
          div(class = "small", tableOutput(ns("log_table")))
        )
      )
    )
  )
}
##########################################################################################
#
##########################################################################################
#' CAT module - server
#'
#' Runs an adaptive test on the questionnaire chosen (\code{\link{read_questionnaire}}),
#' with the session functions (\code{\link{cat_start}}, \code{\link{cat_answer}}), and
#' draws its course with \code{\link{plot_cat_trajectory}}.
#'
#' @param id Character. Module namespace id, the same as in \code{\link{mod_cat_ui}}.
#'
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' # inside app_server():
#' mod_cat_server("cat")
#' }
mod_cat_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    examples <- example_questionnaires()
    models <- irt_models()
    rv <- reactiveValues(s = NULL)
    # a questionnaire that reads well can still have numbers that break the engine:
    # show the error and keep the session, instead of closing it
    safely <- function(expr, fallback) {
      tryCatch(expr, error = function(e) {
        showNotification(paste("The test stopped:", conditionMessage(e)), type = "error", duration = 10)
        fallback
      })
    }

    # the questionnaire chosen: an example or an uploaded csv
    loaded <- reactive({
      req(input$source)
      if (identical(input$source, "upload")) {
        if (is.null(input$upload)) return(list(bank = NULL, error = NULL, path = NULL, name = NULL))
        path <- input$upload$datapath
        name <- input$upload$name
      } else {
        path <- examples[[input$source]]
        name <- basename(path)
      }
      tryCatch(
        list(bank = read_questionnaire(path), error = NULL, path = path, name = name),
        error = function(e) list(bank = NULL, error = sub("^[^:]*: ", "", conditionMessage(e)), path = NULL, name = name)
      )
    })

    observeEvent(loaded(), {
      bank <- loaded()$bank
      scales <- if (is.null(bank)) character(0) else unique(bank$scale)
      updateCheckboxGroupInput(session, "scales_include", choices = scales, selected = scales)
      rv$s <- NULL
    })

    output$source_info <- renderUI({
      l <- loaded()
      if (!is.null(l$error)) {
        return(div(class = "alert alert-danger small py-2", strong(l$name), br(), l$error))
      }
      if (is.null(l$bank)) {
        return(p(
          class = "small text-body-secondary",
          "A csv with one row per item: the text, the answer options and the coefficients",
          " of a model fitted with mirt. Download an example to see the columns."
        ))
      }
      bank <- l$bank
      used <- unique(bank$model)
      tagList(
        p(
          class = "small mb-1",
          strong(paste(models$label[match(used, models$model)], collapse = " + ")), br(),
          span(class = "text-body-secondary", sprintf(
            "%d %s, %d items", length(unique(bank$scale)),
            if (length(unique(bank$scale)) == 1) "scale" else "scales", nrow(bank)
          ))
        ),
        p(class = "small", downloadLink(ns("download_csv"), "\u2193 Download this questionnaire as csv"))
      )
    })

    output$download_csv <- downloadHandler(
      filename = function() {
        n <- loaded()$name
        if (is.null(n)) "questionnaire.csv" else n
      },
      content = function(file) file.copy(loaded()$path, file, overwrite = TRUE),
      contentType = "text/csv"
    )

    observeEvent(input$start, {
      bank <- loaded()$bank
      req(bank, length(input$scales_include) >= 1)
      # the scales in the order of the bank, whatever the order they were ticked in
      scales <- intersect(unique(bank$scale), input$scales_include)
      req(length(scales) >= 1)
      rv$s <- safely(cat_start(bank, scales, input$se_threshold), rv$s)
    })

    observeEvent(input$submit, {
      req(rv$s, rv$s$stage == "testing", input$response)
      rv$s <- safely(cat_answer(rv$s, as.integer(input$response)), rv$s)
    })

    output$threshold_note <- renderUI({
      req(input$se_threshold)
      p(
        class = "small text-body-secondary",
        sprintf("Reliability target about %.2f (1 - SE\u00b2).", 1 - input$se_threshold^2)
      )
    })

    output$status <- renderUI({
      s <- rv$s
      if (is.null(s)) {
        "Not started"
      } else if (s$stage == "testing") {
        tagList(
          strong(sprintf("Scale %d of %d: %s", s$idx, length(s$scales), s$scales[s$idx])),
          span(
            class = "text-body-secondary ms-2",
            sprintf(
              "%s \u00b7 item %d of %d \u00b7 \u03b8 = %.2f \u00b7 SE = %s",
              toupper(s$model), length(s$administered) + 1, nrow(s$scale_matrix),
              (s$theta - s$prior[1]) / s$prior[2],
              ifelse(is.na(s$se), "-", sprintf("%.3f", s$se / s$prior[2]))
            )
          )
        )
      } else {
        strong("The CAT is complete")
      }
    })

    output$question_ui <- renderUI({
      if (is.null(rv$s)) {
        return(p(
          class = "text-body-secondary",
          "Choose a questionnaire, the scales and the standard error in the settings, then press Start."
        ))
      }
      req(rv$s$stage == "testing")
      item <- cat_item(rv$s)
      options <- item$options
      if (is.null(options)) options <- as.character(seq_len(5))
      # when the text of the question is not public, the correct option is highlighted
      highlight <- !is.na(item$key) && !isTRUE(item$public)
      marker <- function(..., .noWS = NULL) {
        tags$mark(style = "background-color: #ffd43b; color: #212529; padding: 0 .3em; border-radius: .25em;", ..., .noWS = .noWS)
      }
      labels <- lapply(seq_along(options), function(k) {
        if (highlight && k == item$key) marker(title = "The correct answer", options[k]) else options[k]
      })
      nrm_note <- if (item$model == "nrm") " The nominal model scores every option on its own, not right or wrong."
      tagList(
        if (!is.na(item$stem) && nzchar(item$stem)) p(class = "text-body-secondary mb-1", item$stem),
        p(class = "fs-4 fw-semibold", item$question),
        radioButtons(ns("response"),
          label = NULL,
          choiceNames = labels,
          choiceValues = as.list(as.character(seq_along(options))),
          selected = character(0)
        ),
        if (highlight) {
          p(
            class = "small text-body-secondary",
            marker("Highlighted", .noWS = "after"), ": the correct answer, shown because the text of the question is not public.",
            nrm_note
          )
        } else if (!is.na(item$key)) {
          p(class = "small text-body-secondary", "Correct answer: ", strong(options[item$key]), ".", nrm_note)
        }
      )
    })

    output$submit_ui <- renderUI({
      req(rv$s, rv$s$stage == "testing")
      actionButton(ns("submit"), "Submit answer \u2192", class = "btn-primary align-self-start")
    })

    output$summary_ui <- renderUI({
      req(rv$s, rv$s$stage == "done")
      p <- rv$s$progress
      tagList(
        p(sprintf(
          "Completed %d %s with %d of %d items (%d%% fewer).",
          nrow(p), if (nrow(p) == 1) "scale" else "scales", sum(p$answered), sum(p$total),
          round(100 * (1 - sum(p$answered) / sum(p$total)))
        )),
        p(class = "text-body-secondary", "The progress table has the final \u03b8 and SE of each scale.")
      )
    })

    output$progress_table <- renderTable(
      {
        req(rv$s)
        df <- rv$s$progress
        out <- data.frame(
          dimension = df$scale,
          answered_total = sprintf("%d/%d", df$answered, df$total),
          theta = ifelse(is.na(df$theta), "-", sprintf("%.2f", df$theta)),
          se = ifelse(is.na(df$se), "-", sprintf("%.3f", df$se)),
          # short words, so that the table fits its half-width card
          status = unname(c(completed = "done", "in progress" = "now", pending = "waiting")[df$status]),
          stringsAsFactors = FALSE
        )
        colnames(out) <- c("Scale", "Answered", "\u03b8", "SE", "Status")
        out
      },
      width = "100%", spacing = "s", hover = TRUE
    )

    output$overall_ui <- renderUI({
      req(rv$s)
      p <- rv$s$progress
      p(
        class = "small text-body-secondary mb-0",
        sprintf(
          "%d of %d items so far (%d%% fewer than giving them all).",
          sum(p$answered), sum(p$total), round(100 * (1 - sum(p$answered) / sum(p$total)))
        )
      )
    })

    output$traj_plot <- plotly::renderPlotly({
      req(rv$s, nrow(rv$s$log) > 0)
      plot_cat_trajectory(rv$s)
    })

    output$log_table <- renderTable(
      {
        req(rv$s, nrow(rv$s$log) > 0)
        tbl <- rv$s$log[order(-rv$s$log$step), ]
        tbl$theta <- sprintf("%.2f", tbl$theta)
        tbl$se <- sprintf("%.3f", tbl$se)
        colnames(tbl) <- c("Step", "Scale", "Item", "Answer", "Score", "\u03b8", "SE")
        tbl
      },
      width = "100%", spacing = "s", hover = TRUE
    )
  })
}
