# Save a questionnaire table

Writes a questionnaire table
([`questionnaire_from_mirt`](https://sedzinfo.github.io/golemirt/reference/questionnaire_from_mirt.md))
as a UTF-8 csv that
[`read_questionnaire`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md)
and the app read. When the scales have different models, the columns are
the union of theirs and empty where a model has none.

## Usage

``` r
write_questionnaire(x, file)
```

## Arguments

- x:

  A data frame, or a list of data frames (one per scale).

- file:

  Path of the csv file.

## Value

`file`, invisibly. It stops if the file would not read back.

## See also

Other questionnaire:
[`example_questionnaires()`](https://sedzinfo.github.io/golemirt/reference/example_questionnaires.md),
[`irt_models()`](https://sedzinfo.github.io/golemirt/reference/irt_models.md),
[`questionnaire_from_mirt()`](https://sedzinfo.github.io/golemirt/reference/questionnaire_from_mirt.md),
[`read_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md),
[`validate_questionnaire_against_mirt()`](https://sedzinfo.github.io/golemirt/reference/validate_questionnaire_against_mirt.md)
