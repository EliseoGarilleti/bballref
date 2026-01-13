# Get player statistics for multiple players

Extract career statistics for multiple players at once. Combines results
into a single dataframe for easy comparison.

## Usage

``` r
player_stats_bulk(
  stat_function,
  players,
  season_type = "regular",
  progress = TRUE
)
```

## Arguments

- stat_function:

  The player stat function to use (e.g., player_per_game, player_totals)

- players:

  Character vector of player names or IDs (e.g., c("LeBron James",
  "Michael Jordan"))

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

- progress:

  Show progress bar (default: TRUE)

## Value

Dataframe with combined career stats from all players

## Examples

``` r
if (FALSE) { # \dontrun{
# Compare multiple players' careers
goats <- player_stats_bulk(
  player_per_game,
  c("LeBron James", "Michael Jordan", "Kobe Bryant")
)

# Compare playoff performances
playoff_stars <- player_stats_bulk(
  player_advanced,
  c("Stephen Curry", "Kevin Durant", "Giannis Antetokounmpo"),
  season_type = "playoffs"
)
} # }
```
