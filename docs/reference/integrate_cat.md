# compute integral of f(x)

compute integral of f(x)

## Usage

``` r
integrate_cat(x, y)
```

## Arguments

- x:

  a vector of x values for numerical integration

- y:

  a vector of numerical values corresponding to f(x) values

## Note

this function should return the same result as the catR::integrate.catR
function

## Examples

``` r
x<-seq(from=-3,to=3,length=33)
y<-round(exp(x),2)
plot(x=x,y=y)

catR::integrate.catR(x,y) # this will work with catR package installed
#> [1] 20.09437
integrate_cat(x=x,y=y)
#> [1] 20.09437
```
