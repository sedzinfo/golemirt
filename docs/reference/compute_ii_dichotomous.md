# compute item information under the 4PL model

compute item information under the 4PL model

## Usage

``` r
compute_ii_dichotomous(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  item parameters

- D:

  metric constant can be 1 or 1.702

## Value

Ii item information for each item\
dIi first derivative of the item information for each item\
d2Ii second derivative of the item information for each item

## Note

this function should return the same result as the catR::Ii function\
the item information is the squared first derivative divided by the\
variance of the response\
I_j(theta)=dP_j^2/(P_j\*(1-P_j))\
this is the polytomous sum_k (dP_jk/dtheta)^2/P_jk with the two
categories\
P_j and 1-P_j\
for the 2PL with c=0 and d=1 it becomes D^2\*a^2\*P_j\*(1-P_j) which
peaks at\
theta=b with a height of D^2\*a^2/4\
a guessing parameter c above 0 or a slipping parameter d below 1 lowers
the\
information and with d=1 the peak moves above b to\
b+log((1+sqrt(1+8\*c))/2)/(D\*a)\
Pi returns 1e-10 and 1-1e-10 instead of 0 and 1 so the information
stays\
finite when a probability rounds to 0 or 1\
test information is the sum of the item informations\
dIi and d2Ii are the first and second derivatives of the item
information\
with respect to theta

## Examples

``` r
bank<-matrix(c(1.75,1.80,1.85,1.90,1.95,
              -3,-2,0,2,3,
               0.1,0.1,0.1,0.1,0.1,
               0.9,0.9,0.9,0.9,0.9),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("a","b","c","d")))
li_catr<-catR::Ii(th=0,bank)
li<-compute_ii_dichotomous(theta=0,bank)
data.frame(catr=li_catr[[1]],li=li[[1]],equal=li_catr[[1]]==li[[1]])
#>           catr           li equal
#> 1 0.0005663452 0.0005663452  TRUE
#> 2 0.0130419693 0.0130419693  TRUE
#> 3 0.5476000000 0.5476000000  TRUE
#> 4 0.0102057931 0.0102057931  TRUE
#> 5 0.0002172758 0.0002172758  TRUE
data.frame(catr=li_catr[[2]],li=li[[2]],equal=li_catr[[2]]==li[[2]])
#>            catr            li equal
#> 1 -0.0019265867 -0.0019265867  TRUE
#> 2 -0.0409977656 -0.0409977656  TRUE
#> 3  0.0000000000  0.0000000000  TRUE
#> 4  0.0346355167  0.0346355167  TRUE
#> 5  0.0008341025  0.0008341025  TRUE
data.frame(catr=li_catr[[3]],li=li[[3]],equal=li_catr[[3]]==li[[3]])
#>           catr           li equal
#> 1  0.006460126  0.006460126  TRUE
#> 2  0.119867898  0.119867898  TRUE
#> 3 -1.274429480 -1.274429480  TRUE
#> 4  0.110734946  0.110734946  TRUE
#> 5  0.003176704  0.003176704  TRUE
```
