# Log-likelihood of a response pattern under the Rasch model

Log-likelihood of a response pattern under the Rasch model

## Usage

``` r
loglik_rasch(theta, responses, b)
```

## Arguments

- theta:

  Numeric vector of abilities.

- responses:

  Ones and zeros, the responses to the items.

- b:

  Difficulties of the items.

## Value

A numeric vector of log-likelihoods, one for each value of `theta`.

## Examples

``` r
loglik_rasch(c(-1, 0, 1), response_pattern(2), b = c(-1.90, -0.60, -0.25, 0.30, 0.45))
#> [1] -2.092772 -2.450418 -3.848071
```
