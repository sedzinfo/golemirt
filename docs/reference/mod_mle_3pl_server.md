# MLE 3PL module - server

Simulates the responses of 50 people with abilities spread evenly from
-3 to 3 to an item with the true parameters, again whenever a true value
changes, and plots their log-likelihood for every discrimination and
difficulty from -3 to 3 in steps of 0.15, once for each assumed lower
asymptote 0.05, 0.10, ..., 0.60.

## Usage

``` r
mod_mle_3pl_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_mle_3pl_ui()`](https://sedzinfo.github.io/irtexplorer/reference/mod_mle_3pl_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_mle_3pl_server("mle_3pl")
}
} # }
```
