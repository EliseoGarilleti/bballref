# Get NBA league per 100 possessions stats

Extract historical NBA league per 100 possessions statistics.

## Usage

``` r
league_per_poss(season_type = "regular")
```

## Arguments

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with league per 100 possessions stats across all seasons

## Examples

``` r
if (FALSE) { # \dontrun{
# Get regular season per 100 poss stats
league_per_poss <- league_per_poss()

# Get playoff per 100 poss stats
league_per_poss_playoffs <- league_per_poss("playoffs")
} # }
```
