test_that("the Rasch-4PL module names the model and plots one or both probabilities", {
  testServer(mod_rasch_4pl_server, {
    session$setInputs(D = "1", a = 1, b = 0, c = 0, d = 1, probability = "2")
    expect_equal(output$feedback, "Rasch Model : a= 1  b= 0  c= 0  d= 1")
    expect_match(output$plot, "P(X=0|theta)", fixed = TRUE)
    session$setInputs(c = 0.2, probability = "1")
    expect_equal(output$feedback, "3PL Model : a= 1  b= 0  c= 0.2  d= 1")
    expect_no_match(output$plot, "P(X=0|theta)", fixed = TRUE)
  })
})

test_that("the partial credit and rating scale modules name the model and reject a zero discrimination", {
  testServer(mod_gpcm_server, {
    session$setInputs(D = "1", a = 1, step1 = -2, step2 = -0.7, step3 = 0.8, step4 = 2)
    expect_match(output$plot, "Partial Credit Model (Masters,1982)", fixed = TRUE)
    session$setInputs(D = "2", a = 2)
    expect_match(output$plot, "Generalized Partial Credit Model (Muraki,1992)", fixed = TRUE)
    session$setInputs(a = 0)
    expect_error(output$plot, "0(zero) discrimination", fixed = TRUE)
  })
  testServer(mod_grsm_server, {
    session$setInputs(D = "1", a = 1, b = 0, tau1 = -1, tau2 = -0.4, tau3 = 0.4, tau4 = 1)
    expect_match(output$plot, "Rating Scale Model (Andrich,1978)", fixed = TRUE)
    session$setInputs(a = 0)
    expect_error(output$plot, "0 (zero) discrimination", fixed = TRUE)
  })
})

test_that("the graded and nominal response modules plot five categories", {
  testServer(mod_grm_server, {
    session$setInputs(D = "1", a = 1.5, b1 = -2, b2 = -0.8, b3 = 0.8, b4 = 2)
    expect_match(output$plot, "Graded Response Model", fixed = TRUE)
    expect_match(output$plot, "P(X=5|theta)", fixed = TRUE)
  })
  testServer(mod_nrm_server, {
    session$setInputs(D = "1", a1 = -4, a2 = -2, a3 = 2, a4 = 4, b1 = -4, b2 = -2, b3 = 2, b4 = 4)
    expect_match(output$plot, "reparameterization used", fixed = TRUE)
    expect_match(output$plot, "P(X=e|theta)", fixed = TRUE)
  })
})

test_that("the TIRT module plots its three forms", {
  testServer(mod_tirt_server, {
    session$setInputs(
      gamma = 0, lambda = 0.5, range_single = 6, psi = 0.5,
      gamma_pair = 0, lambda_i = 0.5, lambda_k = 0, range_pair = 6, psi_i = 0.5, psi_k = 0.5,
      alpha = 0, beta_i = 0.5, beta_k = 0, range_intercept = 6
    )
    expect_no_error(output$plot_single)
    expect_no_error(output$plot_pair)
    expect_no_error(output$plot_intercept)
  })
})

test_that("the MIRT module plots its surfaces and contours, and rejects a zero discrimination", {
  testServer(mod_mirt_server, {
    session$setInputs(
      D = "2", compensatory = "1", b1 = 0, b2 = 0, a1 = 1, a2 = 1, c = 0, d = 1,
      name1 = "Math", name2 = "", nlevels = 10
    )
    expect_match(output$surface, "Math (\u03b81)", fixed = TRUE)
    expect_match(output$contour, "arrowcolor", fixed = TRUE)
    expect_no_error(output$information)
    session$setInputs(compensatory = "2")
    expect_no_match(output$contour, "arrowcolor", fixed = TRUE)
    session$setInputs(a1 = 0)
    expect_error(output$surface, "other than 0 (zero)", fixed = TRUE)
  })
})

test_that("the MLE Rasch module shows the last Newton-Raphson step", {
  testServer(mod_mle_rasch_server, {
    session$setInputs(score = 2, start = 0, iteration = 5)
    expect_match(output$step, "^Newton-Raphson step:\ntheta1=theta0-\\(LL' / LL''\\)\n-0\\.83")
    expect_match(output$step, "Acute angle with abscissa=0 degrees", fixed = TRUE)
    expect_no_error(output$plot)
  })
})

test_that("the MLE 2PL and 3PL modules plot log-likelihood surfaces with their maxima", {
  testServer(mod_mle_2pl_server, {
    session$setInputs(a = 1, b = -0.5)
    expect_match(output$plot, "Maximum", fixed = TRUE)
  })
  testServer(mod_mle_3pl_server, {
    session$setInputs(c = 0.4, a = 1, b = -0.5)
    expect_match(output$plot, "c=0.05", fixed = TRUE)
    expect_match(output$plot, "c=0.6", fixed = TRUE)
  })
})

test_that("the EAP-MAP module draws its five plots", {
  testServer(mod_eap_map_server, {
    session$setInputs(score = 2, quadrature = 10, mean = 0, sd = 1, skew = 1)
    expect_no_error(output$prior)
    expect_no_error(output$tracelines)
    expect_no_error(output$likelihood)
    expect_match(output$posterior, "EAP =", fixed = TRUE)
    expect_match(output$combined, "Prior Mean = 0", fixed = TRUE)
  })
})
