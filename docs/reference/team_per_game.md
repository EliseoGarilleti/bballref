# Get team per game statistics

Extract per game statistics for an NBA team in a specific season.

## Usage

``` r
team_per_game(team_code, year, season_type = "regular")
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

Dataframe with per game stats including metadata columns (team, season,
season_type)

## Examples

``` r
if (FALSE) { # \dontrun{
# Get Lakers 2020 per game stats
per_game <- team_per_game("LAL", 2020)

# Get playoff per game stats
playoff_per_game <- team_per_game("LAL", 2020, "playoffs")
} # }
```
