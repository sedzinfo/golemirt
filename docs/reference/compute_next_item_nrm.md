# select the next item by maximum Fisher information

select the next item by maximum Fisher information

## Usage

``` r
compute_next_item_nrm(theta, bank, out = NULL, D = 1, randomesque = 1)
```

## Arguments

- theta:

  current ability estimate

- bank:

  matrix of item parameters

- out:

  vector of the indices of the items already administered

- D:

  metric constant kept for the same interface as the other files and not
  used

- randomesque:

  number of most informative items to draw at random from\
  1 is pure maximum information and 3 to 5 spreads item exposure

## Value

item index of the selected item in the bank\
info information of the selected item at theta\
available indices of the items still available

## Note

this function should return the same result as\
catR::nextItem(itemBank,model="NRM",theta,out,criterion="MFI") when\
randomesque is 1 and the most informative item is unique\
when several items tie exactly catR draws one of them at random while
this\
function takes the first\
with randomesque above 1 catR also keeps every item tied with the last
one kept\
so it can draw from more than randomesque items\
every item has its own slopes and intercepts so the information curves
differ\
in height and shape and the information of every available item has to
be\
computed at theta

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
catR::nextItem(bank,model="NRM",theta=0,criterion="MFI") # with catR installed
#> $item
#> [1] 2
#> 
#> $par
#> alpha1     c1 alpha2     c2 alpha3     c3 alpha4     c4 
#>  0.782  0.906  1.487  1.093  2.391  0.517  3.087 -0.814 
#> 
#> $info
#> [1] 0.679397
#> 
#> $criterion
#> [1] "MFI"
#> 
#> $randomesque
#> [1] 1
#> 
#> $name
#> [1] "2"
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
compute_next_item_nrm(theta=0,bank)
#> $item
#> [1] 2
#> 
#> $info
#> [1] 0.679397
#> 
#> $available
#> [1] 1 2 3 4 5
#> 
```
