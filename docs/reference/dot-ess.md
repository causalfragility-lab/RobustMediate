# Effective Sample Size for IPW weights

Returns the effective sample size (ESS) of the weighted sample: \\ESS =
(\sum w_i)^2 / \sum w_i^2\\ Values well below n indicate severe
weighting and likely positivity problems.

## Usage

``` r
.ess(weights)
```

## Arguments

- weights:

  Numeric vector of IPW weights.

## Value

Scalar ESS value.
