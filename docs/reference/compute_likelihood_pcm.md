# compute the likelihood of a polytomous response pattern

compute the likelihood of a polytomous response pattern

## Usage

``` r
compute_likelihood_pcm(theta, bank, x, D = 1)
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
compute_pi_pcm returns a matrix so the response of item i selects the
column x\[i\]+1\
the +1 is index bookkeeping because categories start at 0 and R columns
start\
at 1\
the probabilities of the observed responses are multiplied across items
under\
the local independence assumption\
under the partial credit model the only part of the likelihood that
depends on\
both theta and the responses is exp(D\*theta\*sum(x))\
the denominators depend on theta but not on the responses so two
patterns with\
the same total score on the same items have likelihoods that differ by
a\
constant factor

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
compute_likelihood_pcm(theta=0,bank=bank,x=response)
#> [1] 0.0004145528
```
