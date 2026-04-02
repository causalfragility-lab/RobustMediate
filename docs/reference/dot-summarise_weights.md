# Summarise GPS weight distribution

Prints a compact diagnostic table for IPW weights: range, mean, ESS, and
a flag if ESS \< 0.4 \* n (severe imbalance warning).

## Usage

``` r
.summarise_weights(weights, n, pathway = "treatment")
```

## Arguments

- weights:

  Numeric weight vector.

- n:

  Original sample size.

- pathway:

  Label for the pathway (e.g. `"treatment"`).

## Value

Invisibly returns a named list with `min`, `max`, `mean`, `ess`,
`ess_ratio`.
