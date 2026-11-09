# compute item information under the graded response model

compute item information under the graded response model

## Usage

``` r
compute_ii_grm(theta, bank, D = 1)
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

this function should return the same result as catR::Ii(model="GRM")\
the polytomous item information is the sum over categories of the
squared\
first derivative divided by the probability\
I_j(theta)=sum_k (dP_jk/dtheta)^2/P_jk\
an item with a single threshold is a 2PL item and the sum collapses to\
D^2\*alpha_j^2\*P_j1\*(1-P_j1)\
under the graded response model every item has its own discrimination
and\
thresholds so the information curves differ in height and in shape\
the height grows roughly with alpha_j^2 and exactly only for a single
threshold\
a larger alpha_j also narrows the curve around each threshold\
widely spaced thresholds spread the information over a wider range of
theta\
and when the spacing is large compared with 1/alpha_j the curve shows
one bump\
per threshold\
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
               -2.183,-1.542,-1.021,-2.460,-0.812,
               -0.874,-0.415,-0.231,-1.105,0.094,
               0.316,0.783,0.652,0.047,0.881,
               1.592,2.064,1.438,1.271,1.736),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("alphaj","betaj1","betaj2","betaj3","betaj4")))
li_catr<-catR::Ii(th=0,bank,model="GRM")
li<-compute_ii_grm(theta=0,bank)
li_catr
#> $Ii
#> [1] 0.4663808 0.2277769 0.8925518 0.3228605 1.3293141
#> 
#> $dIi
#> [1] -0.0021401801  0.0019001250 -0.0003551039 -0.0058203652  0.0687945104
#> 
#> $d2Ii
#> [1] -0.012150630 -0.009963063 -0.017799980 -0.016281093 -0.150138295
#> 
li
#> $Ii
#> [1] 0.4663808 0.2277769 0.8925518 0.3228605 1.3293141
#> 
#> $dIi
#> [1] -0.0021401801  0.0019001250 -0.0003551039 -0.0058203652  0.0687945104
#> 
#> $d2Ii
#> [1] -0.012150630 -0.009963063 -0.017799980 -0.016281093 -0.150138295
#> 
data.frame(catr=li_catr[[1]],li=li[[1]],equal=li_catr[[1]]==li[[1]])
#>        catr        li equal
#> 1 0.4663808 0.4663808  TRUE
#> 2 0.2277769 0.2277769  TRUE
#> 3 0.8925518 0.8925518  TRUE
#> 4 0.3228605 0.3228605  TRUE
#> 5 1.3293141 1.3293141  TRUE
data.frame(catr=li_catr[[2]],li=li[[2]],equal=li_catr[[2]]==li[[2]])
#>            catr            li equal
#> 1 -0.0021401801 -0.0021401801  TRUE
#> 2  0.0019001250  0.0019001250  TRUE
#> 3 -0.0003551039 -0.0003551039  TRUE
#> 4 -0.0058203652 -0.0058203652  TRUE
#> 5  0.0687945104  0.0687945104  TRUE
data.frame(catr=li_catr[[3]],li=li[[3]],equal=li_catr[[3]]==li[[3]])
#>           catr           li equal
#> 1 -0.012150630 -0.012150630  TRUE
#> 2 -0.009963063 -0.009963063  TRUE
#> 3 -0.017799980 -0.017799980  TRUE
#> 4 -0.016281093 -0.016281093  TRUE
#> 5 -0.150138295 -0.150138295  TRUE
```
