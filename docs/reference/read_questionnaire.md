# Read a questionnaire

Reads a questionnaire from a csv file, one row per item, for any of the
six IRT models of
[`irt_models`](https://sedzinfo.github.io/golemirt/reference/irt_models.md):
the items, their answer options and the coefficients of the item
response model fitted with `mirt`, in `mirt`'s own column names (see
[`questionnaire_from_mirt`](https://sedzinfo.github.io/golemirt/reference/questionnaire_from_mirt.md),
which writes such a table from a fitted model). The coefficients are
converted to the parameters of the engine of the model. It stops with a
message naming the row and the problem, so that a test does not start on
a broken file.

## Usage

``` r
read_questionnaire(file)
```

## Arguments

- file:

  Path to the csv file, saved as UTF-8; or a data frame with the same
  columns.

## Value

The item bank: a data frame with one row per item and the columns
`scale`, `item`, `question`, `stem`, `model`, `n_cat`, `n_options`,
`options` (a list), `key`, `reverse`, `public`, `prior_mean`, `prior_sd`
and `par1`, `par2`, ... (the engine parameters). It can be given to
[`cat_start`](https://sedzinfo.github.io/golemirt/reference/cat_start.md).

## Details

The columns are `scale`, `question` and `itemtype` (required); `item`
and `stem` (optional); `option1`, `option2`, ... (the answer options in
scoring order, numbered when absent); `key` (the correct option of a
dichotomous item given as several options); `reverse` (ordered
polytomous items scored in reverse); `public` (`FALSE` when the text of
the item is not public and only a placeholder is shown, so that the CAT
tab highlights the correct option); the coefficients (`a1`, `b1`...,
`c`, `d`, `d0`..., `ak0`..., `g`, `u`, as `mirt` names them); and
`prior_mean` and `prior_sd`, the mean and standard deviation of the
latent trait of each scale (0 and 1 when absent).

## See also

Other questionnaire:
[`example_questionnaires()`](https://sedzinfo.github.io/golemirt/reference/example_questionnaires.md),
[`irt_models()`](https://sedzinfo.github.io/golemirt/reference/irt_models.md),
[`questionnaire_from_mirt()`](https://sedzinfo.github.io/golemirt/reference/questionnaire_from_mirt.md),
[`validate_questionnaire_against_mirt()`](https://sedzinfo.github.io/golemirt/reference/validate_questionnaire_against_mirt.md),
[`write_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/write_questionnaire.md)

## Examples

``` r
q <- read_questionnaire(example_questionnaires()[5]) # SAT12, 3PL
table(q$scale, q$model)
#>                  
#>                   dichotomous
#>   Science (SAT12)          32
q$options[[1]]
#> [1] "Option A" "Option B" "Option C" "Option D" "Option E"
```
