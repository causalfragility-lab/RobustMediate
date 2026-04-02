# Compare Two robmedfit Objects Side by Side

Overlays the NDE/NIE/TE curves from two `robmedfit` objects on the same
panel. Useful for sensitivity comparisons (e.g. different spline
degrees, trimming thresholds, or model specifications).

## Usage

``` r
compare_fits(
  fit1,
  fit2,
  label1 = "Model 1",
  label2 = "Model 2",
  estimands = c("NDE", "NIE")
)
```

## Arguments

- fit1:

  First `robmedfit` object.

- fit2:

  Second `robmedfit` object.

- label1:

  Label for `fit1`. Default `"Model 1"`.

- label2:

  Label for `fit2`. Default `"Model 2"`.

- estimands:

  Estimands to display. Default `c("NDE","NIE")`.

## Value

A `ggplot2` object.

## Examples

``` r
if (FALSE) { # \dontrun{
fit_a <- robustmediate(X~Z, M~X+Z, Y~X+M+Z, data=dat, spline_df=3, R=200)
fit_b <- robustmediate(X~Z, M~X+Z, Y~X+M+Z, data=dat, spline_df=6, R=200)
compare_fits(fit_a, fit_b, label1="df=3", label2="df=6")
} # }
```
