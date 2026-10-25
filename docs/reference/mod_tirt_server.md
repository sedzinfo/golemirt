# TIRT module - server

Plots
[`prob_tirt()`](https://sedzinfo.github.io/golemirt/reference/prob_tirt.md),
[`prob_tirt_pair()`](https://sedzinfo.github.io/golemirt/reference/prob_tirt.md)
and
[`prob_tirt_intercept()`](https://sedzinfo.github.io/golemirt/reference/prob_tirt.md)
on the three sub-tabs, each from \\-\eta\\ to \\\eta\\ in steps of 0.1,
where \\\eta\\ is the range set on the sub-tab.

## Usage

``` r
mod_tirt_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_tirt_ui()`](https://sedzinfo.github.io/golemirt/reference/mod_tirt_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_tirt_server("tirt")
}
} # }
```
