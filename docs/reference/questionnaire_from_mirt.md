# A questionnaire table from a mirt model

Turns a unidimensional model fitted with `mirt` into the rows of a
questionnaire csv (see
[`read_questionnaire`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md)):
the coefficients of each item (`coef(fit, simplify = TRUE)`), the mean
and standard deviation of the latent trait, and the text and answer
options of the items. Fit one model per scale, bind the tables of the
scales with [`rbind()`](https://rdrr.io/r/base/cbind.html) and save them
with
[`write_questionnaire`](https://sedzinfo.github.io/golemirt/reference/write_questionnaire.md).

## Usage

``` r
questionnaire_from_mirt(
  fit,
  scale,
  question = NULL,
  options = NULL,
  key = NULL,
  reverse = FALSE,
  stem = NA,
  public = TRUE
)
```

## Arguments

- fit:

  A unidimensional model fitted with
  [`mirt::mirt()`](https://philchalmers.github.io/mirt/reference/mirt.html),
  with itemtype `rsm`, `Rasch`, `graded`, `grsm`, `2PL`, `3PL`, `4PL` or
  `nominal`.

- scale:

  The name of the scale.

- question:

  The text of the items, in the order of the model; the item names when
  `NULL`.

- options:

  The answer options: one character vector for all the items, or a list
  with one vector per item, in scoring order (the lowest category
  first). Numbered when `NULL`.

- key:

  For dichotomous items given as several options: the number of the
  correct option of each item.

- reverse:

  `TRUE` for items whose answers were reversed before the fit.

- stem:

  An instruction shown above the items.

- public:

  `FALSE` when the texts of the items are not public and `question` is
  only a placeholder: the CAT tab then highlights the correct option of
  keyed items.

## Value

A data frame, one row per item.

## See also

Other questionnaire:
[`example_questionnaires()`](https://sedzinfo.github.io/golemirt/reference/example_questionnaires.md),
[`irt_models()`](https://sedzinfo.github.io/golemirt/reference/irt_models.md),
[`read_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md),
[`validate_questionnaire_against_mirt()`](https://sedzinfo.github.io/golemirt/reference/validate_questionnaire_against_mirt.md),
[`write_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/write_questionnaire.md)

## Examples

``` r
if (FALSE) { # \dontrun{
fit <- mirt::mirt(responses, 1, itemtype = "graded")
q <- questionnaire_from_mirt(fit, "Anxiety",
  question = c("I worry a lot", "I feel tense"),
  options = c("Never", "Sometimes", "Often", "Always")
)
write_questionnaire(q, "anxiety.csv")
} # }
```
