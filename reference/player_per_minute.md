# Get NBA player per 36 minutes stats

Extract per 36 minutes statistics for a specific NBA player.

## Usage

``` r
player_per_minute(player, season_type = "regular")
```

## Arguments

- player:

  Player name (e.g., "LeBron James") or Basketball Reference player ID
  (e.g., "jamesle01")

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with player per 36 minutes stats across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get LeBron James regular season per 36 stats
lebron_per36 <- player_per_minute("jamesle01")

# Get playoff per 36 stats
lebron_per36_playoffs <- player_per_minute("jamesle01", "playoffs")
} # }
```
