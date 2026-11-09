# compute theta EAP estimation under the rating scale model

compute theta EAP estimation under the rating scale model

## Usage

``` r
compute_eap_rsm(
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

this function should return the same result as catR::eapEst(model="RSM")

## Examples

``` r
bank<-matrix(c(-0.560,-0.230,1.559,0.071,0.129,
               rep(1.715,5),rep(0.461,5),rep(-1.265,5),rep(-0.687,5)),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("lambdaj","delta1","delta2","delta3","delta4")))
response<-c(4,3,2,1,0)
catR::eapEst(bank,response,model="RSM")
#> [1] 0.09165378
compute_eap_rsm(bank=bank,x=response)
#> [1] 0.09165378
```
