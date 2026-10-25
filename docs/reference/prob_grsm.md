# Category response curves of the generalized rating scale model

A partial credit model whose step parameters are split into the
difficulty of the item and thresholds shared by the items of a response
scale: \\\delta_v = b + \tau_v\\ in
[`prob_gpcm()`](https://sedzinfo.github.io/golemirt/reference/prob_gpcm.md).
With \\a = 1\\ this is the rating scale model (Andrich, 1978), otherwise
the generalized rating scale model (Muraki, 1990).

## Usage

``` r
prob_grsm(theta, a = 1, b = 0, thresholds = c(-1, -0.4, 0.4, 1), D = 1)
```

## Arguments

- theta:

  Numeric vector of abilities.

- a:

  Discrimination.

- b:

  Difficulty (location).

- thresholds:

  Thresholds \\\tau_1, \ldots, \tau_m\\.

- D:

  Scaling constant: 1 keeps the logistic metric, and 1.702 makes the
  curve almost coincide with the normal ogive.

## Value

A matrix with one row for each value of `theta` and one column for each
category, named `1` to `m + 1`.

## References

Andrich, D. (1978). A rating formulation for ordered response
categories. *Psychometrika*, 43(4), 561-573.

Muraki, E. (1990). Fitting a polytomous item response model to
Likert-type data. *Applied Psychological Measurement*, 14(1), 59-71.

## Examples

``` r
prob_grsm(c(-2, 0, 2))
#>                1          2         3          4           5
#> [1,] 0.690023298 0.25384539 0.0512505 0.00464934 0.000231477
#> [2,] 0.087018845 0.23654175 0.3528788 0.23654175 0.087018845
#> [3,] 0.000231477 0.00464934 0.0512505 0.25384539 0.690023298
prob_grsm(c(-2, 0, 2), b = 1, thresholds = c(-0.5, 0.5))
#>               1          2           3
#> [1,] 0.92202971 0.07568481 0.002285483
#> [2,] 0.57409699 0.34820743 0.077695579
#> [3,] 0.07769558 0.34820743 0.574096993
```
