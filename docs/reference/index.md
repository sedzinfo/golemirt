# Package index

## App

- [`run_app()`](https://sedzinfo.github.io/golemirt/reference/run_app.md)
  : Explore IRT models and how their parameters are estimated

## Models

Response functions of the models in the Models menu

- [`prob_4pl()`](https://sedzinfo.github.io/golemirt/reference/prob_4pl.md)
  : Four-parameter logistic item response function
- [`prob_gpcm()`](https://sedzinfo.github.io/golemirt/reference/prob_gpcm.md)
  : Category response curves of the generalized partial credit model
- [`prob_grsm()`](https://sedzinfo.github.io/golemirt/reference/prob_grsm.md)
  : Category response curves of the generalized rating scale model
- [`prob_grm()`](https://sedzinfo.github.io/golemirt/reference/prob_grm.md)
  : Category response curves of the graded response model
- [`prob_nrm()`](https://sedzinfo.github.io/golemirt/reference/prob_nrm.md)
  : Category response curves of the nominal response model
- [`prob_tirt()`](https://sedzinfo.github.io/golemirt/reference/prob_tirt.md)
  [`prob_tirt_pair()`](https://sedzinfo.github.io/golemirt/reference/prob_tirt.md)
  [`prob_tirt_intercept()`](https://sedzinfo.github.io/golemirt/reference/prob_tirt.md)
  : Probit response functions of Thurstonian IRT
- [`prob_mirt()`](https://sedzinfo.github.io/golemirt/reference/prob_mirt.md)
  : Response surface of a two-dimensional dichotomous item
- [`info_mirt()`](https://sedzinfo.github.io/golemirt/reference/info_mirt.md)
  : Information surface of a two-dimensional dichotomous item
- [`item_vector()`](https://sedzinfo.github.io/golemirt/reference/item_vector.md)
  : Item vector of a compensatory two-dimensional item

## Estimation

The estimation methods of the Estimation menu

- [`response_pattern()`](https://sedzinfo.github.io/golemirt/reference/response_pattern.md)
  : Response pattern of a raw score
- [`simulate_responses()`](https://sedzinfo.github.io/golemirt/reference/simulate_responses.md)
  : Simulate dichotomous responses
- [`loglik_surface()`](https://sedzinfo.github.io/golemirt/reference/loglik_surface.md)
  : Log-likelihood surface of an item's discrimination and difficulty
- [`surface_maximum()`](https://sedzinfo.github.io/golemirt/reference/surface_maximum.md)
  : Highest point of a log-likelihood surface
- [`loglik_rasch()`](https://sedzinfo.github.io/golemirt/reference/loglik_rasch.md)
  : Log-likelihood of a response pattern under the Rasch model
- [`newton_raphson_rasch()`](https://sedzinfo.github.io/golemirt/reference/newton_raphson_rasch.md)
  : Newton-Raphson steps towards the maximum likelihood estimate of
  ability
- [`prior_weights()`](https://sedzinfo.github.io/golemirt/reference/prior_weights.md)
  : Prior weights at quadrature points
- [`eap_map()`](https://sedzinfo.github.io/golemirt/reference/eap_map.md)
  : EAP and MAP estimates of ability by quadrature

## Adaptive testing

The CAT tab: questionnaires as csv files and the adaptive test session

- [`irt_models()`](https://sedzinfo.github.io/golemirt/reference/irt_models.md)
  : The IRT models
- [`read_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md)
  : Read a questionnaire
- [`questionnaire_from_mirt()`](https://sedzinfo.github.io/golemirt/reference/questionnaire_from_mirt.md)
  : A questionnaire table from a mirt model
- [`write_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/write_questionnaire.md)
  : Save a questionnaire table
- [`validate_questionnaire_against_mirt()`](https://sedzinfo.github.io/golemirt/reference/validate_questionnaire_against_mirt.md)
  : Check a questionnaire against its mirt model
- [`example_questionnaires()`](https://sedzinfo.github.io/golemirt/reference/example_questionnaires.md)
  : The example questionnaires
- [`cat_start()`](https://sedzinfo.github.io/golemirt/reference/cat_start.md)
  : Start an adaptive test
- [`cat_item()`](https://sedzinfo.github.io/golemirt/reference/cat_item.md)
  : The item to show now
- [`cat_answer()`](https://sedzinfo.github.io/golemirt/reference/cat_answer.md)
  : Answer the current item
- [`cat_results()`](https://sedzinfo.github.io/golemirt/reference/cat_results.md)
  : Results of a CAT session

## Adaptive testing engines

Response probabilities, information, item selection, likelihood and EAP
of the six models, the same as catR

- [`compute_eap_dichotomous()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_dichotomous.md)
  : compute theta EAP estimation
- [`compute_eap_ggrm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_ggrm.md)
  : compute theta EAP estimation under the generalized graded response
  model
- [`compute_eap_grm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_grm.md)
  : compute theta EAP estimation under the graded response model
- [`compute_eap_nrm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_nrm.md)
  : compute theta EAP estimation under the nominal response model
- [`compute_eap_pcm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_pcm.md)
  : compute theta EAP estimation under the partial credit model
- [`compute_eap_rsm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_rsm.md)
  : compute theta EAP estimation under the rating scale model
- [`compute_eap_se_dichotomous()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_se_dichotomous.md)
  : compute standard error of theta EAP estimation
- [`compute_eap_se_ggrm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_se_ggrm.md)
  : compute standard error of theta EAP estimation under the generalized
  graded response model
- [`compute_eap_se_grm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_se_grm.md)
  : compute standard error of theta EAP estimation under the graded
  response model
- [`compute_eap_se_nrm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_se_nrm.md)
  : compute standard error of theta EAP estimation under the nominal
  response model
- [`compute_eap_se_pcm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_se_pcm.md)
  : compute standard error of theta EAP estimation under the partial
  credit model
- [`compute_eap_se_rsm()`](https://sedzinfo.github.io/golemirt/reference/compute_eap_se_rsm.md)
  : compute standard error of theta EAP estimation under the rating
  scale model
- [`compute_ii_dichotomous()`](https://sedzinfo.github.io/golemirt/reference/compute_ii_dichotomous.md)
  : compute item information under the 4PL model
- [`compute_ii_ggrm()`](https://sedzinfo.github.io/golemirt/reference/compute_ii_ggrm.md)
  : compute item information under the generalized graded response model
- [`compute_ii_grm()`](https://sedzinfo.github.io/golemirt/reference/compute_ii_grm.md)
  : compute item information under the graded response model
- [`compute_ii_nrm()`](https://sedzinfo.github.io/golemirt/reference/compute_ii_nrm.md)
  : compute item information under the nominal response model
- [`compute_ii_pcm()`](https://sedzinfo.github.io/golemirt/reference/compute_ii_pcm.md)
  : compute item information under the partial credit model
- [`compute_ii_rsm()`](https://sedzinfo.github.io/golemirt/reference/compute_ii_rsm.md)
  : compute item information under the rating scale model
- [`compute_likelihood_dichotomous()`](https://sedzinfo.github.io/golemirt/reference/compute_likelihood_dichotomous.md)
  : compute the likelihood of a dichotomous response pattern
- [`compute_likelihood_ggrm()`](https://sedzinfo.github.io/golemirt/reference/compute_likelihood_ggrm.md)
  : compute the likelihood of a polytomous response pattern
- [`compute_likelihood_grm()`](https://sedzinfo.github.io/golemirt/reference/compute_likelihood_grm.md)
  : compute the likelihood of a polytomous response pattern
- [`compute_likelihood_nrm()`](https://sedzinfo.github.io/golemirt/reference/compute_likelihood_nrm.md)
  : compute the likelihood of a polytomous response pattern
- [`compute_likelihood_pcm()`](https://sedzinfo.github.io/golemirt/reference/compute_likelihood_pcm.md)
  : compute the likelihood of a polytomous response pattern
- [`compute_likelihood_rsm()`](https://sedzinfo.github.io/golemirt/reference/compute_likelihood_rsm.md)
  : compute the likelihood of a polytomous response pattern
- [`compute_next_item_dichotomous()`](https://sedzinfo.github.io/golemirt/reference/compute_next_item_dichotomous.md)
  : select the next item by maximum Fisher information
- [`compute_next_item_ggrm()`](https://sedzinfo.github.io/golemirt/reference/compute_next_item_ggrm.md)
  : select the next item by maximum Fisher information
- [`compute_next_item_grm()`](https://sedzinfo.github.io/golemirt/reference/compute_next_item_grm.md)
  : select the next item by maximum Fisher information
- [`compute_next_item_nrm()`](https://sedzinfo.github.io/golemirt/reference/compute_next_item_nrm.md)
  : select the next item by maximum Fisher information
- [`compute_next_item_pcm()`](https://sedzinfo.github.io/golemirt/reference/compute_next_item_pcm.md)
  : select the next item by maximum Fisher information
- [`compute_next_item_rsm()`](https://sedzinfo.github.io/golemirt/reference/compute_next_item_rsm.md)
  : select the next item by maximum Fisher information
- [`compute_pi_dichotomous()`](https://sedzinfo.github.io/golemirt/reference/compute_pi_dichotomous.md)
  : compute response probabilities and derivatives
- [`compute_pi_ggrm()`](https://sedzinfo.github.io/golemirt/reference/compute_pi_ggrm.md)
  : compute category response probabilities and derivatives under the
  generalized graded response model
- [`compute_pi_grm()`](https://sedzinfo.github.io/golemirt/reference/compute_pi_grm.md)
  : compute category response probabilities and derivatives under the
  graded response model
- [`compute_pi_nrm()`](https://sedzinfo.github.io/golemirt/reference/compute_pi_nrm.md)
  : compute category response probabilities and derivatives under the
  nominal response model
- [`compute_pi_pcm()`](https://sedzinfo.github.io/golemirt/reference/compute_pi_pcm.md)
  : compute category response probabilities and derivatives under the
  partial credit model
- [`compute_pi_rsm()`](https://sedzinfo.github.io/golemirt/reference/compute_pi_rsm.md)
  : compute category response probabilities and derivatives under the
  rating scale model
- [`density_function()`](https://sedzinfo.github.io/golemirt/reference/density_function.md)
  : compute normal density function
- [`integrate_cat()`](https://sedzinfo.github.io/golemirt/reference/integrate_cat.md)
  : compute integral of f(x)

## Plots

The plots of the app

- [`plot_category_curves()`](https://sedzinfo.github.io/golemirt/reference/plot_category_curves.md)
  : Plot category response curves
- [`plot_tirt()`](https://sedzinfo.github.io/golemirt/reference/plot_tirt.md)
  : Plot a Thurstonian IRT response function
- [`plot_mirt_surface()`](https://sedzinfo.github.io/golemirt/reference/plot_mirt_surface.md)
  : Plot a surface over the ability plane
- [`plot_mirt_contour()`](https://sedzinfo.github.io/golemirt/reference/plot_mirt_contour.md)
  : Plot the contours of a two-dimensional item
- [`plot_newton_raphson()`](https://sedzinfo.github.io/golemirt/reference/plot_newton_raphson.md)
  : Plot a Newton-Raphson step
- [`plot_loglik_surface()`](https://sedzinfo.github.io/golemirt/reference/plot_loglik_surface.md)
  : Plot a log-likelihood surface
- [`plot_loglik_surfaces()`](https://sedzinfo.github.io/golemirt/reference/plot_loglik_surfaces.md)
  : Plot log-likelihood surfaces for several lower asymptotes
- [`plot_prior()`](https://sedzinfo.github.io/golemirt/reference/plot_prior.md)
  [`plot_tracelines()`](https://sedzinfo.github.io/golemirt/reference/plot_prior.md)
  [`plot_likelihood()`](https://sedzinfo.github.io/golemirt/reference/plot_prior.md)
  [`plot_posterior()`](https://sedzinfo.github.io/golemirt/reference/plot_prior.md)
  [`plot_eap_combined()`](https://sedzinfo.github.io/golemirt/reference/plot_prior.md)
  : Plot the parts of an EAP and MAP estimation
- [`plot_cat_trajectory()`](https://sedzinfo.github.io/golemirt/reference/plot_cat_trajectory.md)
  : Plot the course of a CAT session

## UI

Internal functions not meant to run independently

## Server

Internal functions not meant to run independently
