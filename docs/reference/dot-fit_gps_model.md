# Fit a natural-spline treatment model and return the GPS model object

Fit a natural-spline treatment model and return the GPS model object

## Usage

``` r
.fit_gps_model(treatment_formula, data, df = 4, family = stats::gaussian())
```

## Arguments

- treatment_formula:

  Original treatment formula (e.g., `X ~ Z1 + Z2`).

- data:

  Data frame.

- df:

  Degrees of freedom for
  [`splines::ns()`](https://rdrr.io/r/splines/ns.html). Default 4.

- family:

  GLM family. Default
  [`gaussian()`](https://rdrr.io/r/stats/family.html).

## Value

A fitted `glm` object with a spline basis for the intercept term
replaced by `ns(X, df)` on the *response* side — i.e. the model
`X_spline ~ Z` where `X_spline` is the ns-expanded treatment. In
practice we use the approach: model X \| Z with a Gaussian GLM using the
raw X, then use the **residual SD** from that model to form GPS
densities. The spline enters on the *covariate* side of mediator/outcome
models for the dose-response curve.
