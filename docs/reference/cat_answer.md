# Answer the current item

Scores the answer (category `answer - 1`, reversed on a reversed item;
on a dichotomous item with a key, 1 for the correct option and 0 for any
other), estimates the ability and its standard error again, and either
selects the next item of the scale or, when the scale stops, moves to
the next scale or ends the test.

## Usage

``` r
cat_answer(s, answer)
```

## Arguments

- s:

  A CAT session.

- answer:

  The option chosen, 1 to the number of options of the item, as shown to
  the person (before any reversal or scoring).

## Value

The updated session.

## See also

Other CAT session:
[`cat_item()`](https://sedzinfo.github.io/golemirt/reference/cat_item.md),
[`cat_results()`](https://sedzinfo.github.io/golemirt/reference/cat_results.md),
[`cat_start()`](https://sedzinfo.github.io/golemirt/reference/cat_start.md),
[`plot_cat_trajectory()`](https://sedzinfo.github.io/golemirt/reference/plot_cat_trajectory.md)

## Examples

``` r
q <- read_questionnaire(example_questionnaires()[3])
s <- cat_start(q, scales = "Openness")
s <- cat_answer(s, 5)
s$progress
#>      scale total answered     theta        se      status
#> 1 Openness    10        1 0.7971051 0.7477359 in progress
```
