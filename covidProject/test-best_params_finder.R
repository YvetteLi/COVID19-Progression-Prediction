# source('/Users/yufuli/Documents/4B/STAT440/final_proj/meas_process.R')

require(Rcpp)
require(MCMCpack)
require(BDAepimodel)

ntest <- 3
tol <- 0.1
max_err <- rep(NA, ntest)

test_that("The estimated parameters will converge to the original values", {
  
  for (i in 1:ntest){
    set.seed(52787)
    epimodel_orig <- init_epimodel(obstimes = seq(0, 105, by = 7),                             # vector of observation times
                                   popsize = 750,                                              # population size
                                   states = c("S", "I", "R"),                                  # compartment names
                                   params = c(beta = 0.00035,                                  # infectivity parameter
                                              mu = 1/7,                                        # recovery rate
                                              rho = 0.2,                                       # binomial sampling probability
                                              S0 = 0.9, I0 = 0.03, R0 = 0.07),                 # initial state probabilities
                                   rates = c("beta * I", "mu"),                                # unlumped transition rates
                                   flow = matrix(c(-1, 1, 0, 0, -1, 1), ncol = 3, byrow = T),  # flow matrix
                                   meas_vars = "I",                                            # name of measurement variable
                                   r_meas_process = r_meas_process,                            # measurement process functions
                                   d_meas_process = d_meas_process)
    epimodel_orig <- simulate_epimodel(epimodel = epimodel_orig, lump = TRUE, trim = TRUE)
    
    initial_params <- list(beta=0.00035, mu=1/7, rho=0.2)
    
    epimodel <- best_parmas_finder(initial_params,
                                   dat=epimodel_orig$dat,
                                   thres=4e-6, pop_size=750, niter=100, suppress_img=TRUE )
    
    est_params = apply(epimodel$results$params, 2, get_avg)
    orig_parms = epimodel_orig$params
    
    diff_params =  abs(est_params-orig_parms)
    diff_beta = diff_params["beta"]
    diff_mu = diff_params["mu"]
    diff_rho = diff_params["rho"]
    
    max_err[i] = mean(c(diff_beta, diff_mu, diff_rho))
    
  }
  
  res = max_err < tol
  expect_equal(res, c(TRUE, TRUE, TRUE))
  
})






