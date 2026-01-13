# Get team totals statistics

Extract season totals for an NBA team in a specific season.

## Usage

``` r
team_totals(team_code, year, season_type = "regular")
```

## Arguments

- team_code:

  Three-letter team code (e.g., "LAL", "BOS", "CHI")

- year:

  Season year (e.g., 2020)

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with season totals including metadata columns (team, season,
season_type)

## Examples

``` r
if (FALSE) { # \dontrun{
# Get Lakers 2020 season totals
totals <- team_totals("LAL", 2020)

# Get playoff totals
playoff_totals <- team_totals("LAL", 2020, "playoffs")
} # }
```
