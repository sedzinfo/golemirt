# Item vector of a compensatory two-dimensional item

The arrow that represents a compensatory item in the ability plane. It
points in the direction in which the probability rises fastest, at the
angle \\\arccos(a_1 / A)\\ to the \\\theta_1\\ axis; its length is the
multidimensional discrimination \\A = \sqrt{a_1^2 + a_2^2}\\; and it
starts on the line where the probability is halfway between the
asymptotes, at the signed distance \\(a_1 b_1 + a_2 b_2) / A\\, the
multidimensional difficulty, from the origin.

## Usage

``` r
item_vector(a = c(1, 1), b = c(0, 0))
```

## Arguments

- a:

  Discriminations on the two dimensions.

- b:

  Locations on the two dimensions.

## Value

A list with `start` and `end`, the coordinates of the two ends of the
arrow, `discrimination`, the multidimensional discrimination \\A\\, and
`difficulty`, the multidimensional difficulty.

## Examples

``` r
item_vector(a = c(1, 1), b = c(0, 0))
#> $start
#> [1] 0 0
#> 
#> $end
#> [1] 1 1
#> 
#> $discrimination
#> [1] 1.414214
#> 
#> $difficulty
#> [1] 0
#> 
item_vector(a = c(2, 0.5), b = c(1, -1))
#> $start
#> [1] 0.7058824 0.1764706
#> 
#> $end
#> [1] 2.7058824 0.6764706
#> 
#> $discrimination
#> [1] 2.061553
#> 
#> $difficulty
#> [1] 0.7276069
#> 
```
