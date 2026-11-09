# CAT module - server

Runs an adaptive test on the questionnaire chosen
([`read_questionnaire`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md)),
with the session functions
([`cat_start`](https://sedzinfo.github.io/golemirt/reference/cat_start.md),
[`cat_answer`](https://sedzinfo.github.io/golemirt/reference/cat_answer.md)),
and draws its course with
[`plot_cat_trajectory`](https://sedzinfo.github.io/golemirt/reference/plot_cat_trajectory.md).

## Usage

``` r
mod_cat_server(id)
```

## Arguments

- id:

  Character. Module namespace id, the same as in
  [`mod_cat_ui`](https://sedzinfo.github.io/golemirt/reference/mod_cat_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
mod_cat_server("cat")
} # }
```
