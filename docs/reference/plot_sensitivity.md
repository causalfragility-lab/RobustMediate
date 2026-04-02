# Sensitivity Contour Plot: Joint E-value x Rho Display

Renders the novel bivariate robustness map unique to **RobustMediate**:
a 2-D heatmap where the x-axis is the E-value (VanderWeele-style
unmeasured treatment–outcome confounding) and the y-axis is Imai's
sequential-ignorability violation parameter rho. Contour lines show
where the mediation effect crosses zero, so readers can judge robustness
to **two different** sensitivity dimensions simultaneously.

This visualisation does not exist elsewhere in the R ecosystem. The
correct interpretation is as a *bivariate robustness display*, not a
joint causal model — see the package paper for theoretical
justification.

## Usage

``` r
plot_sensitivity(
  x,
  annotate_zero = TRUE,
  n_breaks = 12,
  palette = "RdYlGn",
  ...
)
```

## Arguments

- x:

  A `robmedfit` object.

- annotate_zero:

  Logical. Draw a bold dashed zero-crossing contour? Default `TRUE`.
  Highly recommended for applied papers.

- n_breaks:

  Number of fill colour breaks in the heatmap. Default `12`.

- palette:

  RColorBrewer palette name. Default `"RdYlGn"`.

- ...:

  Ignored.

## Value

A `ggplot2` object.

## Examples

``` r
if (FALSE) { # \dontrun{
fit <- robustmediate(X ~ Z, M ~ X + Z, Y ~ X + M + Z, data = mydata)
plot_sensitivity(fit)
plot_sensitivity(fit, annotate_zero = FALSE, palette = "PuOr")
} # }
```
