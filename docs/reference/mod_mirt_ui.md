# MIRT Dichotomous module - UI

Controls for the item response function, the compensatory or
non-compensatory model, the locations and discriminations of a
dichotomous item on two dimensions, its asymptotes and optional names
for the dimensions; and three sub-tabs with its response surface, its
contour plot (with a slider for the number of contour levels) and its
information surface.

## Usage

``` r
mod_mirt_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_mirt_ui("mirt"))
} # }
```
