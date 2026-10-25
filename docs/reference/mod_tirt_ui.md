# TIRT module - UI

Three sub-tabs, each named by the formula it plots: a single binary
outcome with the parameters of factor analysis, the choice of one item
over another in a pair, and the same comparison in intercept and slope
form. Each has sliders for its parameters and for the range of the trait
axis.

## Usage

``` r
mod_tirt_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_tirt_ui("tirt"))
} # }
```
