# Prior weights at quadrature points

The density of a skew-normal prior
([`fGarch::dsnorm()`](https://geobosh.github.io/fGarchDoc/reference/dist-snorm.html),
which is the normal density when `skew = 1`) at the quadrature points,
rescaled to sum to 1.

## Usage

``` r
prior_weights(x, mean = 0, sd = 1, skew = 1)
```

## Arguments

- x:

  Quadrature points.

- mean, sd:

  Mean and standard deviation of the prior.

- skew:

  Skewness parameter of the prior, `xi` in
  [`fGarch::dsnorm()`](https://geobosh.github.io/fGarchDoc/reference/dist-snorm.html).

## Value

A numeric vector of weights, one for each value of `x`.

## Examples

``` r
prior_weights(seq(-4, 4, length.out = 10))
#>  [1] 0.0001189608 0.0028053608 0.0300211618 0.1457874064 0.3212671103 0.3212671103 0.1457874064 0.0300211618 0.0028053608 0.0001189608
```
