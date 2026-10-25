# NRM module - server

Plots the category response curves of
[`prob_nrm()`](https://sedzinfo.github.io/golemirt/reference/prob_nrm.md),
labelled a to e, with a note on Baker's (1992) reparameterization under
the title.

## Usage

``` r
mod_nrm_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_nrm_ui()`](https://sedzinfo.github.io/golemirt/reference/mod_nrm_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_nrm_server("nrm")
}
} # }
```
