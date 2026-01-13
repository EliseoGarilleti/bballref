# Get NBA player play-by-play stats

Extract play-by-play statistics for a specific NBA player.

## Usage

``` r
player_pbp(player, season_type = "regular")
```

## Arguments

- player:

  Player name (e.g., "LeBron James") or Basketball Reference player ID
  (e.g., "jamesle01")

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with player play-by-play stats across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get LeBron James regular season pbp stats
lebron_pbp <- player_pbp("jamesle01")

# Get playoff pbp stats
lebron_pbp_playoffs <- player_pbp("jamesle01", "playoffs")
} # }
```
