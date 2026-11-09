# Interactive Visualizations for Item Response Theory Models and Estimation

**[Open the live
app](https://sedzinfo-golemirt.share.connect.posit.cloud/)** ·
[Website](https://sedzinfo.github.io/golemirt/)

## Overview

**golemirt** is an R package with an interactive Shiny application,
built with [golem](https://thinkr-open.github.io/golem/), for learning
and teaching Item Response Theory (IRT). It brings together two earlier
apps in one site:

- **modelsirt**, which draws the response curves of the main IRT models,
  so that you can see how each item parameter shapes them;
- **mleirt**, which shows how abilities and item parameters are
  estimated, by maximum likelihood and by Bayesian EAP and MAP
  estimation.

Both were adapted from the **irtDemo** package by Wes Bonifay and Metin
Bulus. Every plot is an interactive [plotly](https://plotly.com/r/)
chart that is redrawn as soon as a slider moves.

## Features

The app has eleven tabs in two menus, and a CAT tab.

### Models menu

- **Rasch-4PL**: the item characteristic curve of a dichotomous item
  under the Rasch, 1PL, 2PL, 3PL and 4PL models, with the name of the
  model that the parameters define
- **PCM-GPCM**: category response curves of the partial credit and
  generalized partial credit models
- **GRM**: category response curves of the graded response model
- **RSM-GRSM**: category response curves of the rating scale and
  generalized rating scale models
- **NRM**: category response curves of the nominal response model, for
  unordered categories
- **TIRT**: probit response functions of Thurstonian IRT, for
  forced-choice items and comparative judgments
- **MIRT Dichotomous**: the response surface, contour plot (with the
  item vector) and information surface of an item that measures two
  abilities, compensatory or non-compensatory

### Estimation menu

- **MLE Rasch**: the Newton-Raphson method finding a person’s maximum
  likelihood ability, step by step
- **MLE 2PL**: the log-likelihood surface of an item’s discrimination
  and difficulty, from simulated responses, with its maximum
- **MLE 3PL**: the same surfaces for twelve assumed guessing values, to
  show how guessing affects the estimation
- **EAP-MAP Rasch**: Bayesian estimation of ability by quadrature, with
  the prior, item trace lines, likelihood and posterior

### CAT

- **CAT**: a computerized adaptive test with its workings in view. After
  every answer the ability is estimated by EAP, the next item is the
  most informative one at that estimate, and a scale stops when its
  standard error is small enough; a chart follows the estimate and its
  standard error answer by answer. It runs any questionnaire given as a
  csv file under six models (1PL to 4PL, rating scale, partial credit,
  graded response, modified graded response and nominal response), and
  comes with an example of each

### Key Capabilities

- **Interactive Parameter Adjustment**: sliders for every item
  parameter, with the plots redrawn immediately
- **Interactive Plots**: hover for the values, zoom and pan, rotate the
  3-D surfaces, and click a legend entry to hide or show a curve
- **Textbook Examples**: the default settings of the Estimation tabs
  reproduce the results of de Ayala (2009)
- **Functions in R**: every model, estimation method and plot of the app
  is also an R function

## Installation

### Prerequisites

1.  **Install R** (version 4.1 or higher): <https://cran.r-project.org/>
2.  **Install RStudio** (optional but recommended):
    <https://posit.co/downloads/>

### Package Installation

Open RStudio (or an R console) and run:

``` r

# Install devtools if you haven't already
install.packages("devtools")
# Install golemirt from GitHub
devtools::install_github("sedzinfo/golemirt")
```

The dependencies (`shiny`, `golem`, `plotly`, `config` and `fGarch`) are
installed automatically.

Without devtools, install the source tarball of the [latest
release](https://github.com/sedzinfo/golemirt/releases/tag/latest),
which is rebuilt from `main` on every change, together with the PDF
manual:

``` r

install.packages(
  "https://github.com/sedzinfo/golemirt/releases/download/latest/golemirt_0.0.0.9000.tar.gz",
  repos = NULL, type = "source"
)
```

## Usage

Launch the app with two lines of code:

``` r

library(golemirt)
run_app()
```

The app opens in your default web browser. Any
[`shiny::shinyApp()`](https://shiny.posit.co/r/reference/shiny/latest/shinyapp.html)
option can be passed on, for example
`run_app(options = list(port = 8080))`.

## Using the Functions in R

The models, estimation methods and plots of the app are also available
as functions, for scripts, R Markdown reports and teaching material:

``` r

library(golemirt)

# category response curves of a polytomous item
theta <- seq(-6, 6, by = 0.1)
plot_category_curves(theta, prob_gpcm(theta, a = 1.5), "Generalized Partial Credit Model")
plot_category_curves(theta, prob_grm(theta, b = c(-1.5, 0, 1.5)), "Graded Response Model")

# an item that measures mostly the first of two abilities
grid <- seq(-4, 4, length.out = 50)
a <- c(2, 0.5)
plot_mirt_contour(grid, grid, prob_mirt(grid, grid, a = a), level = 0.5, arrow = item_vector(a))

# Newton-Raphson steps towards the maximum likelihood estimate of ability
nr <- newton_raphson_rasch(response_pattern(2), iterations = 5)
nr$steps[, c("start", "end")]
plot_newton_raphson(nr)

# EAP and MAP estimates with 40 quadrature points
estimate <- eap_map(response_pattern(2), quadrature = 40)
c(EAP = estimate$eap, MAP = estimate$map)
plot_eap_combined(estimate)
```

An adaptive test runs the same way outside the app:

``` r

# the IPIP-50 Big Five example under the graded response model
q <- read_questionnaire(example_questionnaires()[3])
s <- cat_start(q, scales = "Extraversion", se_threshold = 0.40)
while (s$stage == "testing") {
  item <- cat_item(s)
  s <- cat_answer(s, 4) # the option chosen: "Moderately accurate"
}
cat_results(s)
plot_cat_trajectory(s)
```

The help page of
[`run_app()`](https://sedzinfo.github.io/golemirt/reference/run_app.md)
describes every tab, with the formulas of the models and what each
control and plot shows.

## Your own questionnaire: one csv, six models

The CAT tab runs any questionnaire given as a csv file, one row per
item, under the six models of the [EAP
tutorials](https://sedzinfo.github.io/vignettes/cat_irt_eap/):

| Model | mirt `itemtype` | Example in the app |
|----|----|----|
| Dichotomous 1PL to 4PL | `Rasch` (2 categories), `2PL`, `3PL`, `4PL` | SAT12 science test, 3PL |
| Rating scale (RSM) | `rsm` | IPIP-50 Big Five |
| Partial credit (PCM) | `Rasch` (3+ categories) | IPIP-50 Big Five |
| Graded response (GRM) | `graded` | IPIP-50 Big Five |
| Modified graded response (MGRM) | `grsm` | IPIP-50 Big Five |
| Nominal response (NRM) | `nominal` | SAT12 science test, option by option |

The columns are the item text, its answer options and the coefficients
**as mirt names them**, so a csv is written straight from a fitted
model:

``` r

library(mirt)
fit <- mirt(responses, 1, itemtype = "graded")       # one model per scale
q <- questionnaire_from_mirt(fit, "Anxiety",
  question = c("I worry a lot", "I feel tense", ...),
  options = c("Never", "Sometimes", "Often", "Always")
)
write_questionnaire(q, "anxiety.csv")                # or a list of scales
```

| Column |  |
|----|----|
| `scale`, `question`, `itemtype` | required |
| `item`, `stem` | optional id, and an instruction shown above the item |
| `option1`, `option2`, … | the answer options in scoring order (numbered when absent) |
| `key` | right/wrong items given as several options: the correct one |
| `reverse` | `TRUE` for ordered items scored in reverse |
| `public` | `FALSE` when the item text is not public and only a placeholder is shown: the CAT tab then highlights the correct option (`key`) in yellow |
| `a1`, `b1`…, `c`, `d`, `d0`…, `ak0`…, `g`, `u` | the coefficients of `coef(fit, simplify = TRUE)$items` |
| `prior_mean`, `prior_sd` | mean and sd of the latent trait of the scale (0 and 1 when absent) |

[`read_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md)
reads and checks a file, naming the row of any problem, and converts the
coefficients to the catR parameters of each engine;
[`validate_questionnaire_against_mirt()`](https://sedzinfo.github.io/golemirt/reference/validate_questionnaire_against_mirt.md)
compares the result with the fitted model, item by item. The examples
are made by `data-raw/examples.R` in exactly this way. Download one from
the app to see a complete file.

## Screenshots

### Rasch-4PL

![Item characteristic curves of the Rasch
model](reference/figures/golemirt1.png)

Item characteristic curves of the Rasch model

### PCM-GPCM

![Category response curves of the partial credit
model](reference/figures/golemirt2.png)

Category response curves of the partial credit model

### GRM

![Category response curves of the graded response
model](reference/figures/golemirt3.png)

Category response curves of the graded response model

### RSM-GRSM

![Category response curves of the rating scale
model](reference/figures/golemirt4.png)

Category response curves of the rating scale model

### NRM

![Category response curves of the nominal response
model](reference/figures/golemirt5.png)

Category response curves of the nominal response model

### TIRT

![Probit response function of Thurstonian
IRT](reference/figures/golemirt6.png)

Probit response function of Thurstonian IRT

### MIRT Dichotomous

![Item response surface of a compensatory two-dimensional
item](reference/figures/golemirt7.png)![Contour plot of a compensatory
two-dimensional item with its item
vector](reference/figures/golemirt8.png)

### MLE Rasch

![Newton-Raphson step on the log-likelihood of a Rasch response
pattern](reference/figures/golemirt9.png)

Newton-Raphson step on the log-likelihood of a Rasch response pattern

### MLE 2PL

![Log-likelihood surface of discrimination and difficulty with its
maximum](reference/figures/golemirt10.png)

Log-likelihood surface of discrimination and difficulty with its maximum

### MLE 3PL

![Log-likelihood surfaces for twelve guessing
values](reference/figures/golemirt11.png)

Log-likelihood surfaces for twelve guessing values

### EAP-MAP Rasch

![Prior, item trace lines, likelihood and posterior of an EAP and MAP
estimation](reference/figures/golemirt12.png)![Prior, likelihood and
posterior in one plot](reference/figures/golemirt13.png)

### CAT

![An adaptive test of two Big Five traits under the graded response
model](reference/figures/golemirt14.png)![An adaptive test of the SAT12
science questions under the 3PL, with the correct option
highlighted](reference/figures/golemirt15.png)

## Development

The package follows the layout of a
[golem](https://thinkr-open.github.io/golem/) app:

| File | Contents |
|----|----|
| `R/run_app.R` | [`run_app()`](https://sedzinfo.github.io/golemirt/reference/run_app.md), which starts the app, with the help page that describes every tab |
| `R/app_ui.R`, `R/app_server.R` | The navigation bar with the two menus, and the server, which starts the modules |
| `R/mod_*.R` | One Shiny module per tab |
| `R/fct_models.R` | The response functions of the models |
| `R/fct_estimation.R` | Log-likelihoods, Newton-Raphson steps, and EAP and MAP estimation |
| `R/fct_plots.R` | The plotly charts |
| `R/fct_cat_engine_*.R` | The adaptive engines of the six models, ported unchanged from the EAP tutorials |
| `R/fct_questionnaire.R` | The csv format of a questionnaire: reading, checking, writing from mirt, the examples |
| `R/fct_cat.R` | The CAT session: start, next item, answer, results |
| `R/utils_helpers.R` | Small helpers shared by the modules and charts |
| `R/app_config.R`, `inst/golem-config.yml` | The golem configuration |
| `inst/app/www/` | The favicon |
| `inst/extdata/examples/` | The example questionnaires of the CAT tab, one per model |
| `data-raw/examples.R` | Fits the example questionnaires with mirt and checks them |
| `tests/testthat/` | Tests of the functions (the CAT engines against catR), the modules and the page |

Run the tests with
[`devtools::test()`](https://devtools.r-lib.org/reference/test.html),
and the full package check with
[`devtools::check()`](https://devtools.r-lib.org/reference/check.html).
`generate_package.R` documents, tests and installs the package, and
builds the website, the PDF manual and the tarball.

### Deploying to shinyapps.io

`app.R` starts the app on [shinyapps.io](https://www.shinyapps.io/), and
`.rscignore` keeps the upload to the files the app needs.

1.  Connect your account once, with the
    [`rsconnect::setAccountInfo()`](https://rstudio.github.io/rsconnect/reference/setAccountInfo.html)
    line from Account, Tokens on shinyapps.io.
2.  Run `rsconnect::deployApp(appName = "golemirt")` from the package
    folder, or open `app.R` in RStudio and click Publish.

## Background and Attribution

The plots were originally developed by **Wes Bonifay** and **Metin
Bulus** for the **irtDemo** package, which is available on CRAN.
**Dimitrios Zacharatos** modified and expanded them in the modelsirt and
mleirt packages, which golemirt brings together as one golem app:

- consolidating the IRT models and estimation methods into a single
  interface
- rebuilding the visualisations with Plotly for interactivity
- adding further IRT models
- improving the user interface

Special thanks to [Kostas Maistrelis](https://github.com/maisk) for
contributing the implementation of the Thurstonian IRT curves. Each tab
keeps the credit shown in the original apps.

**Original Authors**: Wes Bonifay and Metin Bulus\
**Current Maintainer**: Dimitrios Zacharatos\
**Original CRAN Package**:
[irtDemo](https://cran.r-project.org/package=irtDemo)

## References

- Andrich, D. (1978). A rating formulation for ordered response
  categories. *Psychometrika*, 43(4), 561-573.
- Baker, F. B. (1992). *Item Response Theory: Parameter Estimation
  Techniques*. Marcel Dekker.
- Bock, R. D. (1972). Estimating item parameters and latent ability when
  responses are scored in two or more nominal categories.
  *Psychometrika*, 37(1), 29-51.
- Bulus, M., & Bonifay, W. (2022). irtDemo R Package: Pedagogical
  Interactive Web Applications for Estimation, Scoring, and Multi
  Dimensionality in Item Response Theory. *Anadolu University Journal of
  Education Faculty*, 6(1), 92-108.
  <https://doi.org/10.34056/aujef.913781>
- Chalmers, R. P. (2012). mirt: A multidimensional item response theory
  package for the R environment. *Journal of Statistical Software*,
  48(6), 1-29.
- de Ayala, R. J. (2009). *The Theory and Practice of Item Response
  Theory*. Guilford Press.
- Goldberg, L. R. (1992). The development of markers for the Big-Five
  factor structure. *Psychological Assessment*, 4(1), 26-42.
- Magis, D. (2013). A note on the item information function of the
  four-parameter logistic model. *Applied Psychological Measurement*,
  37(4), 304-315.
- Magis, D., & Barrada, J. R. (2017). Computerized adaptive testing with
  R: Recent updates of the package catR. *Journal of Statistical
  Software*, 76(1), 1-19.
- Masters, G. N. (1982). A Rasch model for partial credit scoring.
  *Psychometrika*, 47(2), 149-174.
- Muraki, E. (1990). Fitting a polytomous item response model to
  Likert-type data. *Applied Psychological Measurement*, 14(1), 59-71.
- Muraki, E. (1992). A generalized partial credit model: Application of
  an EM algorithm. *Applied Psychological Measurement*, 16(2), 159-176.
- Samejima, F. (1969). Estimation of latent ability using a response
  pattern of graded scores. *Psychometrika Monograph Supplement*, 17.
- van der Linden, W. J., & Glas, C. A. W. (Eds.) (2010). *Elements of
  Adaptive Testing*. Springer.

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to
check the [issues page](https://github.com/sedzinfo/golemirt/issues).

------------------------------------------------------------------------

![Stars](https://img.shields.io/github/stars/sedzinfo/golemirt)![Watchers](https://img.shields.io/github/watchers/sedzinfo/golemirt)![Repo
Size](https://img.shields.io/github/repo-size/sedzinfo/golemirt)![Open
Issues](https://img.shields.io/github/issues/sedzinfo/golemirt)![Forks](https://img.shields.io/github/forks/sedzinfo/golemirt)![Last
Commit](https://img.shields.io/github/last-commit/sedzinfo/golemirt)![Contributors](https://img.shields.io/github/contributors/sedzinfo/golemirt)![License](https://img.shields.io/github/license/sedzinfo/golemirt)![Workflow
Status](https://img.shields.io/github/actions/workflow/status/sedzinfo/golemirt/build-tarball.yml)![R-CMD-check](https://github.com/sedzinfo/golemirt/actions/workflows/R-CMD-check.yaml/badge.svg)
