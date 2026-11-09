# compute theta EAP estimation under the nominal response model

compute theta EAP estimation under the nominal response model

## Usage

``` r
compute_eap_nrm(
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

- bank:

  matrix of item parameters

- x:

  vector of item responses coded 0 to m

- D:

  metric constant kept for the same interface as the other files and not
  used

- priorPar:

  mean and sd for normal distribution default is mean 0 and sd 1

- lower:

  lower bound for numerical integration

- upper:

  upper bound for numerical integration

- nqp:

  number of quadrature points

## Note

this function should return the same result as
catR::eapEst(model="NRM")\
the sufficient statistic for theta is the sum of the slopes alpha_jk of
the\
categories chosen so two response patterns on the same items with the
same\
sum of slopes give the same EAP estimate

## Examples

``` r
bank<-matrix(c(0.614,0.782,0.297,1.036,0.521,
               1.187,0.906,1.523,0.418,0.694,
               1.395,1.487,1.103,0.688,1.214,
               1.812,1.093,2.176,1.407,1.032,
               2.106,2.391,1.724,2.012,1.873,
               1.264,0.517,1.936,0.793,0.186,
               2.918,3.087,2.215,2.604,3.382,
               0.097,-0.814,1.012,-0.296,-1.618),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("alpha1","c1","alpha2","c2","alpha3","c3","alpha4","c4")))
response<-c(4,3,2,1,0)
catR::eapEst(bank,response,model="NRM") # this will work with catR package installed
#> [1] 0.3310536
compute_eap_nrm(bank,response)
#> [1] 0.3310536
```
