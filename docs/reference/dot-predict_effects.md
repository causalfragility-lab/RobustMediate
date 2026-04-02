# Predict mean potential outcome under a dose pair (x, x_ref)

Implements the g-computation identification formula for the NDE and NIE:

\$\$NDE(x, x^\*) = E\[Y(x, M(x^\*))\] - E\[Y(x^\*, M(x^\*))\]\$\$
\$\$NIE(x, x^\*) = E\[Y(x, M(x))\] - E\[Y(x, M(x^\*))\]\$\$

The mediator is predicted at the **individual** level (not as a scalar
mean), correctly marginalising over each person's covariate values.

## Usage

``` r
.predict_effects(models, data, x, x_ref, treat_var, med_var, out_var)
```

## Arguments

- models:

  List with elements `treatment`, `mediator`, `outcome`.

- data:

  Original data frame.

- x:

  Dose value (the "treated" level).

- x_ref:

  Reference dose (counterfactual baseline).

- treat_var:

  Character. Name of treatment variable.

- med_var:

  Character. Name of mediator variable.

- out_var:

  Character. Name of outcome variable.

## Value

Named numeric vector: `NDE`, `NIE`, `TE`.
