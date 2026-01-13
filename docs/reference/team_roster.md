# Get team roster

Extract roster information for an NBA team in a specific season.

## Usage

``` r
team_roster(team_code, year, season_type = "regular")
```

## Arguments

- team_code:

  Three-letter team code (e.g., "LAL", "BOS", "CHI")

- year:

  Season year (e.g., 2020)

- season_type:

  Season type: "regular" for regular season, "playoffs" for postseason
  (default: "regular")

## Value

Dataframe with roster data including metadata columns (team, season,
season_type)

## Examples

``` r
if (FALSE) { # \dontrun{
# Get Lakers 2020 roster
roster <- team_roster("LAL", 2020)

# Get playoff roster
playoff_roster <- team_roster("LAL", 2020, "playoffs")
} # }
```
