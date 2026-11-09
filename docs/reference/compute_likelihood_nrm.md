# compute the likelihood of a polytomous response pattern

compute the likelihood of a polytomous response pattern

## Usage

``` r
compute_likelihood_nrm(theta, bank, x, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  matrix of item parameters

- x:

  vector of item responses coded 0 to m

- D:

  metric constant kept for the same interface as the other files and not
  used

## Note

this is the polytomous counterpart of prod(Pi^x\*(1-Pi)^(1-x)) used for
the 4PL\
model\
compute_pi_nrm returns a matrix so the response of item i selects the
column x\[i\]+1\
the +1 is index bookkeeping because categories start at 0 and R columns
start\
at 1\
the probabilities of the observed responses are multiplied across items
under\
the local independence assumption\
the codes 0 to m only label the categories and carry no order so the
response\
enters the likelihood only through the slope and intercept of its
category

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
compute_likelihood_nrm(theta=0,bank=bank,x=response)
#> [1] 0.0001155115
```
