# select the next item by maximum Fisher information

select the next item by maximum Fisher information

## Usage

``` r
compute_next_item_grm(theta, bank, out = NULL, D = 1, randomesque = 1)
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
catR::nextItem(itemBank,model="GRM",theta,out,criterion="MFI") when\
randomesque is 1 and the most informative item is unique\
when several items tie exactly catR draws one of them at random while
this\
function takes the first\
with randomesque above 1 catR also keeps every item tied with the last
one kept\
so it can draw from more than randomesque items\
under the graded response model there is no nearest neighbour shortcut
because\
the information curves differ in height and shape so the information of
every\
available item has to be computed at theta\
an item with a large alpha_j whose thresholds cover the current theta
wins most\
of the comparisons and is used far more often than the rest of the bank
which\
is why randomesque matters more here than under the rating scale model

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
catR::nextItem(bank,model="GRM",theta=0,criterion="MFI") # with catR installed
#> $item
#> [1] 5
#> 
#> $par
#> alphaj betaj1 betaj2 betaj3 betaj4 
#>  2.103 -0.812  0.094  0.881  1.736 
#> 
#> $info
#> [1] 1.329314
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
compute_next_item_grm(theta=0,bank)
#> $item
#> [1] 5
#> 
#> $info
#> [1] 1.329314
#> 
#> $available
#> [1] 1 2 3 4 5
#> 
```
