# Get NBA player shooting stats

Extract shooting statistics for a specific NBA player.

## Usage

``` r
player_shooting(player, season_type = "regular")
```

## Arguments

- player:

  Player name (e.g., "LeBron James") or Basketball Reference player ID
  (e.g., "jamesle01")

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with player shooting stats across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get LeBron James regular season shooting stats
lebron_shooting <- player_shooting("jamesle01")

# Get playoff shooting stats
lebron_shooting_playoffs <- player_shooting("jamesle01", "playoffs")
} # }
```
