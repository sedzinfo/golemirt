# compute standard error of theta EAP estimation under the nominal response model

compute standard error of theta EAP estimation under the nominal
response model

## Usage

``` r
compute_eap_se_nrm(
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
catR::eapSem(model="NRM")\
pass the EAP estimate as theta to obtain the posterior standard
deviation\
any other value returns the posterior root mean squared deviation around
it\
so the curve is minimised at the EAP estimate

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
catR::eapSem(0,bank,response,model="NRM") # this will work with catR package installed
#> [1] 0.6111826
compute_eap_se_nrm(theta=0,bank=bank,x=response)
#> [1] 0.6111826
```
