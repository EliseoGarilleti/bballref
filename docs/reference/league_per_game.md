# Get NBA league averages per game

Extract historical NBA league averages per game statistics.

## Usage

``` r
league_per_game(season_type = "regular")
```

## Arguments

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with league averages per game across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get regular season league averages
league_per_game <- league_per_game()

# Get playoff league averages
league_per_game_playoffs <- league_per_game("playoffs")
} # }
```
