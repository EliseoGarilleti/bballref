# Get team per minute statistics

Extract per minute statistics for an NBA team in a specific season.

## Usage

``` r
team_per_minute(team_code, year, season_type = "regular")
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

Dataframe with per minute stats including metadata columns (team,
season, season_type)

## Examples

``` r
if (FALSE) { # \dontrun{
# Get Lakers 2020 per minute stats
per_minute <- team_per_minute("LAL", 2020)
} # }
```
