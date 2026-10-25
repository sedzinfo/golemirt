# Information surface of a two-dimensional dichotomous item

The item information at each point: the squared slope of the response
surface of
[`prob_mirt()`](https://sedzinfo.github.io/golemirt/reference/prob_mirt.md),
in the direction in which it rises fastest, divided by \\P (1 - P)\\,
\$\$I(\theta_1, \theta_2) = \frac{(\partial P / \partial \theta_1)^2 +
(\partial P / \partial \theta_2)^2}{P (1 - P)}.\$\$ For the compensatory
model this is the information of the four-parameter logistic model
(Magis, 2013) along the item vector, \\D^2 A^2 (P - c)^2 (d - P)^2 /
((d - c)^2 P (1 - P))\\, with \\A = \sqrt{a_1^2 + a_2^2}\\. Where \\P\\
is exactly 0 or 1, or \\c = d\\, the surface is flat and the information
is 0.

## Usage

``` r
info_mirt(
  theta1,
  theta2,
  a = c(1, 1),
  b = c(0, 0),
  c = 0,
  d = 1,
  D = 1.702,
  compensatory = TRUE
)
```

## Arguments

- theta1, theta2:

  Numeric vectors of abilities on the two dimensions.

- a:

  Discriminations on the two dimensions.

- b:

  Locations on the two dimensions.

- c:

  Lower asymptote.

- d:

  Upper asymptote.

- D:

  Scaling constant.

- compensatory:

  `TRUE` for the compensatory model, `FALSE` for the non-compensatory
  one.

## Value

A matrix with one row for each value of `theta1` and one column for each
value of `theta2`.

## References

Magis, D. (2013). A note on the item information function of the
four-parameter logistic model. *Applied Psychological Measurement*,
37(4), 304-315.

## Examples

``` r
theta <- seq(-4, 4, length.out = 5)
info_mirt(theta, theta)
#>              [,1]         [,2]        [,3]         [,4]         [,5]
#> [1,] 7.072849e-06 0.0002127659 0.006387238 0.1803882447 1.448402e+00
#> [2,] 2.127659e-04 0.0063872380 0.180388245 1.4484020000 1.803882e-01
#> [3,] 6.387238e-03 0.1803882447 1.448402000 0.1803882447 6.387238e-03
#> [4,] 1.803882e-01 1.4484020000 0.180388245 0.0063872380 2.127659e-04
#> [5,] 1.448402e+00 0.1803882447 0.006387238 0.0002127659 7.072849e-06
```
