# Get team aggregate totals across all seasons

Extract aggregate total statistics for a specific NBA team across all
seasons or a specific range of seasons. This shows the team's cumulative
totals.

## Usage

``` r
team_stats_totals(team_code, years = NULL)
```

## Arguments

- team_code:

  3-letter team code (e.g., "LAL", "BOS", "ATL")

- years:

  Numeric vector of years to filter (optional). If NULL, returns all
  seasons. Can be a range (e.g., 2015:2024) or specific years (e.g.,
  c(2020, 2022, 2024))

## Value

Dataframe with team aggregate totals across specified seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get Lakers aggregate totals (all seasons)
lakers_total <- team_stats_totals("LAL")

# Get Lakers totals for specific years
lakers_recent <- team_stats_totals("LAL", years = 2015:2024)

# Get Celtics totals for selected seasons
celtics_selected <- team_stats_totals("BOS", years = c(2008, 2010, 2020))
} # }
```
