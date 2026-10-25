# Category response curves of the graded response model

The probability of a response above each boundary between adjacent
categories is \\P^\*\_k(\theta) = 1 / (1 + \exp(-D a (\theta - b_k)))\\,
and the probability of each category is the difference between
successive boundary curves, with \\P^\*\_0 = 1\\ and \\P^\*\_{m+1} =
0\\. The difficulties must increase, or some probabilities would be
negative.

## Usage

``` r
prob_grm(theta, a = 1.5, b = c(-2, -0.75, 0.75, 2), D = 1)
```

## Arguments

- theta:

  Numeric vector of abilities.

- a:

  Discrimination.

- b:

  Increasing difficulties of the boundaries, \\b_1, \ldots, b_m\\.

- D:

  Scaling constant: 1 keeps the logistic metric, and 1.702 makes the
  curve almost coincide with the normal ogive.

## Value

A matrix with one row for each value of `theta` and one column for each
category, named `1` to `m + 1`.

## Examples

``` r
prob_grm(c(-2, 0, 2))
#>                1          2         3          4           5
#> [1,] 0.500000000 0.36703576 0.1170578 0.01343377 0.002472623
#> [2,] 0.047425873 0.19765914 0.5098300 0.19765914 0.047425873
#> [3,] 0.002472623 0.01343377 0.1170578 0.36703576 0.500000000
prob_grm(c(-2, 0, 2), a = 2, b = c(-1, 1))
#>                1         2           3
#> [1,] 0.880797078 0.1167303 0.002472623
#> [2,] 0.119202922 0.7615942 0.119202922
#> [3,] 0.002472623 0.1167303 0.880797078
```
