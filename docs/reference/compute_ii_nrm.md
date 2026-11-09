# compute item information under the nominal response model

compute item information under the nominal response model

## Usage

``` r
compute_ii_nrm(theta, bank, D = 1)
```

## Arguments

- theta:

  ability

- bank:

  matrix of item parameters

- D:

  metric constant kept for the same interface as the other files and not
  used

## Value

Ii item information for each item\
dIi first derivative of the item information for each item\
d2Ii second derivative of the item information for each item\
d3Ii third derivative of the item information for each item

## Note

this function should return the same result as catR::Ii(model="NRM")\
the polytomous item information is the sum over categories of the
squared\
first derivative divided by the probability\
I_j(theta)=sum_k (dP_jk/dtheta)^2/P_jk\
under the nominal response model this sum is the variance at theta of
the\
slope alpha_jk of the category chosen\
the information is therefore large where categories with very different\
slopes are both probable and it depends on the gaps between the slopes
rather\
than on their order\
test information is the sum of the item informations\
dIi and d2Ii are the first and second derivatives of the item
information\
with respect to theta obtained by differentiating each category term\
dP_jk^2/P_jk and summing over categories\
dIi=sum_k 2\*dP\*d2P/P-dP^3/P^2\
d2Ii=sum_k (2\*d2P^2+2\*dP\*d3P)/P-5\*dP^2\*d2P/P^2+2\*dP^4/P^3\
d3Ii=sum_k (6\*d2P\*d3P+2\*dP\*d4P)/P-(12\*dP\*d2P^2+7\*dP^2\*d3P)/P^2+\
18\*dP^3\*d2P/P^3-6\*dP^5/P^4\
catR stops at d2Ii so d3Ii has no catR counterpart

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
li_catr<-catR::Ii(th=0,bank,model="NRM") # this will work with catR package installed
li<-compute_ii_nrm(theta=0,bank)
li_catr
#> $Ii
#> [1] 0.5509014 0.6793970 0.4151954 0.5674988 0.5029803
#> 
#> $dIi
#> [1]  0.03268822  0.11239248 -0.06326216  0.22564642  0.28274374
#> 
#> $d2Ii
#> [1] -0.1263039 -0.2779506 -0.1592400 -0.2688705  0.3498580
#> 
li
#> $Ii
#> [1] 0.5509014 0.6793970 0.4151954 0.5674988 0.5029803
#> 
#> $dIi
#> [1]  0.03268822  0.11239248 -0.06326216  0.22564642  0.28274374
#> 
#> $d2Ii
#> [1] -0.1263039 -0.2779506 -0.1592400 -0.2688705  0.3498580
#> 
#> $d3Ii
#> [1] -0.01432536 -0.35685103  0.16250230 -0.80383781  0.49688954
#> 
data.frame(catr=li_catr[[1]],li=li[[1]],equal=li_catr[[1]]==li[[1]])
#>        catr        li equal
#> 1 0.5509014 0.5509014  TRUE
#> 2 0.6793970 0.6793970  TRUE
#> 3 0.4151954 0.4151954  TRUE
#> 4 0.5674988 0.5674988  TRUE
#> 5 0.5029803 0.5029803  TRUE
data.frame(catr=li_catr[[2]],li=li[[2]],equal=li_catr[[2]]==li[[2]])
#>          catr          li equal
#> 1  0.03268822  0.03268822  TRUE
#> 2  0.11239248  0.11239248  TRUE
#> 3 -0.06326216 -0.06326216  TRUE
#> 4  0.22564642  0.22564642  TRUE
#> 5  0.28274374  0.28274374  TRUE
data.frame(catr=li_catr[[3]],li=li[[3]],equal=li_catr[[3]]==li[[3]])
#>         catr         li equal
#> 1 -0.1263039 -0.1263039  TRUE
#> 2 -0.2779506 -0.2779506  TRUE
#> 3 -0.1592400 -0.1592400  TRUE
#> 4 -0.2688705 -0.2688705  TRUE
#> 5  0.3498580  0.3498580  TRUE
```
