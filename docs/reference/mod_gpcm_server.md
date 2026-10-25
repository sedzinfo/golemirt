# PCM-GPCM module - server

Plots the category response curves of
[`prob_gpcm()`](https://sedzinfo.github.io/irtexplorer/reference/prob_gpcm.md),
titled Partial Credit Model when the discrimination is 1 and Generalized
Partial Credit Model otherwise. A discrimination of 0 is rejected with a
message in place of the plot.

## Usage

``` r
mod_gpcm_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_gpcm_ui()`](https://sedzinfo.github.io/irtexplorer/reference/mod_gpcm_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_gpcm_server("gpcm")
}
} # }
```
