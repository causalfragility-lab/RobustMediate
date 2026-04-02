# Diagnose a robmedfit Object

Prints a formatted diagnostics report covering balance, mediation
effects, and sensitivity robustness. The output is structured so that it
can be used directly (or with minimal editing) in the Results section of
an applied paper. Returns the underlying results invisibly.

## Usage

``` r
diagnose(x, ...)
```

## Arguments

- x:

  A `robmedfit` object.

- ...:

  Ignored.

## Value

Invisibly returns a list with elements `balance`, `effects`,
`sensitivity`, `meditcv`, and `meditcv_profile`.
