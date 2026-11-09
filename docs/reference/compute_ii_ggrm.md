# compute item information under the generalized graded response model

compute item information under the generalized graded response model

## Usage

``` r
compute_ii_ggrm(theta, bank, D = 1)
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

this function should return the same result as catR::Ii(model="MGRM")\
the polytomous item information is the sum over categories of the
squared\
first derivative divided by the probability\
I_j(theta)=sum_k (dP_jk/dtheta)^2/P_jk\
the items of a block share the same spacing of thresholds so two items
of a\
block with the same alpha_j have the same information curve shifted by
the\
difference of their b_j\
a larger alpha_j gives a taller curve that grows roughly with alpha_j^2
and is\
narrower around each threshold\
test information is the sum of the item informations\
dIi and d2Ii are the first and second derivatives of the item
information\
with respect to theta obtained by differentiating each category term\
dP_jk^2/P_jk and summing over categories\
dIi=sum_k 2\*dP\*d2P/P-dP^3/P^2\
d2Ii=sum_k (2\*d2P^2+2\*dP\*d3P)/P-5\*dP^2\*d2P/P^2+2\*dP^4/P^3

## Examples

``` r
bank<-matrix(c(1.227,0.845,1.694,1.012,2.103,
               -0.482,0.137,0.715,-0.936,0.298,
               rep(1.812,5),rep(0.603,5),rep(-0.452,5),rep(-1.963,5)),
             nrow=5,dimnames=list(c(1,2,3,4,5),
                                  c("alphaj","bj","c1","c2","c3","c4")))
li_catr<-catR::Ii(th=0,bank,model="MGRM")
li<-compute_ii_ggrm(theta=0,bank)
li_catr
#> $Ii
#> [1] 0.4620661 0.2278655 0.8510921 0.3159488 1.2588474
#> 
#> $dIi
#> [1] -0.0194951744  0.0004109951  0.0378161857 -0.0138745338 -0.0527449600
#> 
#> $d2Ii
#> [1] -0.017899929 -0.009943397 -0.088159546 -0.013383447 -0.030594294
#> 
li
#> $Ii
#> [1] 0.4620661 0.2278655 0.8510921 0.3159488 1.2588474
#> 
#> $dIi
#> [1] -0.0194951744  0.0004109951  0.0378161857 -0.0138745338 -0.0527449600
#> 
#> $d2Ii
#> [1] -0.017899929 -0.009943397 -0.088159546 -0.013383447 -0.030594294
#> 
data.frame(catr=li_catr[[1]],li=li[[1]],equal=li_catr[[1]]==li[[1]])
#>        catr        li equal
#> 1 0.4620661 0.4620661  TRUE
#> 2 0.2278655 0.2278655  TRUE
#> 3 0.8510921 0.8510921  TRUE
#> 4 0.3159488 0.3159488  TRUE
#> 5 1.2588474 1.2588474  TRUE
data.frame(catr=li_catr[[2]],li=li[[2]],equal=li_catr[[2]]==li[[2]])
#>            catr            li equal
#> 1 -0.0194951744 -0.0194951744  TRUE
#> 2  0.0004109951  0.0004109951  TRUE
#> 3  0.0378161857  0.0378161857  TRUE
#> 4 -0.0138745338 -0.0138745338  TRUE
#> 5 -0.0527449600 -0.0527449600  TRUE
data.frame(catr=li_catr[[3]],li=li[[3]],equal=li_catr[[3]]==li[[3]])
#>           catr           li equal
#> 1 -0.017899929 -0.017899929  TRUE
#> 2 -0.009943397 -0.009943397  TRUE
#> 3 -0.088159546 -0.088159546  TRUE
#> 4 -0.013383447 -0.013383447  TRUE
#> 5 -0.030594294 -0.030594294  TRUE
```
