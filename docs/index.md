# bballref

> R package for scraping NBA statistics from Basketball Reference

`bballref` is an R package that provides easy access to NBA basketball
statistics from [Basketball
Reference](https://www.basketball-reference.com). Extract player stats,
team stats, league averages, and historical championship data with
simple, intuitive functions.

## Installation

``` r

# Install from GitHub
devtools::install_github("EliseoGarilleti/bballref")
```

## Features

- **Player Statistics**: Per game, totals, per 36 minutes, per 100
  possessions, advanced stats, shooting stats, and play-by-play stats
- **Team Statistics**: Season-by-season stats and aggregate historical
  stats
- **League Statistics**: Historical NBA league averages
- **Championship Data**: Complete NBA championship history
- **Automatic Data Cleaning**: Handles complex column names (e.g., `3P%`
  → `three_Ppct`)
- **Season Type Support**: Regular season and playoff statistics
- **Player Name Search**: Use player names or Basketball Reference IDs

## Quick Start

``` r

library(bballref)

# Get LeBron James' per game stats (all seasons)
lebron <- player_per_game("LeBron James")

# Get Lakers 2020 regular season stats
lakers <- team_per_game("LAL", 2020)

# Get NBA champions from 2010 to 2020
champs <- champions(first_year = 2010, last_year = 2020)
```

------------------------------------------------------------------------

## Player Functions

All player functions accept either a **player name** (e.g., “LeBron
James”) or a **Basketball Reference player ID** (e.g., “jamesle01”).
They also support `season_type` parameter: `"regular"` (default) or
`"playoffs"`.

### `player_per_game(player, season_type = "regular")`

Get per game statistics for a player across all seasons.

**Example:**

``` r

# Using player name
lebron_pg <- player_per_game("LeBron James")

# Get playoff stats
lebron_playoffs <- player_per_game("LeBron James", "playoffs")

# Using player ID
curry_pg <- player_per_game("curryst01")
```

**Returns:** Dataframe with columns like `Season`, `Age`, `Tm`, `G`,
`PTS`, `AST`, `TRB`, `three_P`, `three_PA`, `FGpct`, etc.

------------------------------------------------------------------------

### `player_totals(player, season_type = "regular")`

Get season totals for a player across all seasons.

**Example:**

``` r

durant_totals <- player_totals("Kevin Durant")
durant_playoff_totals <- player_totals("Kevin Durant", "playoffs")
```

**Returns:** Similar columns to per game, but showing cumulative season
totals instead of averages.

------------------------------------------------------------------------

### `player_per_minute(player, season_type = "regular")`

Get per 36 minutes statistics for a player.

**Example:**

``` r

giannis_per36 <- player_per_minute("Giannis Antetokounmpo")
```

**Returns:** Stats normalized to per 36 minutes played.

------------------------------------------------------------------------

### `player_per_poss(player, season_type = "regular")`

Get per 100 possessions statistics for a player.

**Example:**

``` r

jokic_per_poss <- player_per_poss("Nikola Jokic")
```

**Returns:** Stats normalized to per 100 team possessions.

------------------------------------------------------------------------

### `player_advanced(player, season_type = "regular")`

Get advanced statistics for a player (PER, TS%, USG%, etc.).

**Example:**

``` r

embiid_advanced <- player_advanced("Joel Embiid")
```

**Returns:** Advanced metrics including PER, True Shooting %, Usage
Rate, Win Shares, BPM, VORP, etc.

------------------------------------------------------------------------

### `player_shooting(player, season_type = "regular")`

Get shooting statistics by distance and zone.

**Example:**

``` r

curry_shooting <- player_shooting("Stephen Curry")
```

**Returns:** Shot distribution, field goal percentages by distance,
corner 3s, etc.

------------------------------------------------------------------------

### `player_pbp(player, season_type = "regular")`

Get play-by-play statistics (shooting fouls, and-1s, etc.).

**Example:**

``` r

harden_pbp <- player_pbp("James Harden")
```

**Returns:** Play-by-play events and frequencies.

------------------------------------------------------------------------

## Team Functions

All team functions require a **team code** (3-letter abbreviation like
“LAL”, “BOS”, “GSW”) and a **year**. They support `season_type`:
`"regular"` (default) or `"playoffs"`.

### `team_per_game(team_code, year, season_type = "regular")`

Get per game statistics for a team in a specific season.

**Example:**

``` r

# Lakers 2020 regular season
lakers_2020 <- team_per_game("LAL", 2020)

# Warriors 2022 playoffs
warriors_playoffs <- team_per_game("GSW", 2022, "playoffs")
```

**Returns:** Player-by-player stats for the team roster in that season.

------------------------------------------------------------------------

### `team_totals(team_code, year, season_type = "regular")`

Get season totals for a team.

**Example:**

``` r

celtics_totals <- team_totals("BOS", 2024)
```

**Returns:** Cumulative season totals for each player on the roster.

------------------------------------------------------------------------

### `team_per_minute(team_code, year, season_type = "regular")`

Get per 36 minutes statistics for a team.

**Example:**

``` r

heat_per36 <- team_per_minute("MIA", 2023)
```

------------------------------------------------------------------------

### `team_per_poss(team_code, year, season_type = "regular")`

Get per 100 possessions statistics for a team.

**Example:**

``` r

nuggets_per_poss <- team_per_poss("DEN", 2023)
```

------------------------------------------------------------------------

### `team_advanced(team_code, year, season_type = "regular")`

Get advanced statistics for a team.

**Example:**

``` r

bucks_advanced <- team_advanced("MIL", 2021)
```

**Returns:** Advanced metrics like TS%, eFG%, ORB%, DRB%, AST%, etc.

------------------------------------------------------------------------

### `team_shooting(team_code, year, season_type = "regular")`

Get shooting statistics by distance for a team.

**Example:**

``` r

warriors_shooting <- team_shooting("GSW", 2022)
```

------------------------------------------------------------------------

### `team_pbp(team_code, year, season_type = "regular")`

Get play-by-play statistics for a team.

**Example:**

``` r

lakers_pbp <- team_pbp("LAL", 2020)
```

------------------------------------------------------------------------

### `team_roster(team_code, year, season_type = "regular")`

Get roster information for a team.

**Example:**

``` r

celtics_roster <- team_roster("BOS", 2024)
```

**Returns:** Player names, positions, height, weight, birth date,
college, etc.

------------------------------------------------------------------------

### `team_stats_totals(team_code)`

Get **aggregate total statistics** for a team across **all seasons in
franchise history**.

**Example:**

``` r

# Get all-time totals for Atlanta Hawks
hawks_totals <- team_stats_totals("ATL")
```

**Returns:** Season-by-season totals for wins, losses, points, shooting
percentages, etc., spanning entire franchise history.

------------------------------------------------------------------------

### `team_stats_per_game(team_code)`

Get **aggregate per game statistics** for a team across **all seasons in
franchise history**.

**Example:**

``` r

# Get all-time per game averages for Lakers
lakers_pg <- team_stats_per_game("LAL")
```

**Returns:** Season-by-season per game averages spanning entire
franchise history.

------------------------------------------------------------------------

## League Functions

League functions provide NBA-wide averages across all seasons. They
support `season_type`: `"regular"` (default) or `"playoffs"`.

### `league_per_game(season_type = "regular")`

Get historical NBA league per game averages.

**Example:**

``` r

# Regular season league averages
league_avg <- league_per_game()

# Playoff league averages
league_playoffs <- league_per_game("playoffs")
```

**Returns:** League-wide averages by season (pace, PPG, FG%, 3PA, etc.).

------------------------------------------------------------------------

### `league_totals(season_type = "regular")`

Get historical NBA league totals.

**Example:**

``` r

league_totals_data <- league_totals()
```

**Returns:** League-wide cumulative totals by season.

------------------------------------------------------------------------

### `league_per_poss(season_type = "regular")`

Get historical NBA league per 100 possessions stats.

**Example:**

``` r

league_per_poss_data <- league_per_poss()
```

**Returns:** League-wide stats normalized to per 100 possessions.

------------------------------------------------------------------------

## Championship Data

### `champions(first_year = NULL, last_year = NULL)`

Get NBA championship history with automatic year validation.

**Example:**

``` r

# All available champions
all_champs <- champions()

# Champions from 1980 to 2000
champs_80s_90s <- champions(first_year = 1980, last_year = 2000)

# Champions from 2010 onwards
recent_champs <- champions(first_year = 2010)
```

**Returns:** Dataframe with columns `Year`, `Champion` (team name),
`team` (3-letter code), plus additional championship details.

------------------------------------------------------------------------

## Common Team Codes

| Code | Team                  |
|------|-----------------------|
| ATL  | Atlanta Hawks         |
| BOS  | Boston Celtics        |
| BRK  | Brooklyn Nets         |
| CHI  | Chicago Bulls         |
| CLE  | Cleveland Cavaliers   |
| DAL  | Dallas Mavericks      |
| DEN  | Denver Nuggets        |
| DET  | Detroit Pistons       |
| GSW  | Golden State Warriors |
| HOU  | Houston Rockets       |
| LAC  | Los Angeles Clippers  |
| LAL  | Los Angeles Lakers    |
| MIA  | Miami Heat            |
| MIL  | Milwaukee Bucks       |
| NYK  | New York Knicks       |
| OKC  | Oklahoma City Thunder |
| PHI  | Philadelphia 76ers    |
| PHO  | Phoenix Suns          |
| SAS  | San Antonio Spurs     |
| TOR  | Toronto Raptors       |

[Full list available at Basketball
Reference](https://www.basketball-reference.com/teams/)

------------------------------------------------------------------------

## Data Cleaning Features

The package automatically cleans column names for easier data
manipulation:

- `3P` → `three_P`
- `3PA` → `three_PA`
- `3P%` → `three_Ppct`
- `2P` → `two_P`
- `FG%` → `FGpct`

**Before:**

``` r

# Column names from Basketball Reference
c("Player", "Age", "3P", "3PA", "3P%", "FG%")
```

**After:**

``` r

# Cleaned column names in bballref
c("Player", "Age", "three_P", "three_PA", "three_Ppct", "FGpct")
```

This makes it easy to work with data in R:

``` r

lebron <- player_per_game("LeBron James")

# No syntax errors!
lebron$three_Ppct  # Works perfectly
```

------------------------------------------------------------------------

## Console Output

Functions provide informative console messages:

``` r

player_per_game("LeBron James")
# Searching player: LeBron James
# Success: 22 rows obtained

team_per_game("LAL", 2020)
# Searching team: LAL 2020 (regular season)
# Success: 18 rows obtained

champions(first_year = 2015, last_year = 2020)
# Obteniendo campeones de NBA...
#   -> Años disponibles: 1947 - 2025
#   -> Éxito: 6 campeones obtenidos ( 2015 - 2020 )
```

------------------------------------------------------------------------

## Notes

- **Rate Limiting**: The package includes automatic 2-second delays
  between requests to respect Basketball Reference’s servers

- **Case Insensitive**: Player names are case-insensitive:
  `"lebron james"` works the same as `"LeBron James"`

- **Player IDs**: You can find player IDs on Basketball Reference URLs
  (e.g., `/players/j/jamesle01.html` → `"jamesle01"`)

- **Data Types**: All data is returned as character type for maximum
  compatibility. Convert to numeric as needed:

  ``` r

  lebron$PTS <- as.numeric(lebron$PTS)
  ```

------------------------------------------------------------------------

## Examples

### Compare players across their careers

``` r

library(bballref)
library(dplyr)

# Get career stats
lebron <- player_per_game("LeBron James")
jordan <- player_per_game("Michael Jordan")

# Compare career PPG
mean(as.numeric(lebron$PTS), na.rm = TRUE)
mean(as.numeric(jordan$PTS), na.rm = TRUE)
```

### Analyze a championship team

``` r

# Get Lakers 2020 championship roster and stats
lakers_roster <- team_roster("LAL", 2020)
lakers_stats <- team_per_game("LAL", 2020)
lakers_playoffs <- team_per_game("LAL", 2020, "playoffs")

# Top scorers in playoffs
lakers_playoffs %>%
  mutate(PTS = as.numeric(PTS)) %>%
  arrange(desc(PTS)) %>%
  select(Player, PTS, AST, TRB) %>%
  head(5)
```

### Track league trends over time

``` r

library(ggplot2)

# Get historical league averages
league_data <- league_per_game()

# Plot 3-point shooting evolution
league_data %>%
  mutate(Season = as.numeric(substr(Season, 1, 4)),
         three_PA = as.numeric(three_PA)) %>%
  ggplot(aes(x = Season, y = three_PA)) +
  geom_line() +
  labs(title = "NBA 3-Point Attempts Per Game Over Time",
       x = "Season", y = "3PA per game")
```

------------------------------------------------------------------------

## Contributing

Issues and pull requests are welcome at
<https://github.com/EliseoGarilleti/bballref>

------------------------------------------------------------------------

## License

This package is provided as-is for educational and research purposes.
Please respect Basketball Reference’s [terms of
service](https://www.sports-reference.com/termsofuse.html) when using
this package.

------------------------------------------------------------------------

## Acknowledgments

Data sourced from [Basketball
Reference](https://www.basketball-reference.com), a Sports Reference
website.
