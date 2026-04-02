# Plot the medITCV Robustness Profile

Visualises how each pathway's partial correlation is attenuated as
confounding impact delta increases, with tipping points and a fragility
zone marked.

## Usage

``` r
plot_meditcv_profile(x, ...)
```

## Arguments

- x:

  A `meditcv_profile` object from
  [`sensitivity_meditcv_profile()`](https://causalfragility-lab.github.io/RobustMediate/reference/sensitivity_meditcv_profile.md).

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
mp  <- sensitivity_meditcv_profile(fit)
plot_meditcv_profile(mp)

# }
```
