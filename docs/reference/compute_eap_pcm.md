# compute theta EAP estimation under the partial credit model

compute theta EAP estimation under the partial credit model

## Usage

``` r
compute_eap_pcm(
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
catR::eapEst(model="PCM")\
the total score sum(x) is a sufficient statistic so two response
patterns\
with the same total score on the same items give the same EAP estimate\
mirt estimates the variance of theta for a Rasch model so a bank taken
from\
mirt is used with priorPar=c(0,sqrt(pars\$cov)) where\
pars\<-mirt::coef(model,IRTpars=TRUE,simplify=TRUE)

## Examples

``` r
bank<-matrix(c(-1.853,-2.214,-0.936,-1.508,-0.412,
               -0.627,-0.504,-1.215,-0.183,0.338,
               0.418,0.692,0.284,0.735,1.102,
               1.636,1.927,1.405,2.118,2.285),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("deltaj1","deltaj2","deltaj3","deltaj4")))
response<-c(4,3,2,1,0)
catR::eapEst(bank,response,model="PCM")
#> [1] 0.1350411
compute_eap_pcm(bank,response)
#> [1] 0.1350411
```
