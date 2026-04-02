## ── setup.R ──────────────────────────────────────────────────────────────────
## Run this file ONCE after unzipping, from inside the RobustMediate/ folder.
## In RStudio: open RobustMediate.Rproj, then run this script.
##
## Step 0: install dependencies if needed
pkgs <- c("devtools", "usethis", "ggplot2", "dplyr", "tidyr",
          "rlang", "cli", "scales", "splines", "testthat")
missing <- pkgs[!pkgs %in% rownames(installed.packages())]
if (length(missing)) install.packages(missing)

## Step 1: generate the bundled dataset (creates data/sim_mediation.rda)
source("data-raw/generate_sim_data.R")

## Step 2: document (generates man/ pages and updates NAMESPACE)
devtools::document()

## Step 3: load the package in-place
devtools::load_all(".")   # <-- always "." when you are already inside the folder

## Step 4: smoke test
data(sim_mediation)
fit <- robustmediate(
  treatment_formula = X ~ Z1 + Z2 + Z3,
  mediator_formula  = M ~ X + Z1 + Z2 + Z3,
  outcome_formula   = Y ~ X + M + Z1 + Z2 + Z3,
  data = sim_mediation,
  R    = 100,      # use 500 in real analyses
  verbose = TRUE
)
print(fit)
diagnose(fit)
plot(fit)                      # dose-response curve
plot(fit, type = "balance")    # love plot
plot(fit, type = "sensitivity") # contour

## Step 5: run tests
devtools::test()
