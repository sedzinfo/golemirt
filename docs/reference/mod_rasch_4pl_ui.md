# Rasch-4PL module - UI

Controls for the scaling constant and the four parameters of a
dichotomous item, a choice of the probabilities to plot, a line naming
the model that the values define, and the item characteristic curve.

## Usage

``` r
mod_rasch_4pl_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_rasch_4pl_ui("rasch_4pl"))
} # }
```
