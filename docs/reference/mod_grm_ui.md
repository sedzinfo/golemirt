# GRM module - UI

Controls for the scaling constant, the discrimination and the four
difficulties of an item with five ordered categories, and its category
response curves. The ranges of the difficulty sliders do not overlap,
which keeps the difficulties in increasing order, as the model requires.

## Usage

``` r
mod_grm_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_grm_ui("grm"))
} # }
```
