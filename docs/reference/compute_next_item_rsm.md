# select the next item by maximum Fisher information

select the next item by maximum Fisher information

## Usage

``` r
compute_next_item_rsm(theta, bank, out = NULL, D = 1, randomesque = 1)
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
catR::nextItem(itemBank,model="RSM",theta,out,criterion="MFI") when\
randomesque is 1\
under the rating scale model this is equivalent to picking the item
whose\
lambdaj sits closest to theta because all information curves are
identical\
in shape so the maximum is a pure nearest neighbour lookup on lambdaj

## Examples

``` r
bank<-matrix(c(-0.560,-0.230,1.559,0.071,0.129,
               rep(1.715,5),rep(0.461,5),rep(-1.265,5),rep(-0.687,5)),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("lambdaj","delta1","delta2","delta3","delta4")))
catR::nextItem(bank,model="RSM",theta=0,criterion="MFI") # with catR installed
#> $item
#> [1] 4
#> 
#> $par
#> lambdaj  delta1  delta2  delta3  delta4 
#>   0.071   1.715   0.461  -1.265  -0.687 
#> 
#> $info
#> [1] 3.061434
#> 
#> $criterion
#> [1] "MFI"
#> 
#> $randomesque
#> [1] 1
#> 
#> $name
#> [1] "4"
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
compute_next_item_rsm(theta=0,bank)
#> $item
#> [1] 4
#> 
#> $info
#> [1] 3.061434
#> 
#> $available
#> [1] 1 2 3 4 5
#> 
```
