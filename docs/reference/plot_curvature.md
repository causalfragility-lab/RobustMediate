# Plot Dose-Varying Fragility (Curvature-Based Sensitivity)

Three-panel visualisation of dose-varying fragility: (1) effect curve
with CI bands and fragility zones, (2) local fragility index, (3)
normalised curvature.

## Usage

``` r
plot_curvature(x, estimand = "NIE", ref_dose = NULL, ...)
```

## Arguments

- x:

  Data frame from
  [`sensitivity_curvature()`](https://causalfragility-lab.github.io/RobustMediate/reference/sensitivity_curvature.md).

- estimand:

  Label for the estimand. Default `"NIE"`.

- ref_dose:

  Optional reference dose vertical line.

- ...:

  Ignored.

## Value

A `ggplot2` object.

## Examples

``` r
# \donttest{
data(sim_mediation)
  fit <- robustmediate(
    X ~ Z1 + Z2, M ~ X + Z1 + Z2, Y ~ X + M + Z1 + Z2,
    data = sim_mediation, R = 20, verbose = FALSE
  )
#> Warning: `R < 50`; bootstrap intervals may be unstable.
curv <- sensitivity_curvature(fit)
plot_curvature(curv, ref_dose = fit$meta$ref_dose)

# }
```
