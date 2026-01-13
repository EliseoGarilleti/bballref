# Get NBA player per game stats

Extract per game statistics for a specific NBA player.

## Usage

``` r
player_per_game(player, season_type = "regular")
```

## Arguments

- player:

  Player name (e.g., "LeBron James") or Basketball Reference player ID
  (e.g., "jamesle01")

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with player per game stats across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Using player name
lebron_pg <- player_per_game("LeBron James")

# Using player ID
lebron_pg <- player_per_game("jamesle01")

# Get playoff per game stats
lebron_pg_playoffs <- player_per_game("LeBron James", "playoffs")
} # }
```
