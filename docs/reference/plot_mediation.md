# Dose-Response Curve: Natural Direct and Indirect Effects

Plots NDE, NIE, and (optionally) total effect as smooth spline curves
over the full range of treatment values, with pointwise bootstrap
confidence bands. This is the signature visualisation of
**RobustMediate** and is publication-ready out of the box.

## Usage

``` r
plot_mediation(
  x,
  estimands = c("NDE", "NIE"),
  show_total = FALSE,
  facet = FALSE,
  ...
)
```

## Arguments

- x:

  A `robmedfit` object.

- estimands:

  Character vector of estimands to display. Any subset of
  `c("NDE", "NIE", "TE")`. Default `c("NDE","NIE")`.

- show_total:

  Shorthand for adding `"TE"` to `estimands`. Default `FALSE`.

- facet:

  Logical. Split estimands into separate facets? Default `FALSE`.

- ...:

  Ignored.

## Value

A `ggplot2` object.

## Examples

``` r
if (FALSE) { # \dontrun{
fit <- robustmediate(X ~ Z, M ~ X + Z, Y ~ X + M + Z, data = mydata)
plot_mediation(fit)
plot_mediation(fit, estimands = c("NDE","NIE","TE"), facet = TRUE)
} # }
```
