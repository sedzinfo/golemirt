# CAT module - UI

The adaptive test with its workings in view. A sidebar holds the
settings: the questionnaire (one of the examples, one for each IRT
model, or a csv of your own, see
[`read_questionnaire`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md)),
the scales and the standard error at which each one stops. The main area
has, side by side, the current item and a chart of the estimate and
standard error after every answer, then the progress of each scale and
the history of every answer given.

## Usage

``` r
mod_cat_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `bslib` sidebar layout.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_cat_ui("cat"))
} # }
```
