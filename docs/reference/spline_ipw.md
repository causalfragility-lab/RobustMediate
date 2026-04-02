# Spline-Based Generalised Propensity Score for Continuous Treatments

Internal machinery that fits a **natural spline** treatment model to
estimate the generalised propensity score (GPS) for a continuous
exposure. This produces more flexible, positivity-respecting stabilised
IPW weights than a simple linear model.

Users do not call these functions directly — they are invoked
automatically by
[`robustmediate()`](https://causalfragility-lab.github.io/RobustMediate/reference/robustmediate.md)
when `spline_df > 1`.
