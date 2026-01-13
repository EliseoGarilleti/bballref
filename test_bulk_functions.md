# Testing New Bulk Functions

This document tests the new bulk functions added to the bballref
package.

------------------------------------------------------------------------

## 1. Team Stats Bulk - Multiple Teams, Same Year

Get per game stats for Lakers and Heat in 2020 (NBA Finals matchup):

``` r
finals_2020 <- team_stats_bulk(
  stat_function = team_per_game,
  teams = c("LAL", "MIA"),
  years = 2020,
  season_type = "regular",
  progress = FALSE
)
```

    ## Fetching data for 2 team-season combinations...
    ## Searching team: LAL 2020 (regular season)
    ## Success: 21 rows obtained
    ## Searching team: MIA 2020 (regular season)
    ## Success: 22 rows obtained
    ## Success: Combined 43 rows from 2 team-seasons

``` r
# Show first rows
head(finals_2020, 10) %>%
  select(Player, Age, Tm, G, PTS, AST, TRB, team) %>%
  kable()
```

    ## Error in `select()`:
    ## ! Can't select columns that don't exist.
    ## ✖ Column `Tm` doesn't exist.

**Summary:**

- Total rows: 43
- Teams: LAL, MIA

------------------------------------------------------------------------

## 2. Team Stats Bulk - One Team, Multiple Years

Get Lakers per game stats from 2022 to 2024:

``` r
lakers_history <- team_stats_bulk(
  stat_function = team_per_game,
  teams = "LAL",
  years = 2022:2024,
  progress = FALSE
)
```

    ## Fetching data for 3 team-season combinations...
    ## Searching team: LAL 2022 (regular season)
    ## Success: 26 rows obtained
    ## Searching team: LAL 2023 (regular season)
    ## Success: 25 rows obtained
    ## Searching team: LAL 2024 (regular season)
    ## Success: 22 rows obtained
    ## Success: Combined 73 rows from 3 team-seasons

``` r
# Show first rows
head(lakers_history, 12) %>%
  select(Player, Age, Tm, G, PTS, AST, TRB, season) %>%
  kable()
```

    ## Error in `select()`:
    ## ! Can't select columns that don't exist.
    ## ✖ Column `Tm` doesn't exist.

**Summary:**

- Total rows: 73
- Seasons: 2022, 2023, 2024

------------------------------------------------------------------------

## 3. Player Stats Bulk - Compare Multiple Players

Compare career per game stats for LeBron James and Stephen Curry:

``` r
stars <- player_stats_bulk(
  stat_function = player_per_game,
  players = c("LeBron James", "Stephen Curry"),
  season_type = "regular",
  progress = FALSE
)
```

    ## Fetching data for 2 players...
    ## Searching player: LeBron James
    ## Success: 23 rows obtained
    ## Searching player: Stephen Curry
    ## Success: 17 rows obtained
    ## Success: Combined 40 rows from 2 players

``` r
# Show first 5 seasons for each player
stars %>%
  group_by(player_name) %>%
  slice(1:5) %>%
  select(Season, Age, Tm, G, PTS, AST, TRB, player_name) %>%
  kable()
```

    ## Error in `group_by()`:
    ## ! Must group by variables found in `.data`.
    ## ✖ Column `player_name` is not found.

**Summary:**

- Total rows: 40
- Players:
- LeBron seasons: 0
- Curry seasons: 0

------------------------------------------------------------------------

## 4. Team Aggregate Stats - Filtered by Years

Get Lakers aggregate totals for years 2015-2024:

``` r
lakers_recent <- team_stats_totals("LAL", years = 2015:2024)
```

    ## Searching team aggregate stats: LAL (totals)

    ## Filtered to years: 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024
    ## Success: 10 rows obtained

``` r
# Show all rows
lakers_recent %>%
  select(Season, Lg, Tm, W, L, Age, team) %>%
  kable()
```

| Season  | Lg  | Tm  | W   | L   | Age  | team |
|:--------|:----|:----|:----|:----|:-----|:-----|
| 2023-24 | NBA | LAL | 47  | 35  | 28.0 | LAL  |
| 2022-23 | NBA | LAL | 43  | 39  | 27.9 | LAL  |
| 2021-22 | NBA | LAL | 33  | 49  | 30.2 | LAL  |
| 2020-21 | NBA | LAL | 42  | 30  | 28.2 | LAL  |
| 2019-20 | NBA | LAL | 52  | 19  | 29.5 | LAL  |
| 2018-19 | NBA | LAL | 37  | 45  | 26.2 | LAL  |
| 2017-18 | NBA | LAL | 35  | 47  | 23.7 | LAL  |
| 2016-17 | NBA | LAL | 26  | 56  | 25.1 | LAL  |
| 2015-16 | NBA | LAL | 17  | 65  | 26.5 | LAL  |
| 2014-15 | NBA | LAL | 21  | 61  | 27.0 | LAL  |

**Summary:**

- Total rows: 10
- Seasons included: 2023-24, 2022-23, 2021-22, 2020-21, 2019-20,
  2018-19, 2017-18, 2016-17, 2015-16, 2014-15

------------------------------------------------------------------------

## 5. Team Aggregate Stats Per Game - Specific Years

Get Celtics aggregate per game stats for selected years:

``` r
celtics_selected <- team_stats_per_game("BOS", years = c(2008, 2010, 2020, 2024))
```

    ## Searching team aggregate stats: BOS (per game)

    ## Filtered to years: 2008, 2010, 2020, 2024
    ## Success: 4 rows obtained

``` r
# Show all rows
celtics_selected %>%
  select(Season, Lg, Tm, W, L, Age, team) %>%
  kable()
```

| Season  | Lg  | Tm  | W   | L   | Age  | team |
|:--------|:----|:----|:----|:----|:-----|:-----|
| 2023-24 | NBA | BOS | 64  | 18  | 28.2 | BOS  |
| 2019-20 | NBA | BOS | 48  | 24  | 25.3 | BOS  |
| 2009-10 | NBA | BOS | 50  | 32  | 29.4 | BOS  |
| 2007-08 | NBA | BOS | 66  | 16  | 27.9 | BOS  |

**Summary:**

- Total rows: 4
- Seasons: 2023-24, 2019-20, 2009-10, 2007-08

------------------------------------------------------------------------

## 6. Team Aggregate Stats - All Years (Default)

Get Warriors aggregate totals (no year filter) - showing first 10 rows:

``` r
warriors_all <- team_stats_totals("GSW")
```

    ## Searching team aggregate stats: GSW (totals)
    ## Success: 83 rows obtained

``` r
# Show first 10 rows
head(warriors_all, 10) %>%
  select(Season, Lg, Tm, W, L, Age, team) %>%
  kable()
```

| Season  | Lg  | Tm  | W   | L   | Age  | team |
|:--------|:----|:----|:----|:----|:-----|:-----|
| 2025-26 | NBA | GSW | 21  | 19  | 29.3 | GSW  |
| 2024-25 | NBA | GSW | 48  | 34  | 28.6 | GSW  |
| 2023-24 | NBA | GSW | 46  | 36  | 28.4 | GSW  |
| 2022-23 | NBA | GSW | 44  | 38  | 27.3 | GSW  |
| 2021-22 | NBA | GSW | 53  | 29  | 27.6 | GSW  |
| 2020-21 | NBA | GSW | 39  | 33  | 26.7 | GSW  |
| 2019-20 | NBA | GSW | 15  | 50  | 24.4 | GSW  |
| 2018-19 | NBA | GSW | 57  | 25  | 28.4 | GSW  |
| 2017-18 | NBA | GSW | 58  | 24  | 28.8 | GSW  |
| 2016-17 | NBA | GSW | 67  | 15  | 28.2 | GSW  |

**Summary:**

- Total rows: 83
- Earliest season: 1946-47
- Latest season: 2025-26

------------------------------------------------------------------------

## Summary of New Functions

### 1. `team_stats_bulk(stat_function, teams, years, ...)`

Fetch data for multiple teams and/or multiple years:

``` r
# Multiple teams, same year
team_stats_bulk(team_per_game, c("LAL", "BOS"), 2024)

# One team, multiple years
team_stats_bulk(team_totals, "LAL", 2020:2024)

# Multiple teams and years
team_stats_bulk(team_advanced, c("LAL", "BOS"), 2022:2024)
```

Features: - Works with any team stat function - Combines results into
single dataframe - Optional progress messages - Automatic error handling

------------------------------------------------------------------------

### 2. `player_stats_bulk(stat_function, players, ...)`

Fetch career data for multiple players:

``` r
# Compare multiple players
player_stats_bulk(
  player_per_game,
  c("LeBron James", "Michael Jordan", "Kobe Bryant")
)

# Playoff comparison
player_stats_bulk(
  player_advanced,
  c("Stephen Curry", "Kevin Durant"),
  season_type = "playoffs"
)
```

Features: - Works with any player stat function - Combines results for
easy comparison - Accepts player names or IDs - Optional progress
messages

------------------------------------------------------------------------

### 3. Enhanced Aggregate Functions

[`team_stats_totals()`](https://eliseogarilleti.github.io/bballref/reference/team_stats_totals.md)
and
[`team_stats_per_game()`](https://eliseogarilleti.github.io/bballref/reference/team_stats_per_game.md)
now accept `years` parameter:

``` r
# All seasons (default)
team_stats_totals("LAL")

# Specific range
team_stats_totals("LAL", years = 2015:2024)

# Selected years
team_stats_per_game("BOS", years = c(2008, 2010, 2020))
```

Features: - Filter historical data to specific seasons - Accepts ranges
or individual years - Maintains all original functionality when
`years = NULL`

------------------------------------------------------------------------

## Common Use Cases

### 1. Compare Finals Opponents

``` r
finals_matchup <- team_stats_bulk(
  team_per_game,
  teams = c("LAL", "MIA"),
  years = 2020
)
```

### 2. Track Team Over Time

``` r
warriors_dynasty <- team_stats_bulk(
  team_advanced,
  teams = "GSW",
  years = 2015:2019
)
```

### 3. Compare Player Careers

``` r
goats <- player_stats_bulk(
  player_per_game,
  players = c("LeBron James", "Michael Jordan")
)
```

### 4. Analyze Championship Era

``` r
lakers_championships <- team_stats_totals(
  "LAL",
  years = c(2000, 2001, 2002, 2009, 2010, 2020)
)
```
