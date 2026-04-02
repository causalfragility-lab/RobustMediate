# Plot medITCV robustness corridors for both mediation pathways

Produces a two-panel pathway-specific robustness corridor plot showing
the observed partial correlation, critical partial correlation
threshold, medITCV corridor, and benchmark confounder impacts for each
pathway.

## Usage

``` r
plot_meditcv(x, ...)
```

## Arguments

- x:

  A `meditcv` object from
  [`sensitivity_meditcv()`](https://causalfragility-lab.github.io/RobustMediate/reference/sensitivity_meditcv.md).

- ...:

  Ignored.

## Value

A `ggplot2` object.

## Examples

``` r
# \donttest{
data(sim_mediation)
  fit <- robustmediate(
    X ~ Z1 + Z2, M ~ X + Z1 + Z2, Y ~ X + M + Z1 + Z2,
    data = sim_mediation, R = 20, verbose = FALSE
  )
#> Warning: `R < 50`; bootstrap intervals may be unstable.
med <- sensitivity_meditcv(fit)
plot_meditcv(med)

# }
```
