# select the next item by maximum Fisher information

select the next item by maximum Fisher information

## Usage

``` r
compute_next_item_pcm(theta, bank, out = NULL, D = 1, randomesque = 1)
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
catR::nextItem(itemBank,model="PCM",theta,out,criterion="MFI") when\
randomesque is 1 and the most informative item is unique\
when several items tie exactly catR draws one of them at random while
this\
function takes the first\
with randomesque above 1 catR also keeps every item tied with the last
one kept\
so it can draw from more than randomesque items\
every item has its own steps so the information curves differ in height
and\
shape and the information of every available item has to be computed at
theta

## Examples

``` r
bank<-matrix(c(-1.853,-2.214,-0.936,-1.508,-0.412,
               -0.627,-0.504,-1.215,-0.183,0.338,
               0.418,0.692,0.284,0.735,1.102,
               1.636,1.927,1.405,2.118,2.285),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("deltaj1","deltaj2","deltaj3","deltaj4")))
catR::nextItem(bank,model="PCM",theta=0,criterion="MFI") # with catR installed
#> $item
#> [1] 5
#> 
#> $par
#> deltaj1 deltaj2 deltaj3 deltaj4 
#>  -0.412   0.338   1.102   2.285 
#> 
#> $info
#> [1] 0.9121881
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
compute_next_item_pcm(theta=0,bank)
#> $item
#> [1] 5
#> 
#> $info
#> [1] 0.9121881
#> 
#> $available
#> [1] 1 2 3 4 5
#> 
```
