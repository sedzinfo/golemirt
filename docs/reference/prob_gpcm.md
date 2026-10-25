# Category response curves of the generalized partial credit model

The probabilities of the categories \\1, \ldots, m + 1\\ of an item with
\\m\\ step parameters, \$\$P(X = k \mid \theta) =
\frac{\exp\left(\sum\_{v=1}^{k-1} D a (\theta -
\delta_v)\right)}{\sum\_{h=1}^{m+1} \exp\left(\sum\_{v=1}^{h-1} D a
(\theta - \delta_v)\right)},\$\$ where an empty sum is 0. With \\a = 1\\
this is the partial credit model (Masters, 1982), otherwise the
generalized partial credit model (Muraki, 1992). The curves of
categories \\k\\ and \\k + 1\\ cross at \\\theta = \delta_k\\.

## Usage

``` r
prob_gpcm(theta, a = 1, steps = c(-2, -0.75, 0.75, 2), D = 1)
```

## Arguments

- theta:

  Numeric vector of abilities.

- a:

  Discrimination.

- steps:

  Step parameters \\\delta_1, \ldots, \delta_m\\.

- D:

  Scaling constant: 1 keeps the logistic metric, and 1.702 makes the
  curve almost coincide with the normal ogive.

## Value

A matrix with one row for each value of `theta` and one column for each
category, named `1` to `m + 1`.

## References

Masters, G. N. (1982). A Rasch model for partial credit scoring.
*Psychometrika*, 47(2), 149-174.

Muraki, E. (1992). A generalized partial credit model: Application of an
EM algorithm. *Applied Psychological Measurement*, 16(2), 159-176.

## Examples

``` r
prob_gpcm(c(-2, 0, 2))
#>                 1          2         3          4            5
#> [1,] 0.4338101387 0.43381014 0.1242887 0.00794551 0.0001455271
#> [2,] 0.0308444494 0.22791137 0.4824884 0.22791137 0.0308444494
#> [3,] 0.0001455271 0.00794551 0.1242887 0.43381014 0.4338101387
prob_gpcm(c(-2, 0, 2), a = 1.5, steps = c(-1, 0, 1))
#>                 1           2           3            4
#> [1,] 8.101347e-01 0.180765495 0.008999784 9.997857e-05
#> [2,] 9.121276e-02 0.408787238 0.408787238 9.121276e-02
#> [3,] 9.997857e-05 0.008999784 0.180765495 8.101347e-01
```
