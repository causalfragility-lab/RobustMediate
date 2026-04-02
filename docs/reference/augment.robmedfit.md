# Augment data with fitted values from a robmedfit object (broom-compatible)

Returns the original data augmented with IPW weights, fitted mediator
values, and fitted outcome values from the pathway models.

## Usage

``` r
augment.robmedfit(x, data = NULL, ...)
```

## Arguments

- x:

  A `robmedfit` object.

- data:

  Optional data frame to augment. Defaults to the data stored in the
  outcome model's `$data` slot.

- ...:

  Ignored.

## Value

The original data frame with additional columns:

- `.ipw_weight`:

  Stabilised inverse probability weights.

- `.fitted_mediator`:

  Predicted mediator values.

- `.fitted_outcome`:

  Predicted outcome values.

- `.resid_mediator`:

  Residuals from the mediator model.

- `.resid_outcome`:

  Residuals from the outcome model.

## Examples

``` r
if (FALSE) { # \dontrun{
fit <- robustmediate(X ~ Z, M ~ X + Z, Y ~ X + M + Z, data = dat)
aug <- augment(fit)
hist(aug$.ipw_weight)
} # }
```
