# Robust Causal Mediation Analysis

Fits treatment, mediator, and outcome models for causal mediation
analysis with continuous treatments using inverse probability weighting
(IPW), and returns a precomputed `robmedfit` object for plotting and
diagnostics.

## Usage

``` r
robustmediate(
  treatment_formula,
  mediator_formula,
  outcome_formula,
  data,
  ref_dose = NULL,
  dose_grid = NULL,
  R = 500,
  alpha = 0.05,
  covariates = NULL,
  cluster_var = NULL,
  family_treatment = stats::gaussian(),
  family_mediator = stats::gaussian(),
  family_outcome = stats::gaussian(),
  spline_df = 4,
  evalue_seq = seq(1, 10, by = 0.25),
  rho_seq = seq(-1, 1, by = 0.05),
  verbose = TRUE
)
```

## Arguments

- treatment_formula:

  Formula for the treatment model (for example, `X ~ Z1 + Z2`).

- mediator_formula:

  Formula for the mediator model (for example, `M ~ X + Z1 + Z2`).

- outcome_formula:

  Formula for the outcome model (for example, `Y ~ X + M + Z1 + Z2`).

- data:

  A data frame containing all analysis variables.

- ref_dose:

  Reference dose value. Defaults to the sample mean of the treatment
  variable.

- dose_grid:

  Numeric vector of dose values over which NDE, NIE, and TE are
  evaluated. Defaults to 100 evenly spaced points across the observed
  treatment range.

- R:

  Number of bootstrap replicates. Default is `500`.

- alpha:

  Significance level. Default is `0.05`.

- covariates:

  Covariate names for balance diagnostics. If `NULL`, covariates are
  inferred from the treatment formula.

- cluster_var:

  Optional clustering variable name. `NULL` assumes independent
  observations.

- family_treatment:

  GLM family for the treatment model. Default is
  [`stats::gaussian()`](https://rdrr.io/r/stats/family.html).

- family_mediator:

  GLM family for the mediator model. Default is
  [`stats::gaussian()`](https://rdrr.io/r/stats/family.html).

- family_outcome:

  GLM family for the outcome model. Default is
  [`stats::gaussian()`](https://rdrr.io/r/stats/family.html).

- spline_df:

  Degrees of freedom for spline-based effect summaries. Default is `4`.

- evalue_seq:

  Sequence of E-values used to build the sensitivity surface. Default is
  `seq(1, 10, by = 0.25)`.

- rho_seq:

  Sequence of `rho` values used to build the sensitivity surface.
  Default is `seq(-1, 1, by = 0.05)`.

- verbose:

  Logical; if `TRUE`, display progress messages.

## Value

An object of class `"robmedfit"` containing:

- `models`:

  Fitted treatment, mediator, and outcome models.

- `balance`:

  Balance statistics before and after weighting.

- `effects`:

  Dose-response summaries for NDE, NIE, and TE, including bootstrap
  intervals.

- `sensitivity`:

  Bivariate E-value and `rho` sensitivity surface.

- `meditcv`:

  Pathway-specific medITCV object from
  [`sensitivity_meditcv()`](https://causalfragility-lab.github.io/RobustMediate/reference/sensitivity_meditcv.md).

- `meditcv_profile`:

  medITCV robustness profile from
  [`sensitivity_meditcv_profile()`](https://causalfragility-lab.github.io/RobustMediate/reference/sensitivity_meditcv_profile.md).

- `cluster`:

  Cluster information, or `NULL` if clustering was not used.

- `meta`:

  Call, variable names, dose settings, bootstrap settings, and sample
  information.

## Examples

``` r
set.seed(42)
n <- 400
Z1 <- rnorm(n)
Z2 <- rbinom(n, 1, 0.5)
X  <- 0.5 * Z1 + 0.3 * Z2 + rnorm(n)
M  <- 0.4 * X + 0.2 * Z1 + rnorm(n)
Y  <- 0.3 * X + 0.5 * M + 0.1 * Z1 + rnorm(n)
dat <- data.frame(Y, X, M, Z1, Z2)

fit <- robustmediate(
  treatment_formula = X ~ Z1 + Z2,
  mediator_formula = M ~ X + Z1 + Z2,
  outcome_formula = Y ~ X + M + Z1 + Z2,
  data = dat,
  R = 100
)
#> ℹ Fitting pathway models...
#> ℹ Computing IPW weights and balance statistics...
#> ℹ Estimating NDE, NIE, and TE over dose grid (R = 100 bootstrap replicates)...
#> ℹ Building sensitivity surface (37 x 41 grid)...
#> ℹ Computing medITCV for both pathways...
#> ℹ Computing medITCV robustness profile...
#> ✔ RobustMediate fit complete. Use print(), diagnose(), or plot() to explore results.

print(fit)
#> -- RobustMediate fit ------------------------------------------
#>   Treatment: X  |  Mediator: M  |  Outcome: Y
#>   N = 400  |  Ref dose = 0.109  |  Bootstrap reps = 100
#> 
#>   Effects at focal dose (1.972 vs ref 0.109):
#>     NDE   0.6266  [NA, NA]
#>     NIE   0.4390  [NA, NA]
#>     TE    1.0656  [NA, NA]
#>     % mediated: 41.2%
#> 
#>   Balance (max |SMD| after weighting):
#>     Treatment pathway: 0.040  (0 covariate(s) above 0.10)
#>     Mediator pathway:  0.112  (1 covariate(s) above 0.10)
#> 
#>   medITCV available: yes
#>   medITCV profile available: yes
#> ---------------------------------------------------------------
```
