# Get NBA player per 100 possessions stats

Extract per 100 possessions statistics for a specific NBA player.

## Usage

``` r
player_per_poss(player, season_type = "regular")
```

## Arguments

- player:

  Player name (e.g., "LeBron James") or Basketball Reference player ID
  (e.g., "jamesle01")

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with player per 100 possessions stats across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get LeBron James regular season per 100 poss stats
lebron_per_poss <- player_per_poss("jamesle01")

# Get playoff per 100 poss stats
lebron_per_poss_playoffs <- player_per_poss("jamesle01", "playoffs")
} # }
```
