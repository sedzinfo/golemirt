# EAP and MAP estimates of ability by quadrature

Bayesian estimation of a person's ability from a response pattern, at
quadrature points \\X_r\\ spread evenly from -4 to 4. With prior weights
\\A(X_r)\\ and likelihood \\L(X_r)\\, the expected a posteriori estimate
\$\$EAP = \frac{\sum_r X_r L(X_r) A(X_r)}{\sum_r L(X_r) A(X_r)}\$\$ is
the mean of the posterior distribution, and the maximum a posteriori
estimate is the quadrature point where the posterior \\L(X_r) A(X_r)\\
is highest. The defaults replicate de Ayala (2009, p. 79).

## Usage

``` r
eap_map(
  responses,
  b = c(-2.155, -0.245, 0.206, 0.984, 1.211),
  a = rep(1, length(b)),
  quadrature = 10,
  mean = 0,
  sd = 1,
  skew = 1
)
```

## Arguments

- responses:

  Ones and zeros, the responses to the items.

- b:

  Difficulties of the items; the default is the five items of de Ayala
  (2009, Table 4.4).

- a:

  Discriminations of the items: 1 for the Rasch model.

- quadrature:

  Number of quadrature points.

- mean, sd:

  Mean and standard deviation of the prior.

- skew:

  Skewness parameter of the prior, `xi` in
  [`fGarch::dsnorm()`](https://geobosh.github.io/fGarchDoc/reference/dist-snorm.html).

## Value

A list with `x`, the quadrature points; `prior`, the prior weights;
`trace`, the probability of each observed response at each point (one
column per item); `likelihood`; `posterior`, the product of prior and
likelihood; `eap`, `psd` (the posterior standard deviation) and `map`;
and `responses` and `prior_mean`, as given.

## References

de Ayala, R. J. (2009). *The Theory and Practice of Item Response
Theory*. New York: Guilford Press.

## Examples

``` r
estimate <- eap_map(response_pattern(2))
c(EAP = estimate$eap, MAP = estimate$map)
#>        EAP        MAP 
#> -0.2271434 -0.4444444 
```
