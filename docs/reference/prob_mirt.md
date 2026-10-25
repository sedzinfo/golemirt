# Response surface of a two-dimensional dichotomous item

The probability of a correct response to an item that measures two
abilities. In the compensatory model it is a logistic function of a
weighted sum of the abilities, \$\$P(\theta_1, \theta_2) = c + \frac{d -
c}{1 + \exp(-D (a_1 (\theta_1 - b_1) + a_2 (\theta_2 - b_2)))},\$\$ so
that a high ability on one dimension can make up for a low ability on
the other; in the non-compensatory model it is the product of one
logistic function for each ability, so that a low ability on either
dimension keeps the probability low.

## Usage

``` r
prob_mirt(
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

## Examples

``` r
theta <- seq(-4, 4, length.out = 5)
prob_mirt(theta, theta)
#>              [,1]         [,2]        [,3]       [,4]      [,5]
#> [1,] 1.220804e-06 3.672559e-05 0.001103681 0.03217069 0.5000000
#> [2,] 3.672559e-05 1.103681e-03 0.032170688 0.50000000 0.9678293
#> [3,] 1.103681e-03 3.217069e-02 0.500000000 0.96782931 0.9988963
#> [4,] 3.217069e-02 5.000000e-01 0.967829312 0.99889632 0.9999633
#> [5,] 5.000000e-01 9.678293e-01 0.998896319 0.99996327 0.9999988
prob_mirt(theta, theta, a = c(2, 0.5), compensatory = FALSE)
#>              [,1]         [,2]         [,3]         [,4]         [,5]
#> [1,] 3.927409e-08 1.882531e-07 6.104018e-07 1.032551e-06 1.181530e-06
#> [2,] 3.550618e-05 1.701923e-04 5.518405e-04 9.334887e-04 1.068175e-03
#> [3,] 1.608534e-02 7.710212e-02 2.500000e-01 4.228979e-01 4.839147e-01
#> [4,] 3.213518e-02 1.540340e-01 4.994482e-01 8.448623e-01 9.667611e-01
#> [5,] 3.217065e-02 1.542040e-01 4.999994e-01 8.457947e-01 9.678281e-01
```
