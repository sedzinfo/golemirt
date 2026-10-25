# Simulate dichotomous responses

Draws one response of each person to an item, correct with the
probability given by
[`prob_4pl()`](https://sedzinfo.github.io/golemirt/reference/prob_4pl.md)
(with \\D = 1\\ and \\d = 1\\).

## Usage

``` r
simulate_responses(theta, a = 1, b = 0, c = 0)
```

## Arguments

- theta:

  Numeric vector of the abilities of the people.

- a:

  Discrimination of the item.

- b:

  Difficulty (location) of the item.

- c:

  Lower asymptote of the item.

## Value

An integer vector of ones (correct) and zeros (incorrect), one for each
value of `theta`.

## Examples

``` r
set.seed(1)
simulate_responses(seq(-3, 3, length.out = 10), a = 1, b = -0.5)
#>  [1] 0 0 0 1 1 0 0 1 1 1
```
