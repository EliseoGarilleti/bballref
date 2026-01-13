# Get NBA player advanced stats

Extract advanced statistics for a specific NBA player.

## Usage

``` r
player_advanced(player, season_type = "regular")
```

## Arguments

- player:

  Player name (e.g., "LeBron James") or Basketball Reference player ID
  (e.g., "jamesle01")

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with player advanced stats across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get LeBron James regular season advanced stats
lebron_advanced <- player_advanced("jamesle01")

# Get playoff advanced stats
lebron_advanced_playoffs <- player_advanced("jamesle01", "playoffs")
} # }
```
