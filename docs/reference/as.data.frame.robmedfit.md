# Coerce effects curve to a data frame

Convenience accessor returning the NDE/NIE/TE curve data frame.

## Usage

``` r
# S3 method for class 'robmedfit'
as.data.frame(x, ...)
```

## Arguments

- x:

  A `robmedfit` object.

- ...:

  Ignored.

## Value

A data frame with columns `dose`, `estimand`, `estimate`, `lower`,
`upper`.
