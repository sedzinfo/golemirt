# Explore IRT models and how their parameters are estimated

Launches a Shiny app that shows item response theory (IRT) with
interactive plots, in two menus. The Models menu draws the item response
functions of the main IRT models, so that you can see how each item
parameter shapes them: the probability of each possible response is
plotted against the latent trait and redrawn as soon as a parameter is
changed. It covers the Rasch model and the one- to four-parameter
logistic models for dichotomous items; the partial credit, generalized
partial credit, graded response, rating scale, generalized rating scale
and nominal response models for polytomous items; the probit response
functions of Thurstonian IRT; and the response surface, contour plot and
information surface of a dichotomous item that measures two abilities
(multidimensional IRT). The Estimation menu shows how the estimates are
found: a person's ability by maximum likelihood with the Newton-Raphson
method (Rasch model), an item's discrimination and difficulty by maximum
likelihood (two- and three-parameter logistic models), and a person's
ability by Bayesian expected a posteriori (EAP) and maximum a posteriori
(MAP) estimation. Its examples follow de Ayala (2009), and the default
settings reproduce his published results.

## Usage

``` r
run_app(
  onStart = NULL,
  options = list(),
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
)
```

## Arguments

- onStart:

  A function that will be called before the app is actually run. See
  [`shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html).

- options:

  Named options passed to
  [`runApp()`](https://rdrr.io/pkg/shiny/man/runApp.html), for example
  `list(port = 8080)`. See
  [`shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html).

- enableBookmarking:

  See [`shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html).

- uiPattern:

  See [`shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html).

- ...:

  Arguments passed to
  [`golem::with_golem_options()`](https://thinkr-open.github.io/golem/reference/with_golem_options.html),
  which the app can read with
  [`golem::get_golem_options()`](https://thinkr-open.github.io/golem/reference/get_golem_options.html).

## Value

A Shiny app object
([`shiny::shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html)).
Printing it, which is what happens when you call `run_app()` at the
console, starts the app in the browser or the RStudio viewer; you can
also pass it to
[`shiny::runApp()`](https://rdrr.io/pkg/shiny/man/runApp.html).

## Details

Each tab of the Models menu plots, for a single item, the probability of
each possible response as a function of the person's position on the
latent trait (ability), written \\\theta\\ (\\\eta\\ in the TIRT tab).
The basic building block is the four-parameter logistic function \$\$P(X
= 1 \mid \theta) = c + \frac{d - c}{1 + \exp(-D a (\theta - b))}\$\$ the
probability of a correct (or keyed) response, \\X = 1\\, where \\a\\ is
the discrimination (how steeply the probability rises with ability),
\\b\\ the difficulty (the ability at which the probability is halfway
between its lower and upper limits), \\c\\ the lower asymptote (the
probability at very low abilities, as with guessing) and \\d\\ the upper
asymptote (the probability at very high abilities). \\D\\ is the scaling
constant: 1 keeps the logistic metric, and 1.702 makes the logistic
curve almost coincide with the normal ogive, the cumulative normal
distribution. The Rasch-4PL tab plots this function itself, the GRM tab
uses it with \\c = 0\\ and \\d = 1\\ for the boundaries between
categories, and the MIRT Dichotomous tab extends it to two abilities;
the other models are given in their sections.

The five tabs on a single trait, Rasch-4PL to NRM, share a layout. A
Scaling Constant choice sets \\D\\ to 1 (the default) or 1.702. The
ability axis runs from -6 to 6, so a curve centred beyond that range,
which most location sliders allow (they reach -10 and 10), moves out of
view. The plots have a marker at every 0.1 of ability: hovering shows
the values, clicking a legend entry hides or shows its curve, and the
plot can be zoomed and panned. A horizontal gray line marks a
probability of 0.5, and the vertical line at 0 is the zero line of the
axis. Every plot is redrawn as soon as a control changes.

The tabs of the Estimation menu use the same function with \\d = 1\\ and
no scaling constant (\\D = 1\\), and write \\\alpha\\ for the
discrimination and \\\delta\\ for the difficulty: \$\$P(u = 1 \mid
\theta) = c + (1 - c) \frac{\exp(\alpha(\theta - \delta))}{1 +
\exp(\alpha(\theta - \delta))}.\$\$ The Rasch model fixes \\\alpha = 1\\
and \\c = 0\\, the two-parameter logistic model (2PL) fixes \\c = 0\\,
and the three-parameter logistic model (3PL) estimates all three. The
likelihood of a set of responses is the product of the probabilities of
the responses given, and the log-likelihood is its logarithm.

The app has eleven tabs, described in the sections below: Rasch-4PL,
PCM-GPCM, GRM, RSM-GRSM, NRM, TIRT and MIRT Dichotomous in the Models
menu, and MLE Rasch, MLE 2PL, MLE 3PL and EAP-MAP Rasch in the
Estimation menu. The models and estimation methods are also available as
functions, such as
[`prob_gpcm()`](https://sedzinfo.github.io/golemirt/reference/prob_gpcm.md)
and
[`eap_map()`](https://sedzinfo.github.io/golemirt/reference/eap_map.md),
and each plot of the app as a `plot_*()` function, such as
[`plot_category_curves()`](https://sedzinfo.github.io/golemirt/reference/plot_category_curves.md).

## Rasch-4PL

The item characteristic curve of a dichotomous item under the
four-parameter logistic model (4PL) and the models nested in it, which
fix some of its parameters.

- **Controls:** the scaling constant; the discrimination \\a\\ (-10 to
  10, default 1); the difficulty \\b\\ (-10 to 10, default 0); the
  guessing parameter \\c\\ (0 to 1, default 0); the inattentiveness
  parameter \\d\\ (0 to 1, default 1); and the probability to plot:
  \\P(X = 1 \mid \theta)\\ alone, or \\P(X \mid \theta)\\ (the default),
  which adds the probability of an incorrect response, \\P(X = 0 \mid
  \theta) = 1 - P(X = 1 \mid \theta)\\.

- **Plot:** the chosen curves across ability, with a legend. The title
  names the model that the current values define: Rasch Model when \\a =
  1\\, \\c = 0\\ and \\d = 1\\; 1PL or 2PL Model when \\c = 0\\ and \\d
  = 1\\ but \\a\\ is not 1 (with a single item, a discrimination shared
  by all items, as in the 1PL, cannot be told apart from one specific to
  the item, as in the 2PL); 3PL Model when \\c \> 0\\ and \\d = 1\\; 4PL
  Model (c = 0) when \\c = 0\\ and \\d \< 1\\, a 4PL without guessing
  whose upper asymptote allows for slipping (careless errors by able
  respondents); and 4PL Model when \\c \> 0\\ and \\d \< 1\\.

- **Text:** below the controls, the name of the model followed by the
  values of \\a\\, \\b\\, \\c\\ and \\d\\.

Raising \\b\\ moves the curve to the right, so that a higher ability is
needed for the same probability. The discrimination sets the steepness:
at \\\theta = b\\ the slope is \\D a (d - c) / 4\\, a negative \\a\\
makes the probability fall as ability rises, and \\a = 0\\ makes the
curve flat. Raising \\c\\ lifts the lower end of the curve, so that even
the least able answer correctly with probability \\c\\, as when
guessing; lowering \\d\\ pulls the upper end down, so that even the most
able miss with probability \\1 - d\\, as through inattention. With \\c =
0\\ and \\d = 1\\ the curve crosses the gray line at \\\theta = b\\,
where the curves of \\P(X = 1 \mid \theta)\\ and \\P(X = 0 \mid
\theta)\\ also cross; in general it reaches the midpoint \\(c + d) / 2\\
there. Choosing \\D = 1.702\\ makes the curve steeper by that factor.

## PCM-GPCM

Category response curves of an item scored in five ordered categories, 1
to 5, under the partial credit model (PCM) and the generalized partial
credit model (GPCM): \$\$P(X = k \mid \theta) =
\frac{\exp\left(\sum\_{v=1}^{k-1} D a (\theta -
\delta_v)\right)}{\sum\_{h=1}^{5} \exp\left(\sum\_{v=1}^{h-1} D a
(\theta - \delta_v)\right)}\$\$ for \\k = 1, \ldots, 5\\, where \\a\\ is
the discrimination, \\\delta_1, \ldots, \delta_4\\ are the step
parameters (one for each step from a category to the next) and an empty
sum is 0, so that category 1 has the numerator 1.

- **Controls:** the scaling constant; the discrimination \\a\\ (-10 to
  10 in steps of 0.5, default 1); and the four step parameters (-10 to
  10), with defaults -2, -0.7, 0.8 and 2 (the code asks for -0.75 and
  0.75, which the sliders round to one decimal).

- **Plot:** the probabilities of the five categories, \\P(X = 1 \mid
  \theta)\\ to \\P(X = 5 \mid \theta)\\, one coloured curve each. The
  title reads Partial Credit Model (Masters, 1982) when \\a = 1\\ and
  Generalized Partial Credit Model (Muraki, 1992) otherwise. A
  discrimination of 0 is rejected with a message in place of the plot.

The curves of adjacent categories \\k\\ and \\k + 1\\ cross exactly at
\\\theta = \delta_k\\, so each step parameter moves one crossing point.
With the step parameters in increasing order, each category in turn is
the most likely response as ability rises; if a step parameter is lower
than the one before it (reversed steps), the category between them is
never the most likely. A larger \\a\\ makes the curves narrower and more
peaked, and a negative \\a\\ reverses the order of the categories along
the ability axis.

## GRM

Category response curves of an item with five ordered categories under
the graded response model (GRM). The model first gives, for each of the
four boundaries between adjacent categories, the probability of a
response in a category above the boundary, \$\$P^\*\_k(\theta) =
\frac{1}{1 + \exp(-D a (\theta - \delta_k))}, \quad k = 1, \ldots,
4,\$\$ and then the probability of each category as the difference
between successive boundary curves, \\P(X = m \mid \theta) =
P^\*\_{m-1}(\theta) - P^\*\_m(\theta)\\ for \\m = 1, \ldots, 5\\, with
\\P^\*\_0 = 1\\ and \\P^\*\_5 = 0\\.

- **Controls:** the scaling constant; the discrimination \\a\\ (0 to 10,
  default 1.5), shared by all boundaries; and the four difficulties,
  \\\delta_1\\ (-2.5 to -1.5), \\\delta_2\\ (-1.25 to -0.25),
  \\\delta_3\\ (0 to 1.25) and \\\delta_4\\ (1.5 to 2.5), with defaults
  -2, -0.8, 0.8 and 2 (the code asks for -0.75 and 0.75, which the
  sliders round to one decimal). The slider ranges do not overlap, which
  keeps the difficulties in increasing order, as the model requires:
  otherwise some category probabilities would be negative. For the same
  reason the discrimination cannot be negative: the boundary curves
  would then fall instead of rise and swap order, so an item that runs
  the other way is reverse-scored instead. At \\a = 0\\ the item does
  not depend on ability: every boundary curve is flat at 0.5, so
  categories 1 and 5 each get probability 0.5 and the middle categories
  none.

- **Plot:** \\P(X = 1 \mid \theta)\\ to \\P(X = 5 \mid \theta)\\, one
  coloured curve each, titled Graded Response Model.

Each difficulty \\\delta_k\\ is the ability at which a response above
category \\k\\ becomes as likely as not. Only the first and the last can
be read directly from the plot: the curve of category 1 crosses the gray
line at \\\delta_1\\, and that of category 5 at \\\delta_4\\. Unlike the
step parameters of the PCM, the difficulties are not the points where
adjacent curves cross. Because the GRM gives the item a single
discrimination, changing \\a\\ makes all curves steeper or flatter
together.

## RSM-GRSM

Category response curves of an item with five ordered categories under
the rating scale model (RSM) and its generalized form with a
discrimination parameter (GRSM). Both are partial credit models in which
each step parameter is split into the difficulty of the item and a
threshold: \$\$P(X = k \mid \theta) = \frac{\exp\left(\sum\_{v=1}^{k-1}
D a (\theta - (\delta + \tau_v))\right)}{\sum\_{h=1}^{5}
\exp\left(\sum\_{v=1}^{h-1} D a (\theta - (\delta + \tau_v))\right)}\$\$
where \\\delta\\ is the difficulty (location) of the item and \\\tau_1,
\ldots, \tau_4\\ are the thresholds, which in a rating scale model are
the same for all items that share a response scale.

- **Controls:** the scaling constant; the discrimination \\a\\ (-10 to
  10, default 1); the difficulty \\\delta\\ (-10 to 10, default 0); and
  the four thresholds (-10 to 10; defaults -1, -0.4, 0.4 and 1).

- **Plot:** \\P(X = 1 \mid \theta)\\ to \\P(X = 5 \mid \theta)\\, one
  coloured curve each. The title reads Rating Scale Model
  (Andrich, 1978) when \\a = 1\\ and Generalized Rating Scale Model
  (Muraki, 1990) otherwise. A discrimination of 0 is rejected with a
  message in place of the plot.

Adjacent curves \\k\\ and \\k + 1\\ cross at \\\theta = \delta +
\tau_k\\. Changing the difficulty shifts all five curves along the
ability axis together without changing their shape, the thresholds set
the spacing of the crossings around the difficulty, and the
discrimination sets how peaked the curves are.

## NRM

Category response curves of an item with five unordered categories,
labelled a to e, under the nominal response model (NRM). Category a is
the reference category, whose exponent is fixed at 0, and each of the
other four categories has its own discrimination \\\alpha_k\\ (written
with a Greek letter here, to avoid confusion with category a) and
difficulty \\\delta_k\\: \$\$P(X = k \mid \theta) =
\frac{\exp(z_k)}{\sum\_{h=a}^{e} \exp(z_h)}, \quad z_a = 0, \quad z_k =
D \alpha_k (\theta - \delta_k) \quad (k = b, \ldots, e).\$\$ Following
Baker (1992), each exponent is written with a difficulty rather than an
intercept.

- **Controls:** the scaling constant; four discriminations (-10 to 10;
  defaults -4, -2, 2 and 4) and four difficulties (-10 to 10; defaults
  -4, -2, 2 and 4). Discrimination \\j\\ and difficulty \\j\\ belong to
  the \\j\\-th category after a: 1 to b, 2 to c, 3 to d and 4 to e.

- **Plot:** \\P(X = a \mid \theta)\\ to \\P(X = e \mid \theta)\\, one
  coloured curve each, titled Nominal Response Model, with a note on a
  second, smaller line of the title that Baker's (1992)
  reparameterization is used.

Category \\k\\ is exactly as likely as category a at \\\theta =
\delta_k\\, because the ratio of their probabilities is \\\exp(z_k)\\.
The discriminations order the categories along the ability axis: the
category with the largest discrimination (counting 0 for category a)
becomes the most likely at high abilities, the one with the smallest at
low abilities, and the others can be the most likely in between. Nothing
forces an order on the categories, which is what sets the NRM apart from
the models for ordered categories. With the default values, categories
c, a and d are in turn the most likely across the plotted range, while b
and e would take over only beyond -6 and 6.

## TIRT

Probit response functions of Thurstonian item response theory (TIRT), in
which a binary outcome, such as the choice between two items in a
forced-choice questionnaire, depends on the latent trait \\\eta\\
through \\\Phi\\, the cumulative distribution function of the standard
normal distribution. The tab has three sub-tabs, each named by a
formula, with these functions and controls:

- **First sub-tab:** a single binary outcome, written with the
  parameters of factor analysis, \$\$P(\eta) = \Phi\left(\frac{-\gamma +
  \lambda \eta}{\sqrt{\psi}}\right),\$\$ with the threshold \\\gamma\\
  (-10 to 10, default 0), the factor loading \\\lambda\\ (-10 to 10,
  default 0.5) and the error (unique) variance \\\psi\\ (0 to 10,
  default 0.5).

- **Second sub-tab:** the choice of item \\i\\ over item \\k\\ in a
  pair, \$\$P(\eta) = \Phi\left(\frac{-\gamma + \lambda_i \eta -
  \lambda_k \eta}{\sqrt{\psi_i + \psi_k}}\right),\$\$ with the threshold
  of the pair \\\gamma\\ (-10 to 10, default 0), the loadings of the two
  items \\\lambda_i\\ and \\\lambda_k\\ (-10 to 10; defaults 0.5 and 0)
  and their error variances \\\psi_i\\ and \\\psi_k\\ (0 to 10, default
  0.5 each). The formula on the sub-tab gives each item its own trait,
  but the plot uses the same \\\eta\\ for both, so only the difference
  \\\lambda_i - \lambda_k\\ matters: with equal loadings the curve is
  flat, and the choice tells nothing about the trait.

- **Third sub-tab:** the same comparison in intercept and slope form,
  \$\$P(\eta) = \Phi(\alpha + (\beta_i - \beta_k) \eta),\$\$ with the
  intercept \\\alpha\\ (-10 to 10, default 0) and the slopes \\\beta_i\\
  and \\\beta_k\\ (-10 to 10; defaults 0.5 and 0). It draws the curve of
  the second sub-tab when \\\alpha = -\gamma / \sqrt{\psi_i + \psi_k}\\
  and each \\\beta = \lambda / \sqrt{\psi_i + \psi_k}\\; with their
  defaults, both sub-tabs show \\\Phi(0.5 \eta)\\.

- **Range:** each sub-tab also has a slider labelled \\\eta\\ (1 to 100,
  default 6) that sets no parameter: it sets the range of the horizontal
  axis, from \\-\eta\\ to \\\eta\\.

- **Plot:** the probability, from 0 to 1, against \\\eta\\: a single
  curve with a marker at every 0.1, and the gray line at 0.5.

Each curve crosses 0.5 where the argument of \\\Phi\\ is 0, for example
at \\\eta = \gamma / \lambda\\ in the first sub-tab. The loadings or
slopes set the steepness and direction of the curve, and larger error
variances make it flatter. There is no scaling constant in this tab,
since the curves are normal ogives.

## MIRT Dichotomous

The response surface of a dichotomous item that measures two abilities,
\\\theta_1\\ and \\\theta_2\\ (multidimensional IRT, MIRT), on a grid of
50 by 50 points from -4 to 4 on each dimension. In the compensatory
model (the default) the probability is a logistic function of a weighted
sum of the two abilities, \$\$P(\theta_1, \theta_2) = c + \frac{d -
c}{1 + \exp(-D (a_1 (\theta_1 - \delta_1) + a_2 (\theta_2 -
\delta_2)))},\$\$ so that a high ability on one dimension can make up
for a low ability on the other. In the non-compensatory model it is the
product of one logistic function for each ability, \$\$P(\theta_1,
\theta_2) = c + (d - c) \frac{1}{1 + \exp(-D a_1 (\theta_1 - \delta_1))}
\cdot \frac{1}{1 + \exp(-D a_2 (\theta_2 - \delta_2))},\$\$ so that a
low ability on either dimension keeps the probability low, whatever the
other. Here \\a_1\\ and \\a_2\\ are the discriminations, \\\delta_1\\
and \\\delta_2\\ the locations on the two dimensions, and \\c\\ and
\\d\\ the lower and upper asymptotes.

- **Controls:** a choice labelled Item Response Function, which sets the
  scaling constant of the logistic function: Logistic gives \\D = 1\\,
  and Normal ogive approximation (the default) gives \\D = 1.702\\,
  which makes the logistic curve almost identical to the normal ogive;
  whether the model is compensatory (Yes, the default, or No); the
  item's location on each dimension, labelled \\\theta_1\\ location and
  \\\theta_2\\ location (-10 to 10, default 0); its discrimination on
  each dimension, labelled \\\theta_1\\ discrimination and \\\theta_2\\
  discrimination (-10 to 10, default 1; a value of 0 is rejected with a
  message); the lower asymptote \\c\\ (0 to 0.4 in steps of 0.1,
  default 0) and the upper asymptote \\d\\ (0 to 1, default 1); and
  optional names for the two dimensions. The axes are labelled
  \\\theta_1\\ and \\\theta_2\\, and a name typed in is shown in front
  of the symbol, for example Math (\\\theta_1\\).

- **Item Response Surface sub-tab:** \\P(\theta_1, \theta_2)\\ as an
  interactive 3-D surface, coloured from purple (low) to yellow (high
  probability), with P(Y = 1) from 0 to 1 on the vertical axis; drag it
  to rotate it.

- **Contour Plot sub-tab:** the same surface seen from above, as contour
  lines of equal probability, each labelled with its probability;
  hovering shows the abilities and the probability under the pointer. A
  slider sets the approximate number of contour levels (10 to 100,
  default 10). Black lines mark \\\theta_1 = 0\\ and \\\theta_2 = 0\\,
  and both axes have the same scale. A thick line marks the contour
  halfway between the asymptotes, at probability \\(c + d) / 2\\ (0.5
  when \\c = 0\\ and \\d = 1\\); it is left out when that probability is
  not reached inside the grid, as for a very easy or very hard item. For
  the compensatory model a blue arrow shows the item vector, when it
  lies inside the grid. It starts on the line where the probability is
  halfway between the asymptotes, at the point of that line closest to
  the origin; it points in the direction in which the probability rises
  fastest, at the angle \\\arccos(a_1 / A)\\ to the \\\theta_1\\ axis;
  and its length is the multidimensional discrimination \\A =
  \sqrt{a_1^2 + a_2^2}\\. Its starting point lies at the signed distance
  \\(a_1 \delta_1 + a_2 \delta_2) / A\\, the multidimensional
  difficulty, from the origin along the direction of the arrow.

- **Information Plot sub-tab:** a 3-D surface, seen from the opposite
  corner, of the item information at each point of the grid: the squared
  slope of the probability surface, in the direction in which it rises
  fastest, divided by \\P (1 - P)\\, \$\$I(\theta_1, \theta_2) =
  \frac{(\partial P / \partial \theta_1)^2 + (\partial P / \partial
  \theta_2)^2}{P (1 - P)}.\$\$ For the compensatory model this is the
  information of the four-parameter logistic model (Magis, 2013) along
  the item vector, \$\$I(\theta_1, \theta_2) = \frac{D^2 A^2 (P - c)^2
  (d - P)^2}{(d - c)^2 P (1 - P)},\$\$ which grows with the
  multidimensional discrimination \\A\\ and, when \\c = 0\\ and \\d =
  1\\, is highest along the line where \\P = 0.5\\. For the
  non-compensatory model the slope combines the two logistic parts of
  the model.

In the compensatory model the contour lines are straight and parallel,
at right angles to the item vector, because the probability depends only
on the weighted sum of the abilities; in the non-compensatory model they
bend, since both abilities must be high for a high probability. Making
one discrimination larger than the other turns the item vector towards
the axis of that dimension, which means that the item measures mostly
that ability, and moving a location shifts the surface along its
dimension.

## MLE Rasch

How the Newton-Raphson method finds the maximum likelihood estimate of a
person's ability when the item difficulties are known. The test has five
items with difficulties -1.90, -0.60, -0.25, 0.30 and 0.45 (de Ayala,
2009, p. 22), and a raw score \\r\\ is taken to come from answering the
first \\r\\ items correctly: \\r = 0\\ is the response pattern 00000,
\\r = 2\\ is 11000 and \\r = 5\\ is 11111.

- **Controls:** the raw score, the starting value of the estimate (-2
  to 2) and the iteration to show (1 to 5).

- **Plot:** the log-likelihood of the response pattern for abilities
  from -6 to 6. For the chosen iteration it shows the estimate the step
  starts from (red dot), the tangent to the log-likelihood there (blue
  line) and the estimate the step ends at (green dot), given by
  \\\theta_1 = \theta_0 - LL'(\theta_0) / LL''(\theta_0)\\, with the
  derivatives taken from a smoothing spline of the log-likelihood. The
  shaded triangle shows the angle between the tangent and the horizontal
  axis, which is zero at the maximum.

- **Text:** the numbers of the Newton-Raphson step and the angle.

Raising the iteration shows the estimates converging on the maximum of
the curve, which reproduces the person locations of de Ayala (2009,
Table 2.2, p. 28). For raw scores of 0 and 5 the log-likelihood keeps
rising towards minus or plus infinity, so it has no maximum and the
steps move away: the maximum likelihood estimate does not exist for zero
or perfect scores.

## MLE 2PL

The log-likelihood surface of an item's discrimination and difficulty
under the 2PL, and where its maximum lies. The app simulates the
responses of 50 people, whose abilities are known and spread evenly from
-3 to 3, to one item with the true discrimination and location set on
the sliders, and draws new responses whenever a true value changes.

- **Controls:** the true discrimination and location (difficulty), -3 to
  3.

- **Plot:** the log-likelihood of the simulated responses for every
  combination of discrimination and difficulty from -3 to 3 in steps of
  0.1, as a 3-D surface that can be rotated and zoomed with the mouse;
  hovering shows the values under the pointer. The red dot marks its
  highest point: the maximum likelihood estimates of the two parameters.
  With only 50 responses they differ from the true values by sampling
  error, and they change with every new draw.

## MLE 3PL

The same for the 3PL, to show how the guessing parameter affects the
estimation. The app simulates the responses of the same 50 people from
the true lower asymptote (guessing), discrimination and location set on
the sliders, then computes the log-likelihood surface of discrimination
and difficulty (-3 to 3 in steps of 0.15) for each of twelve assumed
guessing values, 0.05, 0.10, ..., 0.60.

- **Controls:** the true lower asymptote (0.05 to 0.60), discrimination
  and location.

- **Plot:** the twelve surfaces drawn over each other in different
  colours, each with a dot at its highest point; the legend gives the
  guessing value of each colour, and clicking an entry hides or shows
  that surface. All surfaces share one vertical scale.

## EAP-MAP Rasch

Bayesian estimation of a person's ability under the Rasch model, by
quadrature. The test has five items with difficulties fixed at -2.155,
-0.245, 0.206, 0.984 and 1.211 (de Ayala, 2009, Table 4.4), and raw
scores map to response patterns as in the MLE Rasch tab. With prior
weights \\A(X_r)\\ and likelihood \\L(X_r)\\ at the quadrature points
\\X_r\\, \$\$EAP = \frac{\sum_r X_r L(X_r) A(X_r)}{\sum_r L(X_r)
A(X_r)}\$\$ is the mean of the posterior distribution, and MAP is the
quadrature point where the posterior \\L(X_r) A(X_r)\\ is highest.

- **Controls:** the raw score; the number of quadrature points (10 to
  100, spread evenly from -4 to 4); and the mean, standard deviation and
  skewness of the prior, a skew-normal distribution
  ([`fGarch::dsnorm()`](https://geobosh.github.io/fGarchDoc/reference/dist-snorm.html))
  that is normal when the skewness is 1.

- **Separate sub-tab, four plots:** the prior weights at the quadrature
  points; the item trace lines, the probability of each observed
  response across ability (blue for items answered correctly, red for
  items answered incorrectly); the likelihood, the product of those
  probabilities; and the posterior, with lines and values for the EAP
  (blue) and the MAP (red).

- **Combined sub-tab:** the prior (red), likelihood (blue) and posterior
  (black, rescaled to be comparable) in one plot, with dashed lines at
  the prior mean and the posterior mean.

The default settings replicate de Ayala (2009, p. 79). A narrower prior
pulls the EAP towards the prior mean, more quadrature points make both
estimates more precise, and, unlike the maximum likelihood estimate, EAP
and MAP stay finite for raw scores of 0 and 5.

## Acknowledgments

The plots of this app were originally developed by Wes Bonifay and Metin
Bulus for the irtDemo package (Bulus and Bonifay, 2022), available on
CRAN at <https://cran.r-project.org/package=irtDemo>; the title of the
app, IRT Models and Estimation using IRTDemo, reflects this origin.
Dimitrios Zacharatos modified and expanded them in the modelsirt and
mleirt packages, which this package brings together: he consolidated the
IRT models into a single interface, rebuilt the visualisations with
Plotly for interactivity, added further IRT models and improved the user
interface. Special thanks to Kostas Maistrelis
(<https://github.com/maisk>) for contributing the implementation of the
Thurstonian IRT curves. The tabs keep the credits shown in the apps: the
Rasch-4PL, PCM-GPCM, RSM-GRSM and MLE 3PL tabs are credited to Metin
Bulus, the EAP-MAP Rasch tab to Metin Bulus and Wes Bonifay, and the
GRM, NRM, MIRT Dichotomous, MLE Rasch and MLE 2PL tabs to an unknown
contributor.

## References

Andrich, D. (1978). A rating formulation for ordered response
categories. *Psychometrika*, 43(4), 561-573.

Baker, F. B. (1992). *Item Response Theory: Parameter Estimation
Techniques*. New York: Marcel Dekker.

Bulus, M., and Bonifay, W. (2022). irtDemo R Package: Pedagogical
Interactive Web Applications for Estimation, Scoring, and Multi
Dimensionality in Item Response Theory. *Anadolu University Journal of
Education Faculty*, 6(1), 92-108.
[doi:10.34056/aujef.913781](https://doi.org/10.34056/aujef.913781)

de Ayala, R. J. (2009). *The Theory and Practice of Item Response
Theory*. New York: Guilford Press.

Magis, D. (2013). A note on the item information function of the
four-parameter logistic model. *Applied Psychological Measurement*,
37(4), 304-315.

Masters, G. N. (1982). A Rasch model for partial credit scoring.
*Psychometrika*, 47(2), 149-174.

Muraki, E. (1990). Fitting a polytomous item response model to
Likert-type data. *Applied Psychological Measurement*, 14(1), 59-71.

Muraki, E. (1992). A generalized partial credit model: Application of an
EM algorithm. *Applied Psychological Measurement*, 16(2), 159-176.

## Examples

``` r
if (interactive()) run_app()

# on a fixed port
if (interactive()) run_app(options = list(port = 8080))
```
