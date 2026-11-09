# compute the likelihood of a polytomous response pattern

compute the likelihood of a polytomous response pattern

## Usage

``` r
compute_likelihood_grm(theta, bank, x, D = 1)
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
compute_pi_grm returns a matrix so the response of item i selects the
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
               -2.183,-1.542,-1.021,-2.460,-0.812,
               -0.874,-0.415,-0.231,-1.105,0.094,
               0.316,0.783,0.652,0.047,0.881,
               1.592,2.064,1.438,1.271,1.736),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("alphaj","betaj1","betaj2","betaj3","betaj4")))
response<-c(4,3,2,1,0)
compute_likelihood_grm(theta=0,bank=bank,x=response)
#> [1] 0.0002154863
```
