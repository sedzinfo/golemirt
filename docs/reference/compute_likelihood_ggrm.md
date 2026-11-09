# compute the likelihood of a polytomous response pattern

compute the likelihood of a polytomous response pattern

## Usage

``` r
compute_likelihood_ggrm(theta, bank, x, D = 1)
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
compute_pi_ggrm returns a matrix so the response of item i selects the
column x\[i\]+1\
the +1 is index bookkeeping because categories start at 0 and R columns
start\
at 1\
the probabilities of the observed responses are multiplied across items
under\
the local independence assumption

## Examples

``` r
bank<-matrix(c(1.227,0.845,1.694,1.012,2.103,
               -0.482,0.137,0.715,-0.936,0.298,
               rep(1.812,5),rep(0.603,5),rep(-0.452,5),rep(-1.963,5)),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("alphaj","bj","c1","c2","c3","c4")))
response<-c(4,3,2,1,0)
compute_likelihood_ggrm(theta=0,bank=bank,x=response)
#> [1] 4.961465e-05
```
