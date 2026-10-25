# EAP-MAP Rasch module - UI

Controls for the raw score, the number of quadrature points and the
mean, standard deviation and skewness of the prior, notes on the
response patterns and item difficulties assumed, and two sub-tabs: four
separate plots of the prior, trace lines, likelihood and posterior, and
one plot that combines them.

## Usage

``` r
mod_eap_map_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_eap_map_ui("eap_map"))
} # }
```
