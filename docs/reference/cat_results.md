# Results of a CAT session

The standardized ability of each scale, its standard error, and the
percentile: the share of the population of the calibration sample
expected below that ability, assuming a normal distribution (`pnorm` of
the standardized ability).

## Usage

``` r
cat_results(s)
```

## Arguments

- s:

  A CAT session.

## Value

A data frame, one row per scale: `scale`, `theta` and `se`
(standardized), `percentile` (0 to 100), `answered`, `total` and
`status`.

## See also

Other CAT session:
[`cat_answer()`](https://sedzinfo.github.io/golemirt/reference/cat_answer.md),
[`cat_item()`](https://sedzinfo.github.io/golemirt/reference/cat_item.md),
[`cat_start()`](https://sedzinfo.github.io/golemirt/reference/cat_start.md),
[`plot_cat_trajectory()`](https://sedzinfo.github.io/golemirt/reference/plot_cat_trajectory.md)

## Examples

``` r
q <- read_questionnaire(example_questionnaires()[3])
s <- cat_start(q, scales = c("Openness", "Neuroticism"))
while (s$stage == "testing") s <- cat_answer(s, 2)
cat_results(s)
#>         scale      theta        se percentile answered total    status
#> 1    Openness -1.5433321 0.4477210   6.137511        5    10 completed
#> 2 Neuroticism -0.5165523 0.4436883  30.273438        2    10 completed
```
