# Start an adaptive test

Starts a computerized adaptive test (CAT) over the chosen scales of an
item bank, one scale at a time, in the order given. Each scale is tested
with the engine of its IRT model (any of
[`irt_models`](https://sedzinfo.github.io/golemirt/reference/irt_models.md)):
each next item is the most informative one left at the current estimate
(maximum Fisher information); after each answer the ability is estimated
again by EAP, with the normal prior of the scale, over a grid of \\\pm
6\\ prior standard deviations. A scale stops when the standard error,
divided by the prior standard deviation, is at most `se_threshold`, or
when its items run out; the test then moves to the next scale.

## Usage

``` r
cat_start(bank, scales = unique(bank$scale), se_threshold = 0.45)
```

## Arguments

- bank:

  An item bank read with
  [`read_questionnaire`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md).

- scales:

  The scales to test, in order.

- se_threshold:

  Standardized standard error at which a scale stops.

## Value

A CAT session: a list to pass to
[`cat_answer`](https://sedzinfo.github.io/golemirt/reference/cat_answer.md),
[`cat_item`](https://sedzinfo.github.io/golemirt/reference/cat_item.md)
and
[`cat_results`](https://sedzinfo.github.io/golemirt/reference/cat_results.md).
Its `stage` is `"testing"` until the last scale stops, then `"done"`;
`progress` has one row per scale and `log` one row per answer.

## Details

Abilities and standard errors are reported standardized per scale
(divided by the prior standard deviation), so the same threshold is the
same target in every scale: a threshold `se` aims at a reliability of
about \\1 - se^2\\.

## See also

Other CAT session:
[`cat_answer()`](https://sedzinfo.github.io/golemirt/reference/cat_answer.md),
[`cat_item()`](https://sedzinfo.github.io/golemirt/reference/cat_item.md),
[`cat_results()`](https://sedzinfo.github.io/golemirt/reference/cat_results.md),
[`plot_cat_trajectory()`](https://sedzinfo.github.io/golemirt/reference/plot_cat_trajectory.md)

## Examples

``` r
q <- read_questionnaire(example_questionnaires()[3]) # IPIP-50, graded response model
s <- cat_start(q, scales = "Extraversion", se_threshold = 0.45)
while (s$stage == "testing") s <- cat_answer(s, 4) # always "Moderately accurate"
cat_results(s)
#>          scale     theta        se percentile answered total    status
#> 1 Extraversion 0.4534394 0.4414101   67.48838        2    10 completed
s$log
#>   step        scale                                        question answer score     theta        se
#> 1    1 Extraversion I talk to a lot of different people at parties.      4     3 0.5009819 0.5880331
#> 2    2 Extraversion                          I start conversations.      4     3 0.4534394 0.4414101
```
