# Pathway Fragility Decomposition Table

Returns a publication-ready table decomposing indirect-effect robustness
into pathway-specific components. Columns follow the medITCV reporting
convention: pathway, coefficient, SE, t, df, observed partial r,
critical r, medITCV, medITCV%, fragility classification, and
tipping-point confounder r.

## Usage

``` r
fragility_table(x, alpha = 0.05)
```

## Arguments

- x:

  A `robmedfit` object.

- alpha:

  Significance level. Default `0.05`.

## Value

A data frame with three rows (a-path, b-path, indirect effect) and
columns `pathway`, `coefficient`, `SE`, `t_stat`, `df`, `r_obs`,
`r_crit`, `medITCV`, `medITCV_pct`, `fragility`, `tipping_r_confounder`,
and `bottleneck`.

## Examples

``` r
# \donttest{
data(sim_mediation)
  fit <- robustmediate(
    X ~ Z1 + Z2, M ~ X + Z1 + Z2, Y ~ X + M + Z1 + Z2,
    data = sim_mediation, R = 20, verbose = FALSE
  )
#> Warning: `R < 50`; bootstrap intervals may be unstable.
fragility_table(fit)
#>          pathway coefficient     SE t_stat  df  r_obs r_crit medITCV
#> X   a-path (X→M)      0.5195 0.1043  4.979 596 0.1998 0.0802  0.1197
#> M b-path (M→Y|X)      0.7165 0.0502 14.275 595 0.5051 0.0803  0.4248
#>   Indirect (a×b)          NA     NA     NA  NA     NA     NA  0.1197
#>   medITCV_pct     fragility tipping_r_confounder bottleneck
#> X        13.0        Robust               0.3459       TRUE
#> M        46.2 Highly robust               0.6518      FALSE
#>            NA        Robust               0.3459       TRUE
# }
```
