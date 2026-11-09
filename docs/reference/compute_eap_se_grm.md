# compute standard error of theta EAP estimation under the graded response model

compute standard error of theta EAP estimation under the graded response
model

## Usage

``` r
compute_eap_se_grm(
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
catR::eapSem(model="GRM")\
pass the EAP estimate as theta to obtain the posterior standard
deviation\
any other value returns the posterior root mean squared deviation around
it\
so the curve is minimised at the EAP estimate

## Examples

``` r
bank<-matrix(c(1.227,0.845,1.694,1.012,2.103,
               -2.183,-1.542,-1.021,-2.460,-0.812,
               -0.874,-0.415,-0.231,-1.105,0.094,
               0.316,0.783,0.652,0.047,0.881,
               1.592,2.064,1.438,1.271,1.736),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("alphaj","betaj1","betaj2","betaj3","betaj4")))
response<-c(4,3,2,1,0)
catR::eapSem(0,bank,response,model="GRM")
#> [1] 0.5731984
compute_eap_se_grm(theta=0,bank=bank,x=response)
#> [1] 0.5731984
```
