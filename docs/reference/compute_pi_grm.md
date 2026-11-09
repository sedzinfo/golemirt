# compute category response probabilities and derivatives under the graded response model

returns the category response probabilities for a given ability value
and a\
given matrix of item parameters under Samejima graded response model
(GRM)\
returns the first second and third derivatives of the category response\
probabilities

## Usage

``` r
compute_pi_grm(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  item parameters one row per item\
  column 1 holds the item discrimination alpha_j\
  columns 2 to ncat hold the item thresholds beta_j1 to beta_jm\
  both the discrimination and the thresholds are item specific\
  a graded model whose thresholds have the same spacing for every item
  so\
  that beta_jk=b_j-c_k with c_k common to the items is the\
  modified graded response model of cat_eap_ggrm.R\
  the thresholds of an item must be strictly increasing\
  two equal thresholds leave a category with probability zero so a
  response\
  there makes the EAP NaN and a decreasing pair makes a probability
  negative\
  an item with fewer categories than the widest item is padded with NA\
  a mirt model fitted with itemtype="graded" gives the bank with\
  mirt::coef(model,IRTpars=TRUE,simplify=TRUE)\$items to be used with
  D=1

- D:

  metric constant can be 1 or 1.702

## Value

Pi category response probabilities one row per item one column per
category\
dPi first derivatives of the category response probabilities\
d2Pi second derivatives of the category response probabilities\
d3Pi third derivatives of the category response probabilities

## Note

this function should return the same result as catR::Pi(model="GRM")\
the number of response categories is ncol(bank) so a 5 point Likert
scale\
scored 0 1 2 3 4 needs a bank with 5 columns\
the model works in two steps\
first the cumulative probability of responding in category k or above is
a 2PL\
curve with the item discrimination and the threshold beta_jk\
Pstar_jk=P(X\>=k\|theta)=exp(D\*alpha_j\*(theta-beta_jk))/(1+exp(D\*alpha_j\*(theta-beta_jk)))\
with Pstar_j0=1 and Pstar_j(m+1)=0\
then the probability of category k is the difference of two adjacent
curves\
P(X=k\|theta)=Pstar_jk-Pstar_j(k+1)\
this is a cumulative model while the rating scale and the partial credit
models\
compare adjacent categories and divide by a total\
the derivative of a 2PL curve is D\*alpha_j\*Pstar_jk\*(1-Pstar_jk) so
the\
derivative of a category is the same difference of two adjacent
derivatives\
differentiating again gives D\*alpha_j\*dPstar_jk\*(1-2\*Pstar_jk) for
the second\
derivative and
D\*alpha_j\*(d2Pstar_jk-2\*dPstar_jk^2-2\*Pstar_jk\*d2Pstar_jk) for\
the third and the boundary curves Pstar_j0=1 and Pstar_j(m+1)=0 have
zero\
derivatives of every order\
when theta is far above the thresholds both cumulative curves are close
to 1\
and their difference loses precision so probabilities below about 1e-11
are\
inaccurate and below about 1e-16 they are rounding noise that is 0 or a\
multiple of 1.1e-16 and can even be slightly negative\
catR computes them the same way and only response patterns that
contradict\
theta strongly on very discriminating items are affected

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
pi_cat<-catR::Pi(th=0,bank,model="GRM")
pi<-compute_pi_grm(theta=0,bank)
pi_cat
#> $Pi
#>             cat0      cat1      cat2      cat3       cat4
#> Item1 0.06425154 0.1906958 0.3407893 0.2800786 0.12418484
#> Item2 0.21366223 0.1995565 0.2464088 0.1915770 0.14879544
#> Item3 0.15064208 0.2527589 0.3476991 0.1684295 0.08047046
#> Item4 0.07659614 0.1697380 0.2655546 0.2716234 0.21648787
#> Item5 0.15347059 0.3957896 0.3151887 0.1102384 0.02531276
#> 
#> $dPi
#>              cat0        cat1        cat2       cat3       cat4
#> Item1 -0.07377126 -0.15929638 -0.06243629 0.16205178 0.13345215
#> Item2 -0.14196903 -0.06291729  0.01516773 0.08269481 0.10702378
#> Item3 -0.21674568 -0.19094699  0.09100149 0.19134371 0.12534747
#> Item4 -0.07157792 -0.11630357 -0.06497547 0.08120064 0.17165633
#> Item5 -0.27321622 -0.24743071  0.27422361 0.19453805 0.05188527
#> 
#> $d2Pi
#>             cat0        cat1        cat2        cat3       cat4
#> Item1 0.07888558  0.06127181 -0.20958239 -0.05365131 0.12307630
#> Item2 0.06870035 -0.03865166 -0.08122919 -0.01234194 0.06352243
#> Item3 0.25654552 -0.12311695 -0.40284633  0.09125312 0.17816464
#> Item4 0.06134009  0.03512196 -0.10254650 -0.09241684 0.09850130
#> Item5 0.39821338 -0.50608536 -0.26986339  0.27414464 0.10359073
#> 
#> $d3Pi
#>                cat0       cat1        cat2        cat3         cat4
#> Item1 -0.0709993057 0.12001693  0.14896143 -0.26778177  0.069802715
#> Item2  0.0008174538 0.06571910 -0.01951513 -0.06536684  0.018345422
#> Item3 -0.1444898067 0.66395237 -0.40886982 -0.31059771  0.200004965
#> Item4 -0.0421968211 0.06411741  0.10734076 -0.12614524 -0.003116113
#> Item5 -0.2664313613 1.38421554 -1.44139703  0.12811327  0.195499575
#> 
pi
#> $Pi
#>             cat0      cat1      cat2      cat3       cat4
#> Item1 0.06425154 0.1906958 0.3407893 0.2800786 0.12418484
#> Item2 0.21366223 0.1995565 0.2464088 0.1915770 0.14879544
#> Item3 0.15064208 0.2527589 0.3476991 0.1684295 0.08047046
#> Item4 0.07659614 0.1697380 0.2655546 0.2716234 0.21648787
#> Item5 0.15347059 0.3957896 0.3151887 0.1102384 0.02531276
#> 
#> $dPi
#>              cat0        cat1        cat2       cat3       cat4
#> Item1 -0.07377126 -0.15929638 -0.06243629 0.16205178 0.13345215
#> Item2 -0.14196903 -0.06291729  0.01516773 0.08269481 0.10702378
#> Item3 -0.21674568 -0.19094699  0.09100149 0.19134371 0.12534747
#> Item4 -0.07157792 -0.11630357 -0.06497547 0.08120064 0.17165633
#> Item5 -0.27321622 -0.24743071  0.27422361 0.19453805 0.05188527
#> 
#> $d2Pi
#>             cat0        cat1        cat2        cat3       cat4
#> Item1 0.07888558  0.06127181 -0.20958239 -0.05365131 0.12307630
#> Item2 0.06870035 -0.03865166 -0.08122919 -0.01234194 0.06352243
#> Item3 0.25654552 -0.12311695 -0.40284633  0.09125312 0.17816464
#> Item4 0.06134009  0.03512196 -0.10254650 -0.09241684 0.09850130
#> Item5 0.39821338 -0.50608536 -0.26986339  0.27414464 0.10359073
#> 
#> $d3Pi
#>                cat0       cat1        cat2        cat3         cat4
#> Item1 -0.0709993057 0.12001693  0.14896143 -0.26778177  0.069802715
#> Item2  0.0008174538 0.06571910 -0.01951513 -0.06536684  0.018345422
#> Item3 -0.1444898067 0.66395237 -0.40886982 -0.31059771  0.200004965
#> Item4 -0.0421968211 0.06411741  0.10734076 -0.12614524 -0.003116113
#> Item5 -0.2664313613 1.38421554 -1.44139703  0.12811327  0.195499575
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
