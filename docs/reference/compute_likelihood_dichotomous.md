# compute the likelihood of a dichotomous response pattern

compute the likelihood of a dichotomous response pattern

## Usage

``` r
compute_likelihood_dichotomous(theta, bank, x, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  matrix of item parameters

- x:

  vector of item responses scored 0 or 1

- D:

  metric constant can be 1 or 1.702

## Note

L(theta)=prod(P^x\*(1-P)^(1-x))\
a correct response contributes P and a wrong response 1-P\
the probabilities of the observed responses are multiplied across items
under\
the local independence assumption\
eap_est and eap_se compute the same product inside their own L function\
catR does not export a standalone likelihood function this product is
the L\
function defined inside catR::eapEst so it is reproduced here with
catR::Pi

## Examples

``` r
bank<-matrix(c(1.75,1.80,1.85,1.90,1.95,
              -3,-2,0,2,3,
               0.1,0.1,0.1,0.1,0.1,
               0.9,0.9,0.9,0.9,0.9),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("a","b","c","d")))
response<-c(1,1,1,0,0)
P<-catR::Pi(th=0,bank)$Pi
prod(P^response*(1-P)^(1-response))
#> [1] 0.3118093
compute_likelihood_dichotomous(theta=0,bank=bank,x=response)
#> [1] 0.3118093
```
