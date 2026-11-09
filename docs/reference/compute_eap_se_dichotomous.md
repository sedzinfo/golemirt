# compute standard error of theta EAP estimation

compute standard error of theta EAP estimation

## Usage

``` r
compute_eap_se_dichotomous(
  theta,
  bank,
  x,
  D = 1,
  priorPar = c(0, 1),
  lower = -4,
  upper = 4,
  nqp = 33
)
```

## Arguments

- theta:

  theta estimation

- bank:

  matrix of item parameters

- x:

  vector of item responses

- D:

  metric constant can be 1 or 1.702

- priorPar:

  mean and sd for normal distribution default is mean 0 and sd 1

- lower:

  lower bound for numerical integration

- upper:

  upper bound for numerical integration

- nqp:

  number of quadrature points

## Note

this function should return the same result as the catR::eapSem function

## Examples

``` r
bank<-matrix(c(1.75,1.80,1.85,1.90,1.95,
              -3,-2,0,2,3,
               0.1,0.1,0.1,0.1,0.1,
               0.9,0.9,0.9,0.9,0.9),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("a","b","c","d")))
response<-c(0,0,0,0,0)
catR::eapSem(0,bank,response)
#> [1] 1.673209
compute_eap_se_dichotomous(theta=0,bank=bank,x=response)
#> [1] 1.673209
```
