# Get team per 100 possessions statistics

Extract per 100 possessions statistics for an NBA team in a specific
season.

## Usage

``` r
team_per_poss(team_code, year, season_type = "regular")
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

Dataframe with per 100 possessions stats including metadata columns
(team, season, season_type)

## Examples

``` r
if (FALSE) { # \dontrun{
# Get Lakers 2020 per 100 possessions stats
per_poss <- team_per_poss("LAL", 2020)
} # }
```
