# Rasch-4PL module - server

Names the model that the parameters define (Rasch, 1PL or 2PL, 3PL or
4PL) and plots \\P(X = 1 \mid \theta)\\, with \\P(X = 0 \mid \theta)\\
when both probabilities are chosen, from -6 to 6 in steps of 0.1.

## Usage

``` r
mod_rasch_4pl_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_rasch_4pl_ui()`](https://sedzinfo.github.io/irtexplorer/reference/mod_rasch_4pl_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_rasch_4pl_server("rasch_4pl")
}
} # }
```
