# The IRT models

The six models a questionnaire can use, with the `mirt` itemtypes that
map to each one.

## Usage

``` r
irt_models()
```

## Value

A data frame: `model` (the engine), `label` and `itemtypes`.

## See also

Other questionnaire:
[`example_questionnaires()`](https://sedzinfo.github.io/golemirt/reference/example_questionnaires.md),
[`questionnaire_from_mirt()`](https://sedzinfo.github.io/golemirt/reference/questionnaire_from_mirt.md),
[`read_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md),
[`validate_questionnaire_against_mirt()`](https://sedzinfo.github.io/golemirt/reference/validate_questionnaire_against_mirt.md),
[`write_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/write_questionnaire.md)

## Examples

``` r
irt_models()
#>         model                                 label                           itemtypes
#> 1         rsm              Rating scale model (RSM)                                 rsm
#> 2         pcm            Partial credit model (PCM)               Rasch (3+ categories)
#> 3         grm           Graded response model (GRM)                              graded
#> 4        mgrm Modified graded response model (MGRM)                                grsm
#> 5 dichotomous              Dichotomous (1PL to 4PL) Rasch (2 categories), 2PL, 3PL, 4PL
#> 6         nrm          Nominal response model (NRM)                             nominal
```
