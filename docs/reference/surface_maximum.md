# Highest point of a log-likelihood surface

The maximum likelihood estimates of discrimination and difficulty on the
grid of a surface from
[`loglik_surface()`](https://sedzinfo.github.io/golemirt/reference/loglik_surface.md).

## Usage

``` r
surface_maximum(loglik, a = attr(loglik, "a"), b = attr(loglik, "b"))
```

## Arguments

- loglik:

  Matrix of log-likelihoods, one row for each value of `a` and one
  column for each value of `b`.

- a, b:

  The grids of discriminations and difficulties of the surface; by
  default those that
  [`loglik_surface()`](https://sedzinfo.github.io/golemirt/reference/loglik_surface.md)
  keeps with it.

## Value

A list with `a`, `b` and `loglik`, the discrimination, difficulty and
log-likelihood at the highest point; at a tie, the first in column
order.

## Examples

``` r
set.seed(1)
theta <- seq(-3, 3, length.out = 50)
surface <- loglik_surface(simulate_responses(theta, a = 1, b = -0.5), theta)
surface_maximum(surface)
#> $a
#> [1] 1.2
#> 
#> $b
#> [1] -1.3
#> 
#> $loglik
#> [1] -18.46392
#> 
```
