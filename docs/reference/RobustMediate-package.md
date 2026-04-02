# RobustMediate: Causal Mediation Analysis with Diagnostics and Sensitivity Analysis

**RobustMediate** provides a workflow for causal mediation analysis with
continuous treatments using inverse probability weighting (IPW),
diagnostic tools, and sensitivity analysis.

Main functions include:

- **[`robustmediate()`](https://causalfragility-lab.github.io/RobustMediate/reference/robustmediate.md)** -
  Fits treatment, mediator, and outcome models and stores precomputed
  results for downstream plotting and reporting.

- **[`plot_balance()`](https://causalfragility-lab.github.io/RobustMediate/reference/plot_balance.md)** -
  Displays covariate balance before and after weighting for both the
  treatment and mediator pathways using standardized mean differences.

- **[`plot_mediation()`](https://causalfragility-lab.github.io/RobustMediate/reference/plot_mediation.md)** -
  Plots estimated natural direct effects (NDE) and natural indirect
  effects (NIE) over the treatment range, with pointwise uncertainty
  bands.

- **[`plot_sensitivity()`](https://causalfragility-lab.github.io/RobustMediate/reference/plot_sensitivity.md)** -
  Displays a bivariate sensitivity surface based on E-values and
  sequential ignorability violations parameterized by `rho`.

- **[`sensitivity_meditcv()`](https://causalfragility-lab.github.io/RobustMediate/reference/sensitivity_meditcv.md)** -
  Computes pathway-specific mediation ITCV (`medITCV`) diagnostics based
  on Frank's impact threshold for a confounding variable framework.

- **[`plot_meditcv()`](https://causalfragility-lab.github.io/RobustMediate/reference/plot_meditcv.md)** -
  Displays pathway-specific medITCV robustness corridors for the a-path
  and b-path.

- **[`diagnose()`](https://causalfragility-lab.github.io/RobustMediate/reference/diagnose.md)** -
  Produces a formatted diagnostic summary of balance, mediation effects,
  and sensitivity results.

## Getting started

    library(RobustMediate)

    data(sim_mediation)

    fit <- robustmediate(
      X ~ Z1 + Z2 + Z3,
      M ~ X + Z1 + Z2 + Z3,
      Y ~ X + M + Z1 + Z2 + Z3,
      data = sim_mediation,
      R = 500
    )

    plot(fit)
    plot(fit, type = "balance")
    plot(fit, type = "sensitivity")
    plot(fit, type = "meditcv")
    diagnose(fit)

## Sensitivity interpretation

The E-value x `rho` surface is a bivariate robustness display rather
than a single unified causal model. It is intended to help users examine
how large different classes of unmeasured confounding would need to be
to attenuate or nullify the estimated indirect effect.

The mediation ITCV (`medITCV`) is reported separately for the a-path and
b-path. The indirect-effect summary is interpreted as a minimum-path
robustness bound governed by the weaker pathway.

## References

Frank, K. A. (2000). Impact of a confounding variable on a regression
coefficient. *Sociological Methods & Research*, 29(2), 147–194.

Imai, K., Keele, L., & Yamamoto, T. (2010). Identification, inference,
and sensitivity analysis for causal mediation effects. *Psychological
Methods*, 15(4), 309–334.

VanderWeele, T. J., & Ding, P. (2017). Sensitivity analysis in
observational research: Introducing the E-value. *Annals of Internal
Medicine*, 167(4), 268–274.

## See also

Useful links:

- <https://causalfragility-lab.github.io/RobustMediate>

- <https://github.com/causalfragility-lab/RobustMediate>

- Report bugs at
  <https://github.com/causalfragility-lab/RobustMediate/issues>

## Author

**Maintainer**: Subir Hait <haitsubi@msu.edu>
([ORCID](https://orcid.org/0009-0004-9871-9677))
