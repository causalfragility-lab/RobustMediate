# RobustMediate (development version)

## Theoretical contributions (methods paper)

* **mITCV framework** — formalises three principles missing from existing
  mediation sensitivity literature:
  1. *Path-specific fragility*: robustness is a vector `(mITCV_a, mITCV_b)`,
     not a scalar. The a-path and b-path can have radically different thresholds.
  2. *Minimum robustness principle*: `mITCV_indirect = min(mITCV_a, mITCV_b)`.
     Proof: any confounder that nullifies either pathway nullifies the indirect
     effect. Published statement: *"Extending ITCV to mediation reveals that
     robustness is not uniform but pathway-specific, with the weakest link
     determining overall fragility."*
  3. *Bottleneck-driven inference*: the bottleneck pathway governs overall
     fragility. Sensitivity analyses, balance efforts, and covariate collection
     should be directed there first.

* **Curvature-based sensitivity** — `sensitivity_curvature()` maps dose-varying
  fragility along the full NIE/NDE curve: local fragility index (SE/|estimate|),
  numerical second derivative (curvature), and fragility zones where CI crosses
  zero. Identifies *where* along the dose–response causal inference is most
  vulnerable — a novel contribution not available in any existing R package.

## New functions

* `mitcv()` — computes the mITCV framework with robustness profile
* `print.mitcv()` — formatted report with publishable language template
* `plot_mitcv()` — mITCV robustness profile plot
* `sensitivity_curvature()` — dose-varying fragility data frame
* `plot_curvature()` — three-panel curvature visualisation
* `fragility_table()` — publication-ready pathway decomposition table (Table 2)
* `plot(fit, type = "mitcv")` and `plot(fit, type = "curvature")` via S3 router

# RobustMediate 0.1.0

## New features

* `robustmediate()` — Core engine. Fits treatment / mediator / outcome GLM
  pathway models, computes stabilised IPW weights using a natural-spline
  generalised propensity score, estimates NDE / NIE / TE over a user-specified
  dose grid with bootstrap confidence intervals, and builds the full bivariate
  sensitivity surface — all in a single call. Returns a `robmedfit` S3 object
  with precomputed slots so all downstream functions are instant.

* `plot_balance()` — Dual love plot (treatment **and** mediator pathways
  simultaneously). First implementation of this display in the R mediation
  ecosystem.

* `plot_mediation()` — Publication-ready dose-response curves for NDE, NIE,
  and TE with pointwise bootstrap confidence bands.

* `plot_sensitivity()` — Novel bivariate robustness contour: E-value
  (VanderWeele) on x-axis, Imai's ρ on y-axis. Zero-crossing contour is
  overlaid by default. Does not exist elsewhere in R.

* `diagnose()` — Formatted diagnostics report with a paste-ready Results
  paragraph covering balance, effects, and sensitivity.

* `compare_fits()` — Overlay two `robmedfit` objects for model-specification
  comparisons.

* `tipping_table()` — Extract tipping-point values as a manuscript-ready
  data frame.

## S3 methods

* `print.robmedfit()`, `summary.robmedfit()`
* `plot.robmedfit()` — routes to `plot_mediation()`, `plot_balance()`, or
  `plot_sensitivity()` via `type` argument.
* `tidy.robmedfit()`, `glance.robmedfit()`, `augment.robmedfit()` — broom
  compatibility.
* `as.data.frame.robmedfit()` — returns the effects curve data frame.

## Data

* `sim_mediation` — Simulated clustered education dataset (600 obs, 30 schools)
  with known ground truth NDE ≈ 0.25, NIE ≈ 0.35.
