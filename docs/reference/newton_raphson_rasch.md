# Newton-Raphson steps towards the maximum likelihood estimate of ability

Computes the log-likelihood of a response pattern under the Rasch model
on a fine grid of abilities, fits a smoothing spline to it, and takes
Newton-Raphson steps \\\theta_1 = \theta_0 - LL'(\theta_0) /
LL''(\theta_0)\\ with the derivatives of the spline, as the MLE Rasch
tab of the app does. For a raw score of 0 or of all items the
log-likelihood has no maximum, and the steps move away.

## Usage

``` r
newton_raphson_rasch(
  responses,
  b = c(-1.9, -0.6, -0.25, 0.3, 0.45),
  start = 0,
  iterations = 1,
  theta = seq(-6, 6, by = 0.001)
)
```

## Arguments

- responses:

  Ones and zeros, the responses to the items.

- b:

  Difficulties of the items; the default is the five items of de Ayala
  (2009, p. 22).

- start:

  Starting value of the estimate.

- iterations:

  Number of steps.

- theta:

  Grid of abilities on which the log-likelihood is computed.

## Value

A list with `theta` and `loglik`, the grid and its log-likelihoods, and
`steps`, a data frame with one row per step: `start` and `end`, the
estimates the step starts from and ends at; `loglik_start` and
`loglik_end`, the log-likelihood there; `d1` and `d2`, the first and
second derivatives at the start; `intercept` and `crossing`, where the
tangent at the start crosses the vertical and horizontal axes; and
`angle`, the acute angle in degrees between the tangent and the
horizontal axis.

## References

de Ayala, R. J. (2009). *The Theory and Practice of Item Response
Theory*. New York: Guilford Press.

## Examples

``` r
nr <- newton_raphson_rasch(response_pattern(2), iterations = 5)
nr$steps[, c("start", "end")]
#>        start        end
#> 1  0.0000000 -0.8340437
#> 2 -0.8340437 -0.8378275
#> 3 -0.8378275 -0.8378288
#> 4 -0.8378288 -0.8378288
#> 5 -0.8378288 -0.8378288
```
