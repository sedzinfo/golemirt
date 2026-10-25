# Four-parameter logistic item response function

The probability of a correct (or keyed) response to a dichotomous item,
\$\$P(X = 1 \mid \theta) = c + \frac{d - c}{1 + \exp(-D a (\theta -
b))},\$\$ which is the Rasch model when \\a = 1\\, \\c = 0\\ and \\d =
1\\, the 2PL when \\c = 0\\ and \\d = 1\\, and the 3PL when \\d = 1\\.

## Usage

``` r
prob_4pl(theta, a = 1, b = 0, c = 0, d = 1, D = 1)
```

## Arguments

- theta:

  Numeric vector of abilities.

- a:

  Discrimination.

- b:

  Difficulty (location).

- c:

  Lower asymptote (guessing).

- d:

  Upper asymptote (inattentiveness).

- D:

  Scaling constant: 1 keeps the logistic metric, and 1.702 makes the
  curve almost coincide with the normal ogive.

## Value

A numeric vector of probabilities, one for each value of `theta`.

## Examples

``` r
prob_4pl(c(-2, 0, 2))
#> [1] 0.1192029 0.5000000 0.8807971
prob_4pl(c(-2, 0, 2), a = 1.5, b = 0.5, c = 0.2, D = 1.702)
#> [1] 0.2013504 0.3745173 0.9829930
```
