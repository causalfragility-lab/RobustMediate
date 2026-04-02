# Compute stabilised IPW weights from a GPS model (continuous treatment)

Implements the stabilised weight formula from Robins, Hernán & Brumback
(2000) for continuous exposures:

\$\$w_i = \frac{f(X_i \mid \bar{X}, \hat{\sigma}^2_m)}{f(X_i \mid Z_i,
\hat{\sigma}^2_c)}\$\$

where the numerator is the marginal density of X and the denominator is
the conditional density given covariates. Both are evaluated as Gaussian
PDFs using the model residual standard deviation.

Weights are trimmed at the 1st and 99th percentile to reduce the
influence of extreme propensity scores (positivity violations).

## Usage

``` r
.compute_gps_weights(gps_model, data, treat_var, trim = c(0.01, 0.99))
```

## Arguments

- gps_model:

  Fitted GPS model from
  [`.fit_gps_model()`](https://causalfragility-lab.github.io/RobustMediate/reference/dot-fit_gps_model.md).

- data:

  Original data frame.

- treat_var:

  Name of the treatment variable (character).

- trim:

  Quantile trimming bounds. Default `c(0.01, 0.99)`.

## Value

Numeric vector of stabilised, trimmed IPW weights (length = nrow(data)).

## References

Robins, J. M., Hernán, M. A., & Brumback, B. (2000). Marginal structural
models and causal inference in epidemiology. *Epidemiology*, 11(5),
550–560.

Hirano, K. & Imbens, G. W. (2004). The propensity score with continuous
treatments. In A. Gelman & X.-L. Meng (Eds.), *Applied Bayesian modeling
and causal inference from incomplete-data perspectives* (pp. 73–84).
Wiley.
