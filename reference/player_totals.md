# Get NBA player totals

Extract total statistics for a specific NBA player.

## Usage

``` r
player_totals(player, season_type = "regular")
```

## Arguments

- player:

  Player name (e.g., "LeBron James") or Basketball Reference player ID
  (e.g., "jamesle01")

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with player totals across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get LeBron James regular season totals
lebron_totals <- player_totals("jamesle01")

# Get playoff totals
lebron_totals_playoffs <- player_totals("jamesle01", "playoffs")
} # }
```
