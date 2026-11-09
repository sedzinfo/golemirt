# compute standard error of theta EAP estimation under the partial credit model

compute standard error of theta EAP estimation under the partial credit
model

## Usage

``` r
compute_eap_se_pcm(
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
catR::eapSem(model="PCM")\
pass the EAP estimate as theta to obtain the posterior standard
deviation\
any other value returns the posterior root mean squared deviation around
it\
so the curve is minimised at the EAP estimate

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
catR::eapSem(0,bank,response,model="PCM")
#> [1] 0.4617619
compute_eap_se_pcm(theta=0,bank=bank,x=response)
#> [1] 0.4617619
```
