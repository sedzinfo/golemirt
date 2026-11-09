# compute category response probabilities and derivatives under the generalized graded response model

returns the category response probabilities for a given ability value
and a\
given matrix of item parameters under Muraki modified graded response\
model which catR calls MGRM and mirt calls the graded rating scale
model\
and which this file calls the generalized graded response model\
it is a restricted graded response model whose thresholds are b_j-c_k\
and not an extension of it\
returns the first second and third derivatives of the category response\
probabilities

## Usage

``` r
compute_pi_ggrm(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  item parameters one row per item\
  column 1 holds the item discrimination alpha_j\
  column 2 holds the item location b_j\
  columns 3 to ncol(bank) hold the category parameters c_1 to c_m\
  the category parameters are common to the items of a block so those\
  columns are identical in every row of the block which is what
  separates\
  this model from the graded response model where every item has its
  own\
  thresholds\
  a bank with a single block has the same category parameters in every
  row\
  the category parameters must be strictly decreasing so that the item\
  thresholds b_j-c_k are strictly increasing\
  two equal category parameters leave a category with probability zero
  so a\
  response there makes the EAP NaN and an increasing pair makes a\
  probability negative\
  items that do not share a rating scale form separate blocks with their
  own\
  category parameters which is always the case for items with a
  different\
  number of categories and the shorter rows are padded with NA\
  a mirt model fitted with itemtype="grsm" converts with\
  pars\<-mirt::coef(model,simplify=TRUE)\$items\
  cbind(pars\[,"a1"\],-pars\[,"c"\],pars\[,grep("^b\[0-9\]",colnames(pars))\])\
  to be used with D=1 because mirt writes\
  Pstar_jk=P(X\>=k\|theta)=exp(a1\*(theta+c+b_k))/(1+exp(a1\*(theta+c+b_k)))

- D:

  metric constant can be 1 or 1.702

## Value

Pi category response probabilities one row per item one column per
category\
dPi first derivatives of the category response probabilities\
d2Pi second derivatives of the category response probabilities\
d3Pi third derivatives of the category response probabilities

## Note

this function should return the same result as catR::Pi(model="MGRM")\
the number of response categories is ncol(bank)-1 so a 5 point Likert
scale\
scored 0 1 2 3 4 needs a bank with 6 columns\
the model is the graded response model with the item thresholds split
into\
an item location and category parameters shared by the items of a block\
beta_jk=b_j-c_k\
Pstar_jk=P(X\>=k\|theta)=exp(D\*alpha_j\*(theta-(b_j-c_k)))/(1+exp(D\*alpha_j\*(theta-(b_j-c_k))))\
with Pstar_j0=1 and Pstar_j(m+1)=0\
P(X=k\|theta)=Pstar_jk-Pstar_j(k+1)\
the derivatives of a category are the differences of the derivatives of
two\
adjacent cumulative curves\
dPstar_jk=D\*alpha_j\*Pstar_jk\*(1-Pstar_jk)\
d2Pstar_jk=D\*alpha_j\*dPstar_jk\*(1-2\*Pstar_jk)\
d3Pstar_jk=D\*alpha_j\*(d2Pstar_jk-2\*dPstar_jk^2-2\*Pstar_jk\*d2Pstar_jk)\
and the boundary curves Pstar_j0=1 and Pstar_j(m+1)=0 have zero
derivatives\
it relates to the graded response model as the rating scale model
relates to\
the partial credit model and it keeps the item discrimination\
it stays a cumulative model while the rating scale model compares
adjacent\
categories and divides by a total\
when theta is far above the thresholds both cumulative curves are close
to 1\
and their difference loses precision so probabilities below about 1e-11
are\
inaccurate and below about 1e-16 they are rounding noise that is 0 or a\
multiple of 1.1e-16 and can even be slightly negative\
catR computes them the same way and only response patterns that
contradict\
theta strongly on very discriminating items are affected\
adding the same constant to the b_j and to the c_k of a block leaves
every\
probability unchanged so a constraint is needed\
Muraki centres the c_k of each block at zero while mirt sets b_j=0 for
the\
first item of each block and both give the same probabilities

## Examples

``` r
bank<-matrix(c(1.227,0.845,1.694,1.012,2.103,
               -0.482,0.137,0.715,-0.936,0.298,
               rep(1.812,5),rep(0.603,5),rep(-0.452,5),rep(-1.963,5)),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("alphaj","bj","c1","c2","c3","c4")))
pi_cat<-catR::Pi(th=0,bank,model="MGRM")
pi<-compute_pi_ggrm(theta=0,bank)
pi_cat
#> $Pi
#>             cat0      cat1      cat2      cat3       cat4
#> Item1 0.05653294 0.1524123 0.2818533 0.3694297 0.13977175
#> Item2 0.19538766 0.2074224 0.2191098 0.2330966 0.14498360
#> Item3 0.13489922 0.4123910 0.3310599 0.1110529 0.01059699
#> Item4 0.05836090 0.1156494 0.2059285 0.3587808 0.26128045
#> Item5 0.03977451 0.3051522 0.4838880 0.1626492 0.00853606
#> 
#> $dPi
#>              cat0        cat1        cat2      cat3       cat4
#> Item1 -0.06544446 -0.13736285 -0.10383881 0.1591170 0.14752909
#> Item2 -0.13284357 -0.07042466  0.00457869 0.0939405 0.10474904
#> Item3 -0.19769221 -0.22201939  0.23870566 0.1632449 0.01776107
#> Item4 -0.05561436 -0.08984111 -0.09295687 0.0430832 0.19532913
#> Item5 -0.08031882 -0.39485884  0.17680214 0.2805774 0.01779810
#> 
#> $d2Pi
#>             cat0        cat1        cat2        cat3       cat4
#> Item1 0.07122112  0.07363367 -0.13793060 -0.13733992 0.13041574
#> Item2 0.06838719 -0.03500018 -0.07432590 -0.02190819 0.06284709
#> Item3 0.24453764 -0.31178353 -0.16477659  0.20257291 0.02944958
#> Item4 0.04971243  0.04625955 -0.03803686 -0.15231198 0.09437686
#> Item5 0.15547381  0.15445517 -0.72258071  0.37586133 0.03679041
#> 
#> $d3Pi
#>               cat0       cat1         cat2        cat3        cat4
#> Item1 -0.066997251 0.06446994  0.233125093 -0.29247441  0.06187662
#> Item2 -0.005381242 0.06972477 -0.006061732 -0.07744536  0.01916356
#> Item3 -0.170073101 0.75612172 -0.772465123  0.13865500  0.04776151
#> Item4 -0.038176678 0.01767642  0.121466854 -0.06934388 -0.03162271
#> Item5 -0.273818584 1.02135985 -0.943784837  0.12152657  0.07471701
#> 
pi
#> $Pi
#>             cat0      cat1      cat2      cat3       cat4
#> Item1 0.05653294 0.1524123 0.2818533 0.3694297 0.13977175
#> Item2 0.19538766 0.2074224 0.2191098 0.2330966 0.14498360
#> Item3 0.13489922 0.4123910 0.3310599 0.1110529 0.01059699
#> Item4 0.05836090 0.1156494 0.2059285 0.3587808 0.26128045
#> Item5 0.03977451 0.3051522 0.4838880 0.1626492 0.00853606
#> 
#> $dPi
#>              cat0        cat1        cat2      cat3       cat4
#> Item1 -0.06544446 -0.13736285 -0.10383881 0.1591170 0.14752909
#> Item2 -0.13284357 -0.07042466  0.00457869 0.0939405 0.10474904
#> Item3 -0.19769221 -0.22201939  0.23870566 0.1632449 0.01776107
#> Item4 -0.05561436 -0.08984111 -0.09295687 0.0430832 0.19532913
#> Item5 -0.08031882 -0.39485884  0.17680214 0.2805774 0.01779810
#> 
#> $d2Pi
#>             cat0        cat1        cat2        cat3       cat4
#> Item1 0.07122112  0.07363367 -0.13793060 -0.13733992 0.13041574
#> Item2 0.06838719 -0.03500018 -0.07432590 -0.02190819 0.06284709
#> Item3 0.24453764 -0.31178353 -0.16477659  0.20257291 0.02944958
#> Item4 0.04971243  0.04625955 -0.03803686 -0.15231198 0.09437686
#> Item5 0.15547381  0.15445517 -0.72258071  0.37586133 0.03679041
#> 
#> $d3Pi
#>               cat0       cat1         cat2        cat3        cat4
#> Item1 -0.066997251 0.06446994  0.233125093 -0.29247441  0.06187662
#> Item2 -0.005381242 0.06972477 -0.006061732 -0.07744536  0.01916356
#> Item3 -0.170073101 0.75612172 -0.772465123  0.13865500  0.04776151
#> Item4 -0.038176678 0.01767642  0.121466854 -0.06934388 -0.03162271
#> Item5 -0.273818584 1.02135985 -0.943784837  0.12152657  0.07471701
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
