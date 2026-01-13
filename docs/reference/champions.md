# Get NBA champions list

Extract historical list of NBA champions from Basketball Reference, with
automatic year range validation.

## Usage

``` r
champions(first_year = NULL, last_year = NULL)
```

## Arguments

- first_year:

  First year to include (NULL = from earliest available)

- last_year:

  Last year to include (NULL = to latest available)

## Value

Dataframe with columns: Year, Champion, team

## Examples

``` r
if (FALSE) { # \dontrun{
# All available champions
champs <- champions()

# Champions from 1980 to 2023
champs <- champions(first_year = 1980, last_year = 2023)

# Champions from 2000 to latest available
champs <- champions(first_year = 2000)
} # }
```
