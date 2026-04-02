# Build a prediction data frame for a specific dose value

Returns a copy of `data` with the treatment variable set to `dose`, used
to predict counterfactual mediator and outcome means under intervention.

## Usage

``` r
.dose_df(data, treat_var, dose)
```

## Arguments

- data:

  Original data frame.

- treat_var:

  Treatment variable name.

- dose:

  Scalar dose value.

## Value

Data frame with `treat_var` replaced by `dose`.
