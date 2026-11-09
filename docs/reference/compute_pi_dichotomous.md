# compute response probabilities and derivatives

returns the item response probabilities for a given ability value and a
given matrix of item parameters under the 4PL model\
returns the first and second derivatives of the response probabilities

## Usage

``` r
compute_pi_dichotomous(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  item parameters

- D:

  metric constant can be 1 or 1.702

## Value

Pi response probabilities for each item\
dPi first derivatives of the response probabilities for each item\
d2Pi second derivatives of the response probabilities for each item\
d3Pi third derivatives of the response probabilities for each item\

## Note

this function should return the same result as the catR::Pi function\
response probabilities exactly equal to zero are returned as 1e-10
values\
response probabilities exactly equal to one are returned as 1-1e-10
values\

## Examples

``` r
bank<-matrix(c(1.75,1.80,1.85,1.90,1.95,
              -3,-2,0,2,3,
               0.1,0.1,0.1,0.1,0.1,
               0.9,0.9,0.9,0.9,0.9),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("a","b","c","d")))
pi_cat<-catR::Pi(th=0,bank)
pi<-compute_pi_dichotomous(theta=0,bank)
data.frame(catr=pi_cat[[1]],pi=pi[[1]],equal=pi_cat[[1]]==pi[[1]])
#>        catr        pi equal
#> 1 0.8958239 0.8958239  TRUE
#> 2 0.8787224 0.8787224  TRUE
#> 3 0.5000000 0.5000000  TRUE
#> 4 0.1175050 0.1175050  TRUE
#> 5 0.1022973 0.1022973  TRUE
data.frame(catr=pi_cat[[2]],pi=pi[[2]],equal=pi_cat[[2]]==pi[[2]])
#>          catr          pi equal
#> 1 0.007270026 0.007270026  TRUE
#> 2 0.037281015 0.037281015  TRUE
#> 3 0.370000000 0.370000000  TRUE
#> 4 0.032531771 0.032531771  TRUE
#> 5 0.004466877 0.004466877  TRUE
data.frame(catr=pi_cat[[3]],pi=pi[[3]],equal=pi_cat[[3]]==pi[[3]])
#>           catr           pi equal
#> 1 -0.012589720 -0.012589720  TRUE
#> 2 -0.063536200 -0.063536200  TRUE
#> 3  0.000000000  0.000000000  TRUE
#> 4  0.059105386  0.059105386  TRUE
#> 5  0.008660385  0.008660385  TRUE
data.frame(catr=pi_cat[[4]],pi=pi[[4]],equal=pi_cat[[4]]==pi[[4]])
#>          catr          pi equal
#> 1  0.02157076  0.02157076  TRUE
#> 2  0.10202719  0.10202719  TRUE
#> 3 -0.63316250 -0.63316250  TRUE
#> 4  0.10235869  0.10235869  TRUE
#> 5  0.01669349  0.01669349  TRUE
```
