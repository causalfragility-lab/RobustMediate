# Plot a robmedfit object

Dispatches to the appropriate plot function based on `type`.

## Usage

``` r
# S3 method for class 'robmedfit'
plot(
  x,
  type = c("mediation", "balance", "sensitivity", "meditcv", "meditcv_profile",
    "curvature"),
  ...
)
```

## Arguments

- x:

  A `robmedfit` object.

- type:

  Which plot to produce. One of:

  `"mediation"`

  :   Dose-response curve of NDE/NIE/TE (default).

  `"balance"`

  :   Dual love plot of covariate balance.

  `"sensitivity"`

  :   E-value x rho sensitivity contour.

  `"meditcv"`

  :   Pathway-specific medITCV robustness corridor.

  `"meditcv_profile"`

  :   medITCV robustness profile (fragility decomposition).

  `"curvature"`

  :   Dose-varying fragility (curvature-based sensitivity).

- ...:

  Passed to the underlying plot function.

## Value

A `ggplot2` object.
