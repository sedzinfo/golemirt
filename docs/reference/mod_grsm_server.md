# RSM-GRSM module - server

Plots the category response curves of
[`prob_grsm()`](https://sedzinfo.github.io/golemirt/reference/prob_grsm.md),
titled Rating Scale Model when the discrimination is 1 and Generalized
Rating Scale Model otherwise. A discrimination of 0 is rejected with a
message in place of the plot.

## Usage

``` r
mod_grsm_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_grsm_ui()`](https://sedzinfo.github.io/golemirt/reference/mod_grsm_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_grsm_server("grsm")
}
} # }
```
