# Get NBA league totals

Extract historical NBA league totals statistics.

## Usage

``` r
league_totals(season_type = "regular")
```

## Arguments

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with league totals across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get regular season league totals
league_totals <- league_totals()

# Get playoff league totals
league_totals_playoffs <- league_totals("playoffs")
} # }
```
