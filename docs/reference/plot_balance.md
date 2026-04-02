# Love Plot: Balance Diagnostics for Both Pathways

Produces a publication-ready love plot showing standardised mean
differences (SMDs) before and after IPW weighting for **both** the
treatment and mediator pathways — stacked vertically in a single panel.
This dual-pathway display is unique to **RobustMediate**; no other
mediation package provides it.

## Usage

``` r
plot_balance(x, threshold = 0.1, pathways = c("treatment", "mediator"), ...)
```

## Arguments

- x:

  A `robmedfit` object.

- threshold:

  Absolute SMD threshold displayed as dashed reference lines. Reviewers
  conventionally accept \|SMD\| \< 0.10. Default `0.1`.

- pathways:

  Character vector indicating which pathways to show. Options:
  `"treatment"`, `"mediator"`, or both (default).

- ...:

  Ignored (for S3 consistency).

## Value

A `ggplot2` object. Add layers or themes as usual.

## Examples

``` r
if (FALSE) { # \dontrun{
fit <- robustmediate(X ~ Z, M ~ X + Z, Y ~ X + M + Z, data = mydata)
plot_balance(fit)
plot_balance(fit, threshold = 0.05, pathways = "treatment")
} # }
```
