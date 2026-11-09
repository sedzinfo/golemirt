# compute category response probabilities and derivatives under the partial credit model

returns the category response probabilities for a given ability value
and a\
given matrix of item parameters under Masters partial credit model
(PCM)\
returns the first derivatives of the category response probabilities

## Usage

``` r
compute_pi_pcm(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  item parameters one row per item\
  columns 1 to m hold the step parameters delta_j1 to delta_jm\
  there is no discrimination column because the partial credit model is
  a\
  Rasch model\
  the steps are free for every item which is what separates this model
  from\
  the rating scale model where the steps of item j are lambda_j+delta_k
  so\
  all the items have the same spacing of steps and differ only by
  lambda_j\
  delta_jk is the value of theta where the curves of the categories k-1
  and\
  k cross\
  the steps do not need to be ordered\
  when delta_j2 is below delta_j1 category 1 is never the most probable\
  category but every probability stays positive which is not the case
  for\
  the graded response model\
  an item with fewer categories than the widest item is padded with NA\
  a mirt model fitted with itemtype="Rasch" gives the bank with the b1
  to bm\
  columns of mirt::coef(model,IRTpars=TRUE,simplify=TRUE)\$items to be
  used with D=1\
  mirt stores a dichotomous item in column b instead of b1 so it has to
  be\
  moved to the first column

- D:

  metric constant can be 1 or 1.702

## Value

Pi category response probabilities one row per item one column per
category\
dPi first derivatives of the category response probabilities exact when
D=1\
and divided by D as in catR otherwise

## Note

this function should return the same result as catR::Pi(model="PCM")\
the number of response categories is ncol(bank)+1 so a 5 point Likert
scale\
scored 0 1 2 3 4 needs a bank with 4 columns\
the probability of category k is\
P(X=k\|theta)=exp(sum_t=1^k D\*(theta-delta_jt))/sum over all
categories\
with the empty sum for category 0 equal to zero\
the rating scale model is the partial credit model with\
delta_jk=lambda_j+delta_k\
adding an item discrimination to the partial credit model gives the\
generalized partial credit model\
in the code gamma holds exp(sum_t=1^k D\*(theta-delta_jt)) for each
category and\
v holds the category score k\
the exponent of category k grows by D\*k when theta grows by one so the
exact\
derivative of gamma is gamma\*D\*v\
catR uses gamma\*v and so does this function to return the same result\
with D=1 the two are identical and with D=1.702 dPi is too small by a
factor\
of D and the information by a factor of D^2 which leaves the item
selection\
and the EAP estimates unchanged

## Examples

``` r
bank<-matrix(c(-1.853,-2.214,-0.936,-1.508,-0.412,
               -0.627,-0.504,-1.215,-0.183,0.338,
               0.418,0.692,0.284,0.735,1.102,
               1.636,1.927,1.405,2.118,2.285),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("deltaj1","deltaj2","deltaj3","deltaj4")))
pi_cat<-catR::Pi(th=0,bank,model="PCM")
pi<-compute_pi_pcm(theta=0,bank)
pi_cat
#> $Pi
#>             cat0      cat1      cat2       cat3        cat4
#> Item1 0.03482744 0.2221617 0.4158837 0.27380211 0.053325020
#> Item2 0.02942042 0.2692631 0.4457191 0.22311534 0.032482090
#> Item3 0.04950663 0.1262301 0.4254326 0.32025148 0.078579163
#> Item4 0.07216715 0.3260286 0.3914998 0.18772629 0.022578203
#> Item5 0.25120770 0.3792820 0.2705022 0.08986244 0.009145666
#> 
#> $dPi
#>              cat0        cat1        cat2      cat3       cat4
#> Item1 -0.07274183 -0.24185316 -0.03686208 0.2495335 0.10192355
#> Item2 -0.05766330 -0.25848599  0.01783963 0.2320454 0.06626426
#> Item3 -0.11149717 -0.15806111 -0.10727982 0.2394948 0.13734330
#> Item4 -0.12719604 -0.24860324  0.09297344 0.2323076 0.05051828
#> Item5 -0.30809528 -0.08589082  0.20924523 0.1593750 0.02536590
#> 
#> $d2Pi
#>             cat0        cat1        cat2         cat3       cat4
#> Item1 0.12265114  0.07651470 -0.34637338 -0.002774232 0.14998177
#> Item2 0.09129502  0.04932003 -0.32839893  0.076587515 0.11119636
#> Item3 0.20679002  0.08491297 -0.35381058 -0.107598671 0.16970627
#> Item4 0.16382930 -0.08310564 -0.30534737  0.130473099 0.09415061
#> Item5 0.14871672 -0.32652605 -0.08488854  0.200687003 0.06201087
#> 
#> $d3Pi
#>              cat0       cat1       cat2       cat3       cat4
#> Item1 -0.13300516 0.32883503  0.1029244 -0.4153596 0.11660529
#> Item2 -0.09575365 0.31631958 -0.0693835 -0.2779899 0.12680745
#> Item3 -0.25289041 0.21034204  0.3947549 -0.4238707 0.07166417
#> Item4 -0.08135061 0.45500481 -0.2570863 -0.2410514 0.12448348
#> Item5  0.29080952 0.09645058 -0.5431111  0.0333738 0.12247716
#> 
pi
#> $Pi
#>             cat0      cat1      cat2       cat3        cat4
#> Item1 0.03482744 0.2221617 0.4158837 0.27380211 0.053325020
#> Item2 0.02942042 0.2692631 0.4457191 0.22311534 0.032482090
#> Item3 0.04950663 0.1262301 0.4254326 0.32025148 0.078579163
#> Item4 0.07216715 0.3260286 0.3914998 0.18772629 0.022578203
#> Item5 0.25120770 0.3792820 0.2705022 0.08986244 0.009145666
#> 
#> $dPi
#>              cat0        cat1        cat2      cat3       cat4
#> Item1 -0.07274183 -0.24185316 -0.03686208 0.2495335 0.10192355
#> Item2 -0.05766330 -0.25848599  0.01783963 0.2320454 0.06626426
#> Item3 -0.11149717 -0.15806111 -0.10727982 0.2394948 0.13734330
#> Item4 -0.12719604 -0.24860324  0.09297344 0.2323076 0.05051828
#> Item5 -0.30809528 -0.08589082  0.20924523 0.1593750 0.02536590
#> 
#> $d2Pi
#>             cat0        cat1        cat2         cat3       cat4
#> Item1 0.12265114  0.07651470 -0.34637338 -0.002774232 0.14998177
#> Item2 0.09129502  0.04932003 -0.32839893  0.076587515 0.11119636
#> Item3 0.20679002  0.08491297 -0.35381058 -0.107598671 0.16970627
#> Item4 0.16382930 -0.08310564 -0.30534737  0.130473099 0.09415061
#> Item5 0.14871672 -0.32652605 -0.08488854  0.200687003 0.06201087
#> 
#> $d3Pi
#>              cat0       cat1       cat2       cat3       cat4
#> Item1 -0.13300516 0.32883503  0.1029244 -0.4153596 0.11660529
#> Item2 -0.09575365 0.31631958 -0.0693835 -0.2779899 0.12680745
#> Item3 -0.25289041 0.21034204  0.3947549 -0.4238707 0.07166417
#> Item4 -0.08135061 0.45500481 -0.2570863 -0.2410514 0.12448348
#> Item5  0.29080952 0.09645058 -0.5431111  0.0333738 0.12247716
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
