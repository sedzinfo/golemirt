# compute the likelihood of a polytomous response pattern

compute the likelihood of a polytomous response pattern

## Usage

``` r
compute_likelihood_rsm(theta, bank, x, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  matrix of item parameters

- x:

  vector of item responses scored 0 to m

- D:

  metric constant can be 1 or 1.702

## Note

this is the polytomous counterpart of prod(Pi^x\*(1-Pi)^(1-x)) used for
the 4PL\
model\
compute_pi_rsm returns a matrix so the response of item i selects the
column x\[i\]+1\
the +1 is index bookkeeping because categories start at 0 and R columns
start\
at 1\
the responses are multiplied across items under the local independence
assumption

## Examples

``` r
bank<-matrix(c(-0.560,-0.230,1.559,0.071,0.129,
               rep(1.715,5),rep(0.461,5),rep(-1.265,5),rep(-0.687,5)),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("lambdaj","delta1","delta2","delta3","delta4")))
response<-c(4,3,2,1,0)
compute_likelihood_rsm(theta=0,bank=bank,x=response)
#> [1] 2.313671e-05
```
