# Category response curves of the nominal response model

The probabilities of the unordered categories of an item, with the first
category as the reference, whose exponent is 0, and each of the others
with its own discrimination and difficulty (the parameterization of
Baker, 1992): \$\$P(X = k \mid \theta) = \frac{\exp(z_k)}{\sum_h
\exp(z_h)}, \quad z_1 = 0, \quad z_k = D a_k (\theta - b_k).\$\$

## Usage

``` r
prob_nrm(theta, a = c(-4, -2, 2, 4), b = c(-4, -2, 2, 4), D = 1)
```

## Arguments

- theta:

  Numeric vector of abilities.

- a:

  Discriminations of the categories after the first.

- b:

  Difficulties of the categories after the first.

- D:

  Scaling constant: 1 keeps the logistic metric, and 1.702 makes the
  curve almost coincide with the normal ogive.

## Value

A matrix with one row for each value of `theta` and one column for each
category, named `a`, `b`, `c`, ...

## References

Baker, F. B. (1992). *Item Response Theory: Parameter Estimation
Techniques*. New York: Marcel Dekker.

## Examples

``` r
prob_nrm(c(-2, 0, 2))
#>              a            b            c            d            e
#> [1,] 0.4998323 1.676751e-04 0.4998323249 0.0001676751 1.886934e-11
#> [2,] 0.9646629 1.085585e-07 0.0176684182 0.0176684182 1.085585e-07
#> [3,] 0.4998323 1.886934e-11 0.0001676751 0.4998323249 1.676751e-04
```
