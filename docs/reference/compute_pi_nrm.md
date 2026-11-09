# compute category response probabilities and derivatives under the nominal response model

returns the category response probabilities for a given ability value
and a\
given matrix of item parameters under Bock nominal response model (NRM)\
returns the first second and third derivatives of the category response\
probabilities

## Usage

``` r
compute_pi_nrm(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  item parameters one row per item\
  the columns come in pairs alpha_jk and c_jk for the categories 1 to m\
  so the columns are alpha1 c1 alpha2 c2 up to alpha_m c_m\
  alpha_jk is the slope and c_jk the intercept of category k\
  category 0 is the reference category with slope 0 and intercept 0 so
  it\
  has no columns\
  the categories do not need to be ordered which is what makes the
  model\
  nominal\
  an item with fewer categories than the widest item is padded with NA
  pairs\
  a mirt model fitted with itemtype="nominal" converts with\
  pars\<-mirt::coef(model,simplify=TRUE)\$items\
  m\<-length(grep("^ak",colnames(pars)))-1\
  alpha\<-pars\[,"a1"\]\*pars\[,paste("ak",1:m,sep="")\]\
  cj\<-pars\[,paste("d",1:m,sep="")\]\
  bank\<-cbind(alpha,cj)\[,order(rep(1:m,2))\]\
  colnames(bank)\<-paste(c("alpha","c"),rep(1:m,each=2),sep="")\
  mirt renumbers the observed categories of each item from 0 so the\
  responses must be coded the same way

- D:

  metric constant kept for the same interface as the other files\
  the nominal response model has no metric constant because any
  constant\
  multiplying the exponent is absorbed in the slopes and the intercepts
  so D\
  is not used and catR ignores it too

## Value

Pi category response probabilities one row per item one column per
category\
dPi first derivatives of the category response probabilities\
d2Pi second derivatives of the category response probabilities\
d3Pi third derivatives of the category response probabilities\
d4Pi fourth derivatives of the category response probabilities which
catR\
does not return and which the third derivative of the information needs

## Note

this function should return the same result as catR::Pi(model="NRM")\
the number of response categories is ncol(bank)/2+1 so 5 response
categories\
coded 0 1 2 3 4 need a bank with 8 columns\
the probability of category k is\
P(X=k\|theta)=exp(alpha_jk\*theta+c_jk)/sum over all categories\
with alpha_j0\*theta+c_j0 equal to zero\
log(P(X=k)/P(X=0))=alpha_jk\*theta+c_jk is a straight line so the most\
probable category at theta is the category with the highest line\
at very high theta that is the category with the largest slope and at
very low\
theta the category with the smallest slope\
when two categories share that slope their lines are parallel and the
one\
with the larger intercept wins\
as theta grows the categories take turns being the most probable in the
order\
of their slopes and not of their codes\
a category is skipped when the next category overtakes it before it
overtakes\
the previous one and this can happen with ordered slopes too\
with D=1 the partial credit model is the nominal model with alpha_jk=k
and\
c_jk=-(delta_j1+...+delta_jk) and the generalized partial credit model\
multiplies both by the item discrimination\
for a bank used with D=1.702 both are multiplied by D as well because
the\
nominal model ignores D\
in the code dj holds alpha_jk\*theta+c_jk and gamma holds exp(dj) for
each\
category while v holds the slope alpha_jk\
the exponent of category k grows by alpha_jk when theta grows by one so
the\
derivative of gamma is gamma\*v and is exact\
each further derivative multiplies by v again so gamma\*v^2 and
gamma\*v^3 give\
the second and third derivatives of Pi through the quotient rule

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
pi_cat<-catR::Pi(th=0,bank,model="NRM") # this will work with catR package installed
pi<-compute_pi_nrm(theta=0,bank)
pi_cat
#> $Pi
#>             cat0      cat1      cat2      cat3       cat4
#> Item1 0.06648350 0.2178820 0.4070572 0.2353218 0.07325553
#> Item2 0.11658155 0.2884700 0.3477873 0.1955060 0.05165521
#> Item3 0.04152992 0.1904547 0.3659198 0.2878427 0.11425288
#> Item4 0.10464180 0.1589426 0.4273242 0.2312601 0.07783125
#> Item5 0.13867515 0.2775869 0.3892159 0.1670234 0.02749857
#> 
#> $dPi
#>              cat0        cat1         cat2      cat3       cat4
#> Item1 -0.09380632 -0.17364578 -0.006501355 0.1635553 0.11039816
#> Item2 -0.15967681 -0.16952159  0.040810176 0.1996785 0.08870968
#> Item3 -0.05022984 -0.17378714 -0.038965175 0.1480992 0.11488292
#> Item4 -0.11789275 -0.01440521 -0.187437888 0.2047504 0.11498544
#> Item5 -0.14185996 -0.13933920  0.074353479 0.1419756 0.06487007
#> 
#> $d2Pi
#>             cat0        cat1       cat2        cat3       cat4
#> Item1 0.09573221  0.01835925 -0.2241445 -0.01596350 0.12601659
#> Item2 0.13949741 -0.09636499 -0.2314969  0.07111397 0.11725049
#> Item3 0.04350924  0.07950235 -0.1477790 -0.04331177 0.06807917
#> Item4 0.07343759 -0.08889417 -0.1602898  0.05003971 0.12570672
#> Item5 0.07536704 -0.06967723 -0.1815639  0.03667460 0.13919947
#> 
#> $d3Pi
#>               cat0        cat1         cat2       cat3        cat4
#> Item1 -0.033892584  0.16956944 -0.002562816 -0.1989930  0.06587899
#> Item2  0.012801319  0.25455269 -0.121705687 -0.2206637  0.07501539
#> Item3 -0.008286124  0.08381506  0.071241527 -0.1270552 -0.01971524
#> Item4  0.027458848 -0.01145833  0.186625566 -0.2402707  0.03764459
#> Item5  0.026398083  0.09665937 -0.219529905 -0.1588720  0.25534450
#> 
pi
#> $Pi
#>             cat0      cat1      cat2      cat3       cat4
#> Item1 0.06648350 0.2178820 0.4070572 0.2353218 0.07325553
#> Item2 0.11658155 0.2884700 0.3477873 0.1955060 0.05165521
#> Item3 0.04152992 0.1904547 0.3659198 0.2878427 0.11425288
#> Item4 0.10464180 0.1589426 0.4273242 0.2312601 0.07783125
#> Item5 0.13867515 0.2775869 0.3892159 0.1670234 0.02749857
#> 
#> $dPi
#>              cat0        cat1         cat2      cat3       cat4
#> Item1 -0.09380632 -0.17364578 -0.006501355 0.1635553 0.11039816
#> Item2 -0.15967681 -0.16952159  0.040810176 0.1996785 0.08870968
#> Item3 -0.05022984 -0.17378714 -0.038965175 0.1480992 0.11488292
#> Item4 -0.11789275 -0.01440521 -0.187437888 0.2047504 0.11498544
#> Item5 -0.14185996 -0.13933920  0.074353479 0.1419756 0.06487007
#> 
#> $d2Pi
#>             cat0        cat1       cat2        cat3       cat4
#> Item1 0.09573221  0.01835925 -0.2241445 -0.01596350 0.12601659
#> Item2 0.13949741 -0.09636499 -0.2314969  0.07111397 0.11725049
#> Item3 0.04350924  0.07950235 -0.1477790 -0.04331177 0.06807917
#> Item4 0.07343759 -0.08889417 -0.1602898  0.05003971 0.12570672
#> Item5 0.07536704 -0.06967723 -0.1815639  0.03667460 0.13919947
#> 
#> $d3Pi
#>               cat0        cat1         cat2       cat3        cat4
#> Item1 -0.033892584  0.16956944 -0.002562816 -0.1989930  0.06587899
#> Item2  0.012801319  0.25455269 -0.121705687 -0.2206637  0.07501539
#> Item3 -0.008286124  0.08381506  0.071241527 -0.1270552 -0.01971524
#> Item4  0.027458848 -0.01145833  0.186625566 -0.2402707  0.03764459
#> Item5  0.026398083  0.09665937 -0.219529905 -0.1588720  0.25534450
#> 
#> $d4Pi
#>              cat0        cat1       cat2        cat3        cat4
#> Item1 -0.09279934 -0.12093656 0.42253604 -0.09823979 -0.11056034
#> Item2 -0.21561247  0.18415967 0.54046104 -0.38330315 -0.12570509
#> Item3 -0.04709228 -0.17816151 0.22735926  0.06252010 -0.06462558
#> Item4 -0.04802192  0.20486694 0.43281201 -0.37434507 -0.21531195
#> Item5 -0.06891532  0.07769496 0.03279227 -0.36924907  0.32767716
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
