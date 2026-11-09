# The item to show now

The item to show now

## Usage

``` r
cat_item(s)
```

## Arguments

- s:

  A CAT session.

## Value

A list with the `scale`, the `stem` (`NA` when the bank has none), the
`question`, the answer `options`, the `key` (the correct option of a
dichotomous item, or `NA`), whether its text is `public` and the `model`
of the current item, or `NULL` when the test is done.

## See also

Other CAT session:
[`cat_answer()`](https://sedzinfo.github.io/golemirt/reference/cat_answer.md),
[`cat_results()`](https://sedzinfo.github.io/golemirt/reference/cat_results.md),
[`cat_start()`](https://sedzinfo.github.io/golemirt/reference/cat_start.md),
[`plot_cat_trajectory()`](https://sedzinfo.github.io/golemirt/reference/plot_cat_trajectory.md)

## Examples

``` r
q <- read_questionnaire(example_questionnaires()[5]) # SAT12, 3PL
cat_item(cat_start(q))
#> $scale
#> [1] "Science (SAT12)"
#> 
#> $stem
#> [1] "The texts of the SAT12 questions are not public: choose one of the five options."
#> 
#> $question
#> [1] "SAT12 science question 2"
#> 
#> $options
#> [1] "Option A" "Option B" "Option C" "Option D" "Option E"
#> 
#> $key
#> [1] 4
#> 
#> $public
#> [1] FALSE
#> 
#> $model
#> [1] "dichotomous"
#> 
```
