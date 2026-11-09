# compute category response probabilities and derivatives under the rating scale model

returns the category response probabilities for a given ability value
and a\
given matrix of item parameters under Andrich rating scale model (RSM)\
returns the first second and third derivatives of the category response\
probabilities

## Usage

``` r
compute_pi_rsm(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  item parameters one row per item\
  column 1 holds the item location lambda_j\
  columns 2 to ncat hold the category thresholds delta_1 to delta_m\
  the thresholds are common to all items so those columns are identical\
  in every row which is what makes this the rating scale and not the\
  partial credit model\
  an item with fewer categories than the widest item is padded with NA

- D:

  metric constant can be 1 or 1.702

## Value

Pi category response probabilities one row per item one column per
category\
dPi first derivatives of the category response probabilities\
d2Pi second derivatives of the category response probabilities\
d3Pi third derivatives of the category response probabilities

## Note

this function should return the same result as catR::Pi(model="RSM")\
the number of response categories is ncol(bank) so a 5 point Likert
scale\
scored 0 1 2 3 4 needs a bank with 5 columns\
the probability of category k is\
P(X=k\|theta)=exp(sum_t=1^k D\*(theta-(lambda_j+delta_t)))/sum over all
categories\
with the empty sum for category 0 equal to zero

## Examples

``` r
bank<-matrix(c(-0.560,-0.230,1.559,0.071,0.129,
               rep(1.715,5),rep(0.461,5),rep(-1.265,5),rep(-0.687,5)),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("lambdaj","delta1","delta2","delta3","delta4")))
pi_cat<-catR::Pi(th=0,bank,model="RSM")
pi<-compute_pi_rsm(theta=0,bank)
pi_cat
#> $Pi
#>             cat0       cat1        cat2        cat3        cat4
#> Item1 0.08827106 0.02781046 0.030704594 0.190454305 0.662759579
#> Item2 0.23732018 0.05375358 0.042666335 0.190263548 0.475996359
#> Item3 0.95403130 0.03611457 0.004790796 0.003570467 0.001492864
#> Item4 0.45604320 0.07644622 0.044906724 0.148203679 0.274400176
#> Item5 0.50098691 0.07924783 0.043929232 0.136808204 0.239027827
#> 
#> $dPi
#>              cat0        cat1         cat2        cat3        cat4
#> Item1 -0.29232028 -0.06428725 -0.040272787 -0.05934954 0.456229854
#> Item2 -0.62032228 -0.08675087 -0.026191256  0.07346792 0.659796486
#> Item3 -0.05951154  0.03386178  0.009282746  0.01048868 0.005878333
#> Item4 -0.77913677 -0.05415996  0.013091594  0.19140929 0.628795848
#> Item5 -0.76833467 -0.04228998  0.020486740  0.20060978 0.589528143
#> 
#> $d2Pi
#>              cat0         cat1         cat2        cat3       cat4
#> Item1  0.83546747  0.106835369  0.006703162 -0.26757504 -0.6814310
#> Item2  0.97581785 -0.006230293 -0.099994076 -0.48923494 -0.3803585
#> Item3 -0.09875703  0.027870572  0.017471880  0.03042827  0.0229863
#> Item4 -0.06501348 -0.195664319 -0.133662419 -0.20650528  0.6008455
#> Item5 -0.30388211 -0.211896908 -0.120415991 -0.11059852  0.7467935
#> 
#> $d3Pi
#>             cat0        cat1        cat2        cat3       cat4
#> Item1 -1.5877531 0.040944720  0.21683813  0.91078024  0.4191900
#> Item2  1.5827886 0.653820644  0.34022112  0.01931545 -2.5961458
#> Item3 -0.2157898 0.009972285  0.03068108  0.08625513  0.0888813
#> Item4  4.2792490 0.369260881 -0.17844079 -1.63444030 -2.8356288
#> Item5  3.9089767 0.188762383 -0.27414282 -1.65057590 -2.1730204
#> 
pi
#> $Pi
#>             cat0       cat1        cat2        cat3        cat4
#> Item1 0.08827106 0.02781046 0.030704594 0.190454305 0.662759579
#> Item2 0.23732018 0.05375358 0.042666335 0.190263548 0.475996359
#> Item3 0.95403130 0.03611457 0.004790796 0.003570467 0.001492864
#> Item4 0.45604320 0.07644622 0.044906724 0.148203679 0.274400176
#> Item5 0.50098691 0.07924783 0.043929232 0.136808204 0.239027827
#> 
#> $dPi
#>              cat0        cat1         cat2        cat3        cat4
#> Item1 -0.29232028 -0.06428725 -0.040272787 -0.05934954 0.456229854
#> Item2 -0.62032228 -0.08675087 -0.026191256  0.07346792 0.659796486
#> Item3 -0.05951154  0.03386178  0.009282746  0.01048868 0.005878333
#> Item4 -0.77913677 -0.05415996  0.013091594  0.19140929 0.628795848
#> Item5 -0.76833467 -0.04228998  0.020486740  0.20060978 0.589528143
#> 
#> $d2Pi
#>              cat0         cat1         cat2        cat3       cat4
#> Item1  0.83546747  0.106835369  0.006703162 -0.26757504 -0.6814310
#> Item2  0.97581785 -0.006230293 -0.099994076 -0.48923494 -0.3803585
#> Item3 -0.09875703  0.027870572  0.017471880  0.03042827  0.0229863
#> Item4 -0.06501348 -0.195664319 -0.133662419 -0.20650528  0.6008455
#> Item5 -0.30388211 -0.211896908 -0.120415991 -0.11059852  0.7467935
#> 
#> $d3Pi
#>             cat0        cat1        cat2        cat3       cat4
#> Item1 -1.5877531 0.040944720  0.21683813  0.91078024  0.4191900
#> Item2  1.5827886 0.653820644  0.34022112  0.01931545 -2.5961458
#> Item3 -0.2157898 0.009972285  0.03068108  0.08625513  0.0888813
#> Item4  4.2792490 0.369260881 -0.17844079 -1.63444030 -2.8356288
#> Item5  3.9089767 0.188762383 -0.27414282 -1.65057590 -2.1730204
#> 
isTRUE(all.equal(pi_cat[[1]], pi[[1]]))
#> [1] TRUE
isTRUE(all.equal(pi_cat[[2]], pi[[2]]))
#> [1] TRUE
isTRUE(all.equal(pi_cat[[3]], pi[[3]]))
#> [1] TRUE
isTRUE(all.equal(pi_cat[[4]], pi[[4]]))
#> [1] TRUE
```
