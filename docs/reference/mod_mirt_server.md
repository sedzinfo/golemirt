# MIRT Dichotomous module - server

Computes the response surface of
[`prob_mirt()`](https://sedzinfo.github.io/golemirt/reference/prob_mirt.md)
and the information of
[`info_mirt()`](https://sedzinfo.github.io/golemirt/reference/info_mirt.md)
on a grid of 50 by 50 abilities from -4 to 4, and plots them as surfaces
and contours. The contour plot marks the line where the probability is
halfway between the asymptotes and, for the compensatory model, the
[`item_vector()`](https://sedzinfo.github.io/golemirt/reference/item_vector.md).
A discrimination of 0 is rejected with a message in place of the plots.

## Usage

``` r
mod_mirt_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_mirt_ui()`](https://sedzinfo.github.io/golemirt/reference/mod_mirt_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_mirt_server("mirt")
}
} # }
```
