# medITCV Robustness Profile: Pathway-Specific Fragility Framework

Implements the medITCV robustness profile, a formal extension of Frank's
ITCV to causal mediation. Computes pathway-specific fragility
thresholds, applies the minimum robustness principle, and identifies the
bottleneck pathway that governs indirect-effect fragility.

## Usage

``` r
sensitivity_meditcv_profile(
  x,
  alpha = 0.05,
  delta_grid = seq(0, 0.5, by = 0.01)
)
```

## Arguments

- x:

  A `robmedfit` object.

- alpha:

  Significance level. Default `0.05`.

- delta_grid:

  Numeric vector of confounding impact values over which the robustness
  profile is evaluated. Default `seq(0, 0.5, by = 0.01)`.

## Value

An object of class `"meditcv_profile"`: a named list with elements
`a_path`, `b_path`, `meditcv_indirect`, `bottleneck`,
`robustness_profile`, `fragility_ratio`, `meditcv_detail`, and `alpha`.

## References

Frank, K. A. (2000). Impact of a confounding variable on a regression
coefficient. *Sociological Methods & Research*, 29(2), 147–194.

## See also

[`sensitivity_meditcv()`](https://causalfragility-lab.github.io/RobustMediate/reference/sensitivity_meditcv.md),
[`plot_meditcv_profile()`](https://causalfragility-lab.github.io/RobustMediate/reference/plot_meditcv_profile.md),
[`sensitivity_curvature()`](https://causalfragility-lab.github.io/RobustMediate/reference/sensitivity_curvature.md)

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
print(mp)
#> ╔══════════════════════════════════════════════════════════════╗
#> ║      medITCV: Mediation Pathway Fragility Framework        ║
#> ╚══════════════════════════════════════════════════════════════╝
#> 
#> ── Minimum Robustness Principle ──────────────────────────────────
#>   medITCV (a-path):        0.1197
#>   medITCV (b-path):        0.4248
#>   medITCV (indirect):      0.1197   [= min(a, b)]
#>   Fragility ratio (a/b):   0.282
#>   → Strong asymmetry: a-path is the clear bottleneck. 
#> 
#> ── Bottleneck Pathway ────────────────────────────────────────────
#>   a-path (X → M)
#>   Robustness of the indirect effect is bounded by this pathway.
#>   Collect additional covariates / run balance checks here first.
#> 
#> ── Path Detail ───────────────────────────────────────────────────
#>   a-path: r_obs = +0.1998  r_crit = 0.0802  medITCV = 0.1197  (robust)
#>   b-path: r_obs = +0.5051  r_crit = 0.0803  medITCV = 0.4248  (robust)
#> 
#> ── Tipping-Point Confounders ─────────────────────────────────────
#>   a-path: a confounder correlated r = 0.346 with BOTH predictor and outcome
#>        would be sufficient to invalidate this pathway.
#>   b-path: a confounder correlated r = 0.652 with BOTH predictor and outcome
#>        would be sufficient to invalidate this pathway.
#> 
#> ── Publishable Language ──────────────────────────────────────────
#>   "Extending ITCV to mediation reveals that robustness is not
#>    uniform but pathway-specific (medITCV_a = 0.120, medITCV_b = 0.425),
#>    with the a-path (X → M) determining overall indirect-effect
#>    fragility (medITCV_indirect = 0.120). A confounding impact exceeding
#>    this threshold would be sufficient to nullify the indirect effect,
#>    regardless of how robust the complementary pathway is."
#> ────────────────────────────────────────────────────────────────
plot_meditcv_profile(mp)

# }
```
