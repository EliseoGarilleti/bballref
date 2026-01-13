# Get team aggregate per game stats across all seasons

Extract aggregate per game statistics for a specific NBA team across all
seasons or a specific range of seasons. This shows the team's average
per game stats.

## Usage

``` r
team_stats_per_game(team_code, years = NULL)
```

## Arguments

- team_code:

  3-letter team code (e.g., "LAL", "BOS", "ATL")

- years:

  Numeric vector of years to filter (optional). If NULL, returns all
  seasons. Can be a range (e.g., 2015:2024) or specific years (e.g.,
  c(2020, 2022, 2024))

## Value

Dataframe with team aggregate per game stats across specified seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get Lakers aggregate per game stats (all seasons)
lakers_pg <- team_stats_per_game("LAL")

# Get Lakers per game stats for recent years
lakers_recent <- team_stats_per_game("LAL", years = 2015:2024)

# Get Celtics per game stats for selected seasons
celtics_selected <- team_stats_per_game("BOS", years = c(2008, 2010, 2020))
} # }
```
