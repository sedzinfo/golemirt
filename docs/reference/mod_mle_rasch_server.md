# MLE Rasch module - server

Takes the chosen number of Newton-Raphson steps with
[`newton_raphson_rasch()`](https://sedzinfo.github.io/golemirt/reference/newton_raphson_rasch.md)
and shows the last one, in a plot and as numbers.

## Usage

``` r
mod_mle_rasch_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_mle_rasch_ui()`](https://sedzinfo.github.io/golemirt/reference/mod_mle_rasch_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_mle_rasch_server("mle_rasch")
}
} # }
```
