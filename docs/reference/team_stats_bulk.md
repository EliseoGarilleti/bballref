# Get team statistics for multiple teams and/or years

Extract team statistics for multiple teams and/or years at once.
Combines results into a single dataframe.

## Usage

``` r
team_stats_bulk(
  stat_function,
  teams,
  years,
  season_type = "regular",
  progress = TRUE
)
```

## Arguments

- stat_function:

  The team stat function to use (e.g., team_per_game, team_totals)

- teams:

  Character vector of team codes (e.g., c("LAL", "BOS", "GSW"))

- years:

  Numeric vector of years (e.g., 2020:2024 or c(2020, 2022, 2024))

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

- progress:

  Show progress bar (default: TRUE)

## Value

Dataframe with combined results from all teams/years

## Examples

``` r
if (FALSE) { # \dontrun{
# Multiple teams, same year
finals_2020 <- team_stats_bulk(team_per_game, c("LAL", "MIA"), 2020)

# One team, multiple years
lakers_history <- team_stats_bulk(team_per_game, "LAL", 2018:2024)

# Multiple teams, multiple years
contenders <- team_stats_bulk(team_totals, c("LAL", "BOS", "GSW"), 2022:2024)
} # }
```
