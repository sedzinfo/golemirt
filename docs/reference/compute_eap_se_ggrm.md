# compute standard error of theta EAP estimation under the generalized graded response model

compute standard error of theta EAP estimation under the generalized
graded response model

## Usage

``` r
compute_eap_se_ggrm(
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

  vector of item responses scored 0 to m

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

this function should return the same result as
catR::eapSem(model="MGRM")\
pass the EAP estimate as theta to obtain the posterior standard
deviation\
any other value returns the posterior root mean squared deviation around
it\
so the curve is minimised at the EAP estimate

## Examples

``` r
bank<-matrix(c(1.227,0.845,1.694,1.012,2.103,
               -0.482,0.137,0.715,-0.936,0.298,
               rep(1.812,5),rep(0.603,5),rep(-0.452,5),rep(-1.963,5)),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("alphaj","bj","c1","c2","c3","c4")))
response<-c(4,3,2,1,0)
catR::eapSem(0,bank,response,model="MGRM")
#> [1] 0.6378481
compute_eap_se_ggrm(theta=0,bank=bank,x=response)
#> [1] 0.6378481
```
