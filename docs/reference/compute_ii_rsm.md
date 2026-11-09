# compute item information under the rating scale model

compute item information under the rating scale model

## Usage

``` r
compute_ii_rsm(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  matrix of item parameters

- D:

  metric constant can be 1 or 1.702

## Value

Ii item information for each item\
dIi first derivative of the item information for each item\
d2Ii second derivative of the item information for each item

## Note

this function should return the same result as catR::Ii(model="RSM")\
the polytomous item information is the sum over categories of the
squared\
first derivative divided by the probability\
I_j(theta)=sum_k (dP_jk/dtheta)^2/P_jk\
for a dichotomous item the two categories are P and 1-P with
derivatives\
dP and -dP so the sum collapses to dP^2/P+dP^2/(1-P)=dP^2/(P\*(1-P))
which is\
the familiar 4PL formula so this is the same quantity not a different
one\
under the rating scale model every item shares the same delta thresholds
so\
every information curve has the same shape and the same maximum and
differs\
only by a shift of lambdaj\
test information is the sum of the item informations\
dIi and d2Ii are the first and second derivatives of the item
information\
with respect to theta obtained by differentiating each category term\
dP_jk^2/P_jk and summing over categories\
dIi=sum_k 2\*dP\*d2P/P-dP^3/P^2\
d2Ii=sum_k (2\*d2P^2+2\*dP\*d3P)/P-5\*dP^2\*d2P/P^2+2\*dP^4/P^3

## Examples

``` r
bank<-matrix(c(-0.560,-0.230,1.559,0.071,0.129,
               rep(1.715,5),rep(0.461,5),rep(-1.265,5),rep(-0.687,5)),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("lambdaj","delta1","delta2","delta3","delta4")))
li_catr<-catR::Ii(th=0,bank,model="RSM")
li<-compute_ii_rsm(theta=0,bank)
data.frame(catr=li_catr[[1]],li=li[[1]],equal=li_catr[[1]]==li[[1]])
#>        catr        li equal
#> 1 1.5020380 1.5020380  TRUE
#> 2 2.7204563 2.7204563  TRUE
#> 3 0.1074066 0.1074066  TRUE
#> 4 3.0614345 3.0614345  TRUE
#> 5 2.9586254 2.9586254  TRUE
data.frame(catr=li_catr[[2]],li=li[[2]],equal=li_catr[[2]]==li[[2]])
#>         catr         li equal
#> 1 -3.4082073 -3.4082073  TRUE
#> 2 -3.1953574 -3.1953574  TRUE
#> 3  0.2460444  0.2460444  TRUE
#> 4  1.3208770  1.3208770  TRUE
#> 5  2.2026497  2.2026497  TRUE
data.frame(catr=li_catr[[3]],li=li[[3]],equal=li_catr[[3]]==li[[3]])
#>         catr         li equal
#> 1   4.883722   4.883722  TRUE
#> 2  -8.992374  -8.992374  TRUE
#> 3   0.685625   0.685625  TRUE
#> 4 -16.233457 -16.233457  TRUE
#> 5 -14.003333 -14.003333  TRUE
```
