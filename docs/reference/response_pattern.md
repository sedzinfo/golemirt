# Response pattern of a raw score

The pattern in which the first `score` of `n` items are answered
correctly, as the Estimation tabs of the app assume: a raw score of 2 on
five items is the pattern 11000.

## Usage

``` r
response_pattern(score, n = 5)
```

## Arguments

- score:

  Raw score, from 0 to `n`.

- n:

  Number of items.

## Value

A numeric vector of `n` ones and zeros.

## Examples

``` r
response_pattern(2)
#> [1] 1 1 0 0 0
```
