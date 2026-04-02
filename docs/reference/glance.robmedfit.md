# Glance at a robmedfit object (broom-compatible)

Returns a one-row summary of the fit: sample size, bootstrap reps,
reference dose, percentage mediated, and the two tipping-point
sensitivity values.

## Usage

``` r
glance.robmedfit(x, ...)
```

## Arguments

- x:

  A `robmedfit` object.

- ...:

  Ignored.

## Value

A one-row data frame.

## Examples

``` r
if (FALSE) { # \dontrun{
fit <- robustmediate(X ~ Z, M ~ X + Z, Y ~ X + M + Z, data = dat)
glance(fit)
} # }
```
