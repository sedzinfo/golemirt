# EAP-MAP Rasch module - server

Estimates the ability of the chosen raw score with
[`eap_map()`](https://sedzinfo.github.io/golemirt/reference/eap_map.md)
and draws the five plots of
[`plot_prior()`](https://sedzinfo.github.io/golemirt/reference/plot_prior.md)
and its siblings.

## Usage

``` r
mod_eap_map_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_eap_map_ui()`](https://sedzinfo.github.io/golemirt/reference/mod_eap_map_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_eap_map_server("eap_map")
}
} # }
```
