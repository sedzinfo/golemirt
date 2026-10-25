# Log-likelihood surface of an item's discrimination and difficulty

The log-likelihood of the responses of people with known abilities to
one item, for every combination of discrimination and difficulty on a
grid, under the three-parameter logistic model with a known lower
asymptote (the two-parameter logistic model when `c = 0`) and \\D = 1\\.

## Usage

``` r
loglik_surface(
  responses,
  theta,
  a = seq(-3, 3, by = 0.1),
  b = seq(-3, 3, by = 0.1),
  c = 0
)
```

## Arguments

- responses:

  Ones and zeros, the responses of the people.

- theta:

  Abilities of the people.

- a:

  Grid of discriminations.

- b:

  Grid of difficulties.

- c:

  Lower asymptote assumed for the item.

## Value

A matrix with one row for each value of `a` and one column for each
value of `b`, which keeps the two grids as its attributes `a` and `b`.

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
