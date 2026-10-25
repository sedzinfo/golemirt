# GRM module - server

Plots the category response curves of
[`prob_grm()`](https://sedzinfo.github.io/golemirt/reference/prob_grm.md).

## Usage

``` r
mod_grm_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_grm_ui()`](https://sedzinfo.github.io/golemirt/reference/mod_grm_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_grm_server("grm")
}
} # }
```
