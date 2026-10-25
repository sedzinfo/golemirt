# MLE Rasch module - UI

Controls for the raw score, the starting value and the Newton-Raphson
iteration to show, notes on the response patterns and item difficulties
assumed, the log-likelihood plot and the numbers of the step.

## Usage

``` r
mod_mle_rasch_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_mle_rasch_ui("mle_rasch"))
} # }
```
