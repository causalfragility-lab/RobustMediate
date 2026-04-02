# RobustMediate <img src="man/figures/logo.png" align="right" height="139" alt="" />

> Robust causal mediation analysis with embedded diagnostics, dose-response
> curves, and a novel bivariate sensitivity contour.

<!-- badges: start -->
[![R-CMD-check](https://github.com/yourname/RobustMediate/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/yourname/RobustMediate/actions)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## What it does

| Function | What it gives you |
|---|---|
| `robustmediate()` | Fit treatment / mediator / outcome models, compute IPW weights, NDE/NIE/TE curves (bootstrap CIs), and the sensitivity surface — all in one call |
| `plot_balance()` | Dual love plot: covariate balance before/after weighting for **both** pathways simultaneously |
| `plot_mediation()` | Dose-response curves of NDE, NIE, TE with pointwise confidence bands |
| `plot_sensitivity()` | **Novel** 2-D robustness map: E-value × Imai ρ — does not exist elsewhere in R |
| `diagnose()` | Formatted report with a paste-ready Results paragraph |

## Installation

```r
# Development version from GitHub
# install.packages("pak")
pak::pkg_install("yourname/RobustMediate")
```

## Quick start

```r
library(RobustMediate)

fit <- robustmediate(
  treatment_formula = X ~ Z1 + Z2,
  mediator_formula  = M ~ X + Z1 + Z2,
  outcome_formula   = Y ~ X + M + Z1 + Z2,
  data = mydata,
  R    = 500
)

plot_balance(fit)      # love plot  — reviewers require this
plot_mediation(fit)    # NDE / NIE dose-response curve
plot_sensitivity(fit)  # novel E-value × rho contour
diagnose(fit)          # paste into Results section
```

## Why this package?

**VanderWeele's `EValue`** plots E-values.  
**Imai's `mediation`** plots rho sensitivity.  
**`cobalt` / `WeightIt`** do love plots — but only for the treatment model.  

**RobustMediate** combines all three into one coherent workflow tailored to
continuous-treatment mediation, and adds the joint E-value × ρ contour that
exists nowhere else.

## Contributing

Bug reports and feature requests via [GitHub Issues](https://github.com/yourname/RobustMediate/issues).

## License

MIT © Your Name
