# select the next item by maximum Fisher information

select the next item by maximum Fisher information

## Usage

``` r
compute_next_item_dichotomous(theta, bank, out = NULL, D = 1, randomesque = 1)
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
catR::nextItem(itemBank,theta,out,criterion="MFI") when randomesque is 1
and\
the most informative item is unique\
when several items tie exactly catR draws one of them at random while
this\
function takes the first\
with randomesque above 1 catR also keeps every item tied with the last
one kept\
so it can draw from more than randomesque items\
when every item has the same a with c=0 and d=1 the information curves
are\
copies of one another shifted by b and symmetric around it so the most\
informative item is the one whose b is closest to theta\
with different a c or d the curves differ in height and shape so the\
information of every available item has to be computed at theta

## Examples

``` r
bank<-matrix(c(1.75,1.80,1.85,1.90,1.95,
              -3,-2,0,2,3,
               0.1,0.1,0.1,0.1,0.1,
               0.9,0.9,0.9,0.9,0.9),
             nrow=5,
             dimnames=list(c(1,2,3,4,5),
                           c("a","b","c","d")))
catR::nextItem(bank,theta=0,criterion="MFI")
#> $item
#> [1] 3
#> 
#> $par
#>    a    b    c    d 
#> 1.85 0.00 0.10 0.90 
#> 
#> $info
#>      3 
#> 0.5476 
#> 
#> $criterion
#> [1] "MFI"
#> 
#> $randomesque
#> [1] 1
#> 
#> $name
#> [1] "3"
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
compute_next_item_dichotomous(theta=0,bank)
#> $item
#> [1] 3
#> 
#> $info
#>      3 
#> 0.5476 
#> 
#> $available
#> [1] 1 2 3 4 5
#> 
```
