# Probit response functions of Thurstonian IRT

The probability of a binary outcome as the standard normal distribution
function \\\Phi\\ of the latent trait \\\eta\\, in three forms:

- `prob_tirt()`:

  a single outcome, with the parameters of factor analysis,
  \\\Phi((-\gamma + \lambda \eta) / \sqrt{\psi})\\;

- `prob_tirt_pair()`:

  the choice of item \\i\\ over item \\k\\, \\\Phi((-\gamma + \lambda_i
  \eta - \lambda_k \eta) / \sqrt{\psi_i + \psi_k})\\;

- `prob_tirt_intercept()`:

  the same comparison in intercept and slope form, \\\Phi(\alpha +
  (\beta_i - \beta_k) \eta)\\.

## Usage

``` r
prob_tirt(eta, gamma = 0, lambda = 0.5, psi = 0.5)

prob_tirt_pair(
  eta,
  gamma = 0,
  lambda_i = 0.5,
  lambda_k = 0,
  psi_i = 0.5,
  psi_k = 0.5
)

prob_tirt_intercept(eta, alpha = 0, beta_i = 0.5, beta_k = 0)
```

## Arguments

- eta:

  Numeric vector of trait values.

- gamma:

  Threshold.

- lambda, lambda_i, lambda_k:

  Factor loadings.

- psi, psi_i, psi_k:

  Error (unique) variances.

- alpha:

  Intercept.

- beta_i, beta_k:

  Slopes.

## Value

A numeric vector of probabilities, one for each value of `eta`.

## Examples

``` r
eta <- c(-2, 0, 2)
prob_tirt(eta)
#> [1] 0.0786496 0.5000000 0.9213504
# the pair and intercept forms agree when alpha = -gamma / sqrt(psi_i + psi_k)
# and each beta = lambda / sqrt(psi_i + psi_k)
prob_tirt_pair(eta, gamma = 0.5, lambda_i = 1, lambda_k = 0.2)
#> [1] 0.01786442 0.30853754 0.86433394
prob_tirt_intercept(eta, alpha = -0.5, beta_i = 1, beta_k = 0.2)
#> [1] 0.01786442 0.30853754 0.86433394
```
