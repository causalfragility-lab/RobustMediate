# Extract Tipping-Point Table

Returns a formatted data frame of sensitivity tipping points: the
minimum E-value and minimum \|rho\| required to nullify the NIE.
Designed for direct insertion into a table in a manuscript.

## Usage

``` r
tipping_table(x)
```

## Arguments

- x:

  A `robmedfit` object.

## Value

A data frame with columns `parameter`, `tipping_value`,
`interpretation`.
