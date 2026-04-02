# Tidy a robmedfit object (broom-compatible)

Returns a tidy data frame of the mediation effect estimates (NDE, NIE,
TE) at the reference dose, with confidence intervals. Compatible with
[`broom::tidy()`](https://generics.r-lib.org/reference/tidy.html) and
the broader `tidymodels` ecosystem.

## Usage

``` r
tidy.robmedfit(x, conf.int = TRUE, ...)
```

## Arguments

- x:

  A `robmedfit` object.

- conf.int:

  Logical. Include confidence interval columns? Default `TRUE`.

- ...:

  Ignored.

## Value

A data frame with columns `term`, `estimate`, `conf.low`, `conf.high`,
and `ref_dose`.

## Examples

``` r
if (FALSE) { # \dontrun{
fit <- robustmediate(X ~ Z, M ~ X + Z, Y ~ X + M + Z, data = dat)
tidy(fit)
} # }
```
