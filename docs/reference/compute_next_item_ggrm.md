# select the next item by maximum Fisher information

select the next item by maximum Fisher information

## Usage

``` r
compute_next_item_ggrm(theta, bank, out = NULL, D = 1, randomesque = 1)
```

## Arguments

- theta:

  current ability estimate

- bank:

  matrix of item parameters

- out:

  vector of the indices of the items already administered

- D:

  metric constant can be 1 or 1.702

- randomesque:

  number of most informative items to draw at random from\
  1 is pure maximum information and 3 to 5 spreads item exposure

## Value

item index of the selected item in the bank\
info information of the selected item at theta\
available indices of the items still available

## Note

this function should return the same result as\
catR::nextItem(itemBank,model="MGRM",theta,out,criterion="MFI") when\
randomesque is 1 and the most informative item is unique\
when several items tie exactly catR draws one of them at random while
this\
function takes the first\
with randomesque above 1 catR also keeps every item tied with the last
one kept\
so it can draw from more than randomesque items\
when the items of a block have the same alpha_j their information curves
are\
copies of one another so the choice among them depends only on where
theta\
sits relative to each b_j\
with different alpha_j the curves differ in height as well so the
information\
of every available item has to be computed at theta

## Examples

``` r
bank<-matrix(c(1.227,0.845,1.694,1.012,2.103,
               -0.482,0.137,0.715,-0.936,0.298,
               rep(1.812,5),rep(0.603,5),rep(-0.452,5),rep(-1.963,5)),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("alphaj","bj","c1","c2","c3","c4")))
catR::nextItem(bank,model="MGRM",theta=0,criterion="MFI") # with catR installed
#> $item
#> [1] 5
#> 
#> $par
#> alphaj     bj     c1     c2     c3     c4 
#>  2.103  0.298  1.812  0.603 -0.452 -1.963 
#> 
#> $info
#> [1] 1.258847
#> 
#> $criterion
#> [1] "MFI"
#> 
#> $randomesque
#> [1] 1
#> 
#> $name
#> [1] "5"
#> 
#> $prior.prop
#> [1] NA
#> 
#> $post.prop
#> [1] NA
#> 
#> $cb.prop
#> [1] NA
#> 
compute_next_item_ggrm(theta=0,bank)
#> $item
#> [1] 5
#> 
#> $info
#> [1] 1.258847
#> 
#> $available
#> [1] 1 2 3 4 5
#> 
```
