# compute item information under the partial credit model

compute item information under the partial credit model

## Usage

``` r
compute_ii_pcm(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  matrix of item parameters

- D:

  metric constant can be 1 or 1.702

## Value

Ii item information for each item

## Note

this function should return the same result as catR::Ii(model="PCM")\
the polytomous item information is the sum over categories of the
squared\
first derivative divided by the probability\
I_j(theta)=sum_k (dP_jk/dtheta)^2/P_jk\
under the partial credit model this sum is the variance of the item
score at\
theta times D^2 and with the catR derivative the D^2 is left out\
there is no discrimination so for a given D the height and the shape of
the\
curve depend only on the number of steps and on their spacing and the
mean of\
the steps only moves the curve\
steps spread over a short range of theta or reversed give a taller
curve\
around their mean and steps spread over a long range give a lower and
wider\
curve that splits into one bump per step when the gaps are large\
the variance of a score from 0 to m is at most m^2/4 which caps the
height\
test information is the sum of the item informations

## Examples

``` r
bank<-matrix(c(-1.853,-2.214,-0.936,-1.508,-0.412,
               -0.627,-0.504,-1.215,-0.183,0.338,
               0.418,0.692,0.284,0.735,1.102,
               1.636,1.927,1.405,2.118,2.285),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("deltaj1","deltaj2","deltaj3","deltaj4")))
li_catr<-catR::Ii(th=0,bank,model="PCM")
li<-compute_ii_pcm(theta=0,bank)
li_catr
#> $Ii
#> [1] 0.8407174 0.7383865 0.8952369 0.8363394 0.9121881
#> 
#> $dIi
#> [1] -0.02462767  0.06707017 -0.26667915  0.07422137  0.35380136
#> 
#> $d2Ii
#> [1] -0.24497371 -0.14918727  0.01489645 -0.28438800 -0.39974150
#> 
li
#> $Ii
#> [1] 0.8407174 0.7383865 0.8952369 0.8363394 0.9121881
#> 
#> $dIi
#> [1] -0.02462767  0.06707017 -0.26667915  0.07422137  0.35380136
#> 
#> $d2Ii
#> [1] -0.24497371 -0.14918727  0.01489645 -0.28438800 -0.39974150
#> 
data.frame(catr=li_catr[[1]],li=li[[1]],equal=li_catr[[1]]==li[[1]])
#>        catr        li equal
#> 1 0.8407174 0.8407174  TRUE
#> 2 0.7383865 0.7383865  TRUE
#> 3 0.8952369 0.8952369  TRUE
#> 4 0.8363394 0.8363394  TRUE
#> 5 0.9121881 0.9121881  TRUE
data.frame(catr=li_catr[[2]],li=li[[2]],equal=li_catr[[2]]==li[[2]])
#>          catr          li equal
#> 1 -0.02462767 -0.02462767  TRUE
#> 2  0.06707017  0.06707017  TRUE
#> 3 -0.26667915 -0.26667915  TRUE
#> 4  0.07422137  0.07422137  TRUE
#> 5  0.35380136  0.35380136  TRUE
data.frame(catr=li_catr[[3]],li=li[[3]],equal=li_catr[[3]]==li[[3]])
#>          catr          li equal
#> 1 -0.24497371 -0.24497371  TRUE
#> 2 -0.14918727 -0.14918727  TRUE
#> 3  0.01489645  0.01489645  TRUE
#> 4 -0.28438800 -0.28438800  TRUE
#> 5 -0.39974150 -0.39974150  TRUE
```
