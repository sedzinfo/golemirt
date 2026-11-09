# Check a questionnaire against its mirt model

Compares the category probabilities of the engine with those of the
fitted `mirt` model, item by item, for any of the six models, so that a
mapping mistake does not go unnoticed. Items are matched by the `item`
column.

## Usage

``` r
validate_questionnaire_against_mirt(
  bank_scale,
  fit,
  thetas = seq(-4, 4, 0.5),
  tol = 1e-06
)
```

## Arguments

- bank_scale:

  The rows of one scale of a questionnaire read with
  [`read_questionnaire`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md).

- fit:

  The `mirt` model fitted to that scale.

- thetas:

  Ability values at which the probabilities are compared.

- tol:

  Largest difference accepted.

## Value

The largest difference, invisibly; a warning when it is above `tol`.

## See also

Other questionnaire:
[`example_questionnaires()`](https://sedzinfo.github.io/golemirt/reference/example_questionnaires.md),
[`irt_models()`](https://sedzinfo.github.io/golemirt/reference/irt_models.md),
[`questionnaire_from_mirt()`](https://sedzinfo.github.io/golemirt/reference/questionnaire_from_mirt.md),
[`read_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md),
[`write_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/write_questionnaire.md)
