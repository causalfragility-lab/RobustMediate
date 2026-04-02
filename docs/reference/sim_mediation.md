# Simulated Mediation Study Data

A synthetic dataset mimicking a clustered education study with a
continuous treatment (tutoring hours), a continuous mediator (mid-year
test score), and a continuous outcome (end-of-year test score). Designed
to illustrate **RobustMediate** with realistic effect sizes and
non-trivial confounding.

## Usage

``` r
sim_mediation
```

## Format

A data frame with 600 rows (30 schools x 20 students) and 7 columns:

- school:

  Factor. School identifier (30 levels). Use as `cluster_var`.

- Y:

  Numeric. End-of-year test score (outcome).

- X:

  Numeric. Tutoring hours received (continuous treatment, \>= 0).

- M:

  Numeric. Mid-year test score (mediator).

- Z1:

  Numeric. Prior achievement (continuous covariate).

- Z2:

  Integer (0/1). Free-lunch status (binary covariate).

- Z3:

  Numeric. Parental education index (continuous covariate).

## Source

Generated via `data-raw/generate_sim_data.R`. See that script for the
full data-generating process.

## True parameter targets

The data-generating process sets:

- **NDE** (X → Y direct path) ~= **0.25**

- **NIE** (X → M → Y path) ~= **0.35**

- **TE** ~= **0.60**

- **% mediated** ~= **58%**

Use these as a ground truth to assess estimation accuracy.

## Examples

``` r
data(sim_mediation)
str(sim_mediation)
#> 'data.frame':    600 obs. of  7 variables:
#>  $ school: Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ Y     : num  44.7 38.8 39.9 51.5 43.7 ...
#>  $ X     : num  0.985 3.496 0.768 3.077 2.287 ...
#>  $ M     : num  51.5 49.5 48.9 50 51.6 ...
#>  $ Z1    : num  -1.227 -0.521 -0.705 0.687 0.548 ...
#>  $ Z2    : int  0 0 0 1 1 0 1 0 1 0 ...
#>  $ Z3    : num  -1.308 0.649 -0.541 -0.989 0.742 ...
summary(sim_mediation[, c("Y","X","M")])
#>        Y               X                M        
#>  Min.   :35.24   Min.   :0.0000   Min.   :42.60  
#>  1st Qu.:43.51   1st Qu.:0.9252   1st Qu.:49.04  
#>  Median :45.74   Median :1.7762   Median :50.97  
#>  Mean   :45.96   Mean   :1.8062   Mean   :50.86  
#>  3rd Qu.:48.48   3rd Qu.:2.5976   3rd Qu.:52.69  
#>  Max.   :55.80   Max.   :5.1739   Max.   :58.33  

if (FALSE) { # \dontrun{
fit <- robustmediate(
  treatment_formula = X ~ Z1 + Z2 + Z3,
  mediator_formula  = M ~ X + Z1 + Z2 + Z3,
  outcome_formula   = Y ~ X + M + Z1 + Z2 + Z3,
  data        = sim_mediation,
  cluster_var = "school",
  R           = 500
)
diagnose(fit)
} # }
```
