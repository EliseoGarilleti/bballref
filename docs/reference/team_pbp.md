# Get team play-by-play statistics

Extract play-by-play statistics for an NBA team in a specific season.

## Usage

``` r
team_pbp(team_code, year, season_type = "regular")
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

Dataframe with play-by-play stats including metadata columns (team,
season, season_type)

## Examples

``` r
if (FALSE) { # \dontrun{
# Get Lakers 2020 play-by-play stats
pbp <- team_pbp("LAL", 2020)
} # }
```
