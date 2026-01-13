---
title: "bballref Package - Complete Function Reference"
output: html_document
date: "2026-01-13"
---



# bballref Package - Complete Function Reference

This document demonstrates all functions available in the bballref package with examples and sample output.

---

# 1. Player Functions

## 1.1 player_per_game()

Get per game statistics for a player across all seasons.


``` r
# Get LeBron James per game stats
lebron_pg <- player_per_game("LeBron James")
```

```
## Searching player: LeBron James 
## Success: 23 rows obtained
```

``` r
# Show first 10 seasons
head(lebron_pg, 10) %>%
  select(Season, Age, Tm, G, PTS, AST, TRB, FGpct) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Total seasons:** 23

---

## 1.2 player_totals()

Get season totals for a player.


``` r
# Get Stephen Curry totals
curry_totals <- player_totals("Stephen Curry")
```

```
## Searching player: Stephen Curry 
## Success: 17 rows obtained
```

``` r
# Show first 10 seasons
head(curry_totals, 10) %>%
  select(Season, Age, Tm, G, PTS, AST, TRB, three_P) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Total seasons:** 17

---

## 1.3 player_per_minute()

Get per 36 minutes statistics.


``` r
# Get Giannis per 36 stats
giannis_per36 <- player_per_minute("Giannis Antetokounmpo")
```

```
## Searching player: Giannis Antetokounmpo 
## Success: 13 rows obtained
```

``` r
# Show first 8 seasons
head(giannis_per36, 8) %>%
  select(Season, Age, Tm, G, PTS, AST, TRB) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Total seasons:** 13

---

## 1.4 player_advanced()

Get advanced statistics (PER, TS%, WS, etc.).


``` r
# Get Kevin Durant advanced stats
durant_adv <- player_advanced("Kevin Durant")
```

```
## Searching player: Kevin Durant 
## Success: 21 rows obtained
```

``` r
# Show first 8 seasons
head(durant_adv, 8) %>%
  select(Season, Age, Tm, PER, WS, BPM) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Total seasons:** 21

---

## 1.5 player_per_poss()

Get per 100 possessions statistics.


``` r
# Get Nikola Jokic per 100 poss stats
jokic_poss <- player_per_poss("Nikola Jokic")
```

```
## Error: Player not found - Nikola Jokic
```

``` r
# Show all seasons
jokic_poss %>%
  select(Season, Age, Tm, G, PTS, AST, TRB) %>%
  kable()
```

```
## Error in UseMethod("select"): no applicable method for 'select' applied to an object of class "NULL"
```

**Total seasons:** 

---

## 1.6 player_shooting()

Get shooting statistics by distance and zone.


``` r
# Get Stephen Curry shooting stats
curry_shoot <- player_shooting("Stephen Curry")
```

```
## Searching player: Stephen Curry 
## Success: 17 rows obtained
```

``` r
# Show recent 5 seasons
head(curry_shoot, 5) %>%
  select(Season, Age, Tm, FGpct, three_Ppct) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Total seasons:** 17

---

## 1.7 player_pbp()

Get play-by-play statistics.


``` r
# Get James Harden pbp stats
harden_pbp <- player_pbp("James Harden")
```

```
## Searching player: James Harden 
## Success: 21 rows obtained
```

``` r
# Show recent 5 seasons
head(harden_pbp, 5) %>%
  select(Season, Age, Tm, G) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Total seasons:** 21

---

## 1.8 player_stats_bulk() - NEW

Get career statistics for multiple players at once.


``` r
# Compare LeBron and Jordan
goats <- player_stats_bulk(
  stat_function = player_per_game,
  players = c("LeBron James", "Michael Jordan"),
  season_type = "regular",
  progress = FALSE
)
```

```
## Fetching data for 2 players...
## Searching player: LeBron James 
## Success: 23 rows obtained
## Searching player: Michael Jordan 
## Success: 19 rows obtained
## Success: Combined 42 rows from 2 players
```

``` r
# Show first 5 seasons for each
goats %>%
  group_by(player_id) %>%
  slice(1:5) %>%
  select(Season, Age, Tm, G, PTS, AST, TRB, player_id) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Total rows:** 42
**Players:** 2

---

# 2. Team Functions (Season-Specific)

## 2.1 team_per_game()

Get per game statistics for a team in a specific season.


``` r
# Get Lakers 2020 per game stats
lakers_2020 <- team_per_game("LAL", 2020)
```

```
## Searching team: LAL 2020 (regular season) 
## Success: 21 rows obtained
```

``` r
# Show all players
lakers_2020 %>%
  select(Player, Age, G, PTS, AST, TRB) %>%
  kable()
```



|Player                   |Age |G  |PTS   |AST  |TRB  |
|:------------------------|:---|:--|:-----|:----|:----|
|LeBron James             |35  |67 |25.3  |10.2 |7.8  |
|Anthony Davis            |26  |62 |26.1  |3.2  |9.3  |
|Kentavious Caldwell-Pope |26  |69 |9.3   |1.6  |2.1  |
|Kyle Kuzma               |24  |61 |12.8  |1.3  |4.5  |
|Danny Green              |32  |68 |8     |1.3  |3.3  |
|Avery Bradley            |29  |49 |8.6   |1.3  |2.3  |
|Dion Waiters             |28  |7  |11.9  |2.4  |1.9  |
|Rajon Rondo              |33  |48 |7.1   |5    |3    |
|Dwight Howard            |34  |69 |7.5   |0.7  |7.3  |
|Alex Caruso              |25  |64 |5.5   |1.9  |1.9  |
|JaVale McGee             |32  |68 |6.6   |0.5  |5.7  |
|Markieff Morris          |30  |14 |5.3   |0.6  |3.2  |
|Talen Horton-Tucker      |19  |6  |5.7   |1    |1.2  |
|J.R. Smith               |34  |6  |2.8   |0.5  |0.8  |
|Quinn Cook               |26  |44 |5.1   |1.1  |1.2  |
|Troy Daniels             |28  |41 |4.2   |0.3  |1.1  |
|Devontae Cacok           |23  |1  |6     |1    |5    |
|Jared Dudley             |34  |45 |1.5   |0.6  |1.2  |
|Kostas Antetokounmpo     |22  |5  |1.4   |0.4  |0.6  |
|Zach Norvell             |22  |2  |0     |0    |0.5  |
|Team Totals              |NA  |71 |113.4 |25.4 |45.7 |

**Total players:** 21

---

## 2.2 team_totals()

Get season totals for a team.


``` r
# Get Warriors 2022 totals
warriors_2022 <- team_totals("GSW", 2022)
```

```
## Searching team: GSW 2022 (regular season) 
## Success: 18 rows obtained
```

``` r
# Show top 10 players by games
head(warriors_2022, 10) %>%
  select(Player, Age, G, PTS, AST, TRB) %>%
  kable()
```



|Player           |Age |G  |PTS  |AST |TRB |
|:----------------|:---|:--|:----|:---|:---|
|Andrew Wiggins   |26  |73 |1256 |161 |325 |
|Jordan Poole     |22  |76 |1405 |304 |260 |
|Stephen Curry    |33  |64 |1630 |404 |335 |
|Kevon Looney     |25  |82 |491  |165 |596 |
|Otto Porter Jr.  |28  |63 |515  |94  |362 |
|Draymond Green   |31  |46 |346  |320 |336 |
|Damion Lee       |29  |63 |467  |63  |203 |
|Gary Payton II   |29  |71 |502  |64  |247 |
|Jonathan Kuminga |19  |70 |652  |64  |234 |
|Nemanja Bjelica  |33  |71 |433  |159 |294 |

**Total players:** 18

---

## 2.3 team_advanced()

Get advanced statistics for a team.


``` r
# Get Celtics 2024 advanced stats
celtics_adv <- team_advanced("BOS", 2024)
```

```
## Searching team: BOS 2024 (regular season) 
## Success: 20 rows obtained
```

``` r
# Show top 10 players by games
head(celtics_adv, 10) %>%
  select(Player, Age, G, PER, WS) %>%
  kable()
```



|Player             |Age |G  |PER  |WS   |
|:------------------|:---|:--|:----|:----|
|Jayson Tatum       |25  |74 |22.3 |10.4 |
|Derrick White      |29  |73 |16.9 |8.5  |
|Jaylen Brown       |27  |70 |18.6 |5.9  |
|Jrue Holiday       |33  |69 |14.4 |6.3  |
|Payton Pritchard   |26  |82 |15.3 |6.1  |
|Sam Hauser         |26  |79 |13   |4.9  |
|Al Horford         |37  |65 |15   |6.2  |
|Kristaps Porziņģis |28  |57 |23.2 |7.9  |
|Luke Kornet        |28  |63 |19.8 |5.1  |
|Oshae Brissett     |25  |55 |12.8 |1.7  |

**Total players:** 20

---

## 2.4 team_roster()

Get roster information for a team.


``` r
# Get Heat 2020 roster
heat_roster <- team_roster("MIA", 2020)
```

```
## Searching team: MIA 2020 (regular season) 
## Success: 21 rows obtained
```

``` r
# Show all players
heat_roster %>%
  select(Player, Pos, Ht, Wt, Birth_Date) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Birth_Date` doesn't exist.
```

**Total players:** 21

---

## 2.5 team_per_minute()

Get per 36 minutes statistics for a team.


``` r
# Get Nuggets 2023 per 36 stats
nuggets_per36 <- team_per_minute("DEN", 2023)
```

```
## Searching team: DEN 2023 (regular season) 
## Success: 18 rows obtained
```

``` r
# Show top 10 players
head(nuggets_per36, 10) %>%
  select(Player, Age, G, PTS, AST, TRB) %>%
  kable()
```



|Player                   |Age |G  |PTS  |AST  |TRB  |
|:------------------------|:---|:--|:----|:----|:----|
|Kentavious Caldwell-Pope |29  |76 |12.4 |2.8  |3.1  |
|Nikola Jokić             |27  |69 |26.2 |10.5 |12.7 |
|Bruce Brown              |26  |80 |14.6 |4.2  |5.2  |
|Jamal Murray             |25  |65 |21.9 |6.8  |4.3  |
|Aaron Gordon             |27  |68 |19.4 |3.6  |7.8  |
|Michael Porter Jr.       |24  |62 |21.6 |1.3  |6.8  |
|Christian Braun          |21  |76 |11   |1.8  |5.5  |
|Jeff Green               |36  |56 |14.4 |2.3  |4.8  |
|Vlatko Čančar            |25  |60 |12   |3.2  |5.2  |
|Bones Hyland             |22  |42 |22.3 |5.5  |3.8  |

**Total players:** 18

---

## 2.6 team_per_poss()

Get per 100 possessions statistics for a team.


``` r
# Get Bucks 2021 per 100 poss stats
bucks_poss <- team_per_poss("MIL", 2021)
```

```
## Searching team: MIL 2021 (regular season) 
## Success: 22 rows obtained
```

``` r
# Show top 10 players
head(bucks_poss, 10) %>%
  select(Player, Age, G, PTS, AST, TRB) %>%
  kable()
```



|Player                 |Age |G  |PTS  |AST |TRB  |
|:----------------------|:---|:--|:----|:---|:----|
|Khris Middleton        |29  |68 |28.7 |7.7 |8.4  |
|Giannis Antetokounmpo  |26  |61 |40.1 |8.3 |15.7 |
|Jrue Holiday           |30  |59 |25.8 |8.8 |6.6  |
|Brook Lopez            |32  |70 |21.2 |1.2 |8.6  |
|Donte DiVincenzo       |24  |66 |17.8 |5.3 |9.8  |
|Pat Connaughton        |28  |69 |14   |2.4 |9.9  |
|Bobby Portis           |25  |66 |25.8 |2.4 |16   |
|Bryn Forbes            |27  |70 |24.3 |1.6 |3.9  |
|D.J. Augustin          |33  |37 |15   |7.2 |3.3  |
|Thanasis Antetokounmpo |28  |57 |14.1 |3.9 |10.6 |

**Total players:** 22

---

## 2.7 team_shooting()

Get shooting statistics for a team.


``` r
# Get Warriors 2016 shooting stats
warriors_shoot <- team_shooting("GSW", 2016)
```

```
## Searching team: GSW 2016 (regular season) 
## Success: 17 rows obtained
```

``` r
# Show top 10 players
head(warriors_shoot, 10) %>%
  select(Player, Age, G, FGpct, three_Ppct) %>%
  kable()
```



|Player            |Age |G  |FGpct |three_Ppct |
|:-----------------|:---|:--|:-----|:----------|
|Draymond Green    |25  |81 |.490  |.417       |
|Stephen Curry     |27  |79 |.504  |.482       |
|Klay Thompson     |25  |80 |.470  |.419       |
|Harrison Barnes   |23  |66 |.466  |.358       |
|Andre Iguodala    |32  |65 |.478  |.431       |
|Shaun Livingston  |30  |78 |.536  |.250       |
|Andrew Bogut      |31  |70 |.627  |           |
|Leandro Barbosa   |33  |68 |.462  |.500       |
|Brandon Rush      |30  |72 |.427  |.364       |
|Marreese Speights |28  |72 |.432  |.333       |

**Total players:** 17

---

## 2.8 team_pbp()

Get play-by-play statistics for a team.


``` r
# Get Lakers 2020 pbp stats
lakers_pbp <- team_pbp("LAL", 2020)
```

```
## Searching team: LAL 2020 (regular season) 
## Success: 21 rows obtained
```

``` r
# Show top 10 players
head(lakers_pbp, 10) %>%
  select(Player, Age, G) %>%
  kable()
```



|Player                   |Age |G  |
|:------------------------|:---|:--|
|LeBron James             |35  |67 |
|Anthony Davis            |26  |62 |
|Kentavious Caldwell-Pope |26  |69 |
|Danny Green              |32  |68 |
|Kyle Kuzma               |24  |61 |
|Dwight Howard            |34  |69 |
|Avery Bradley            |29  |49 |
|Alex Caruso              |25  |64 |
|JaVale McGee             |32  |68 |
|Rajon Rondo              |33  |48 |

**Total players:** 21

---

## 2.9 team_stats_bulk() - NEW

Get statistics for multiple teams and/or years at once.


``` r
# Compare Finals teams 2020: Lakers vs Heat
finals_2020 <- team_stats_bulk(
  stat_function = team_per_game,
  teams = c("LAL", "MIA"),
  years = 2020,
  season_type = "regular",
  progress = FALSE
)
```

```
## Fetching data for 2 team-season combinations...
## Searching team: LAL 2020 (regular season) 
## Success: 21 rows obtained
## Searching team: MIA 2020 (regular season) 
## Success: 22 rows obtained
## Success: Combined 43 rows from 2 team-seasons
```

``` r
# Show top scorers from each team
finals_2020 %>%
  arrange(team, desc(as.numeric(PTS))) %>%
  group_by(team) %>%
  slice(1:5) %>%
  select(Player, team, G, PTS, AST, TRB) %>%
  kable()
```



|Player        |team |G  |PTS   |AST  |TRB  |
|:-------------|:----|:--|:-----|:----|:----|
|Team Totals   |LAL  |71 |113.4 |25.4 |45.7 |
|Anthony Davis |LAL  |62 |26.1  |3.2  |9.3  |
|LeBron James  |LAL  |67 |25.3  |10.2 |7.8  |
|Kyle Kuzma    |LAL  |61 |12.8  |1.3  |4.5  |
|Dion Waiters  |LAL  |7  |11.9  |2.4  |1.9  |
|Team Totals   |MIA  |73 |112   |25.9 |44.4 |
|Jimmy Butler  |MIA  |58 |19.9  |6    |6.7  |
|Goran Dragić  |MIA  |59 |16.2  |5.1  |3.2  |
|Bam Adebayo   |MIA  |72 |15.9  |5.1  |10.2 |
|Kendrick Nunn |MIA  |67 |15.3  |3.3  |2.7  |

**Total rows:** 43
**Teams:** LAL, MIA

---

### Example: One Team, Multiple Years


``` r
# Get Lakers stats for 3 consecutive years
lakers_3years <- team_stats_bulk(
  stat_function = team_per_game,
  teams = "LAL",
  years = 2022:2024,
  progress = FALSE
)
```

```
## Fetching data for 3 team-season combinations...
## Searching team: LAL 2022 (regular season) 
## Success: 26 rows obtained
## Searching team: LAL 2023 (regular season) 
## Success: 25 rows obtained
## Searching team: LAL 2024 (regular season) 
## Success: 22 rows obtained
## Success: Combined 73 rows from 3 team-seasons
```

``` r
# Show LeBron's stats across these years
lakers_3years %>%
  filter(grepl("James", Player)) %>%
  select(Player, season, G, PTS, AST, TRB) %>%
  kable()
```



|Player       |season |G  |PTS  |AST |TRB |
|:------------|:------|:--|:----|:---|:---|
|LeBron James |2022   |56 |30.3 |6.2 |8.2 |
|LeBron James |2023   |55 |28.9 |6.8 |8.3 |
|LeBron James |2024   |71 |25.7 |8.3 |7.3 |

**Total rows:** 73
**Seasons:** 2022, 2023, 2024

---

# 3. Team Aggregate Functions (Historical)

## 3.1 team_stats_totals()

Get aggregate totals across all seasons in franchise history.


``` r
# Get Warriors historical totals
warriors_history <- team_stats_totals("GSW")
```

```
## Searching team aggregate stats: GSW (totals)
## Success: 83 rows obtained
```

``` r
# Show most recent 10 seasons
head(warriors_history, 10) %>%
  select(Season, Lg, Tm, W, L, Age) %>%
  kable()
```



|Season  |Lg  |Tm  |W  |L  |Age  |
|:-------|:---|:---|:--|:--|:----|
|2025-26 |NBA |GSW |21 |19 |29.3 |
|2024-25 |NBA |GSW |48 |34 |28.6 |
|2023-24 |NBA |GSW |46 |36 |28.4 |
|2022-23 |NBA |GSW |44 |38 |27.3 |
|2021-22 |NBA |GSW |53 |29 |27.6 |
|2020-21 |NBA |GSW |39 |33 |26.7 |
|2019-20 |NBA |GSW |15 |50 |24.4 |
|2018-19 |NBA |GSW |57 |25 |28.4 |
|2017-18 |NBA |GSW |58 |24 |28.8 |
|2016-17 |NBA |GSW |67 |15 |28.2 |

**Total seasons:** 83

---

## 3.2 team_stats_totals() with Year Filter - NEW

Filter aggregate totals to specific years.


``` r
# Get Lakers totals for recent years (2015-2024)
lakers_recent <- team_stats_totals("LAL", years = 2015:2024)
```

```
## Searching team aggregate stats: LAL (totals)
```

```
## Filtered to years: 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 
## Success: 10 rows obtained
```

``` r
# Show all filtered seasons
lakers_recent %>%
  select(Season, Lg, Tm, W, L, Age) %>%
  kable()
```



|Season  |Lg  |Tm  |W  |L  |Age  |
|:-------|:---|:---|:--|:--|:----|
|2023-24 |NBA |LAL |47 |35 |28.0 |
|2022-23 |NBA |LAL |43 |39 |27.9 |
|2021-22 |NBA |LAL |33 |49 |30.2 |
|2020-21 |NBA |LAL |42 |30 |28.2 |
|2019-20 |NBA |LAL |52 |19 |29.5 |
|2018-19 |NBA |LAL |37 |45 |26.2 |
|2017-18 |NBA |LAL |35 |47 |23.7 |
|2016-17 |NBA |LAL |26 |56 |25.1 |
|2015-16 |NBA |LAL |17 |65 |26.5 |
|2014-15 |NBA |LAL |21 |61 |27.0 |

**Filtered seasons:** 10

---

## 3.3 team_stats_per_game()

Get aggregate per game stats across all seasons.


``` r
# Get Celtics historical per game stats
celtics_history <- team_stats_per_game("BOS")
```

```
## Searching team aggregate stats: BOS (per game)
## Success: 83 rows obtained
```

``` r
# Show most recent 10 seasons
head(celtics_history, 10) %>%
  select(Season, Lg, Tm, W, L, Age) %>%
  kable()
```



|Season  |Lg  |Tm  |W  |L  |Age  |
|:-------|:---|:---|:--|:--|:----|
|2025-26 |NBA |BOS |24 |14 |26.7 |
|2024-25 |NBA |BOS |61 |21 |28.9 |
|2023-24 |NBA |BOS |64 |18 |28.2 |
|2022-23 |NBA |BOS |57 |25 |27.4 |
|2021-22 |NBA |BOS |51 |31 |26.1 |
|2020-21 |NBA |BOS |36 |36 |25.1 |
|2019-20 |NBA |BOS |48 |24 |25.3 |
|2018-19 |NBA |BOS |49 |33 |25.7 |
|2017-18 |NBA |BOS |55 |27 |24.7 |
|2016-17 |NBA |BOS |53 |29 |25.9 |

**Total seasons:** 83

---

## 3.4 team_stats_per_game() with Specific Years - NEW

Filter to specific championship years.


``` r
# Get Celtics stats for championship years
celtics_champs <- team_stats_per_game("BOS", years = c(2008, 2024))
```

```
## Searching team aggregate stats: BOS (per game)
```

```
## Filtered to years: 2008, 2024 
## Success: 2 rows obtained
```

``` r
# Show all filtered seasons
celtics_champs %>%
  select(Season, Lg, Tm, W, L, Age) %>%
  kable()
```



|Season  |Lg  |Tm  |W  |L  |Age  |
|:-------|:---|:---|:--|:--|:----|
|2023-24 |NBA |BOS |64 |18 |28.2 |
|2007-08 |NBA |BOS |66 |16 |27.9 |

**Filtered seasons:** 2

---

# 4. League Functions

## 4.1 league_per_game()

Get historical NBA league per game averages.


``` r
# Get league per game averages
league_avg <- league_per_game()
```

```
## Searching league: per_game (regular season) 
## Success: 83 rows obtained
```

``` r
# Show most recent 10 seasons
head(league_avg, 10) %>%
  select(Season, Tm, G, PTS, AST, TRB, FGpct) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Total seasons:** 83

---

## 4.2 league_totals()

Get historical NBA league totals.


``` r
# Get league totals
league_tots <- league_totals()
```

```
## Searching league: totals (regular season) 
## Success: 87 rows obtained
```

``` r
# Show most recent 10 seasons
head(league_tots, 10) %>%
  select(Season, Tm, G, PTS, AST, TRB) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Season` doesn't exist.
```

**Total seasons:** 87

---

## 4.3 league_per_poss()

Get historical NBA league per 100 possessions stats.


``` r
# Get league per 100 poss stats
league_p100 <- league_per_poss()
```

```
## Searching league: per_poss (regular season) 
## Success: 83 rows obtained
```

``` r
# Show most recent 10 seasons
head(league_p100, 10) %>%
  select(Season, Tm, G, PTS, AST, TRB) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Total seasons:** 83

---

# 5. Championship Data

## 5.1 champions()

Get NBA championship history.


``` r
# Get all champions
all_champs <- champions()
```

```
## Obteniendo campeones de NBA...
##   -> Años disponibles: 1947 - 2025 
##   -> Éxito: 88 campeones obtenidos ( 1947 - 2025 )
```

``` r
# Show most recent 10 championships
head(all_champs, 10) %>%
  select(Year, Champion, team) %>%
  kable()
```



| Year|Champion              |team |
|----:|:---------------------|:----|
| 2025|Oklahoma City Thunder |OKC  |
| 2024|Boston Celtics        |BOS  |
| 2023|Denver Nuggets        |DEN  |
| 2022|Golden State Warriors |GSW  |
| 2021|Milwaukee Bucks       |MIL  |
| 2020|Los Angeles Lakers    |LAL  |
| 2019|Toronto Raptors       |TOR  |
| 2018|Golden State Warriors |GSW  |
| 2017|Golden State Warriors |GSW  |
| 2016|Cleveland Cavaliers   |CLE  |

**Total championships:** 88

---

## 5.2 champions() with Year Range

Filter champions to specific years.


``` r
# Get champions from 2010-2020
champs_2010s <- champions(first_year = 2010, last_year = 2020)
```

```
## Obteniendo campeones de NBA...
##   -> Años disponibles: 1947 - 2025 
##   -> Éxito: 11 campeones obtenidos ( 2010 - 2020 )
```

``` r
# Show all
champs_2010s %>%
  select(Year, Champion, team) %>%
  kable()
```



| Year|Champion              |team |
|----:|:---------------------|:----|
| 2020|Los Angeles Lakers    |LAL  |
| 2019|Toronto Raptors       |TOR  |
| 2018|Golden State Warriors |GSW  |
| 2017|Golden State Warriors |GSW  |
| 2016|Cleveland Cavaliers   |CLE  |
| 2015|Golden State Warriors |GSW  |
| 2014|San Antonio Spurs     |SAS  |
| 2013|Miami Heat            |MIA  |
| 2012|Miami Heat            |MIA  |
| 2011|Dallas Mavericks      |DAL  |
| 2010|Los Angeles Lakers    |LAL  |

**Championships in range:** 11

---

# 6. Playoff Statistics Examples

All player and team functions support `season_type = "playoffs"`.

## 6.1 Player Playoff Stats


``` r
# Get LeBron playoff stats
lebron_playoffs <- player_per_game("LeBron James", season_type = "playoffs")
```

```
## Searching player: LeBron James 
## Success: 18 rows obtained
```

``` r
# Show first 10 seasons
head(lebron_playoffs, 10) %>%
  select(Season, Age, Tm, G, PTS, AST, TRB) %>%
  kable()
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `Tm` doesn't exist.
```

**Playoff seasons:** 18

---

## 6.2 Team Playoff Stats


``` r
# Get Lakers 2020 playoff stats
lakers_playoffs <- team_per_game("LAL", 2020, season_type = "playoffs")
```

```
## Searching team: LAL 2020 (playoffs) 
## Success: 16 rows obtained
```

``` r
# Show all players
lakers_playoffs %>%
  select(Player, Age, G, PTS, AST, TRB) %>%
  kable()
```



|Player                   |Age |G  |PTS   |AST  |TRB  |
|:------------------------|:---|:--|:-----|:----|:----|
|Anthony Davis            |26  |21 |27.7  |3.5  |9.7  |
|LeBron James             |35  |21 |27.6  |8.8  |10.8 |
|Kentavious Caldwell-Pope |26  |21 |10.7  |1.3  |2.1  |
|Danny Green              |32  |21 |8     |1.2  |3.1  |
|Rajon Rondo              |33  |16 |8.9   |6.6  |4.3  |
|Alex Caruso              |25  |21 |6.5   |2.8  |2.3  |
|Kyle Kuzma               |24  |21 |10    |0.8  |3.1  |
|Markieff Morris          |30  |21 |5.9   |1    |3    |
|Dwight Howard            |34  |18 |5.8   |0.5  |4.6  |
|JaVale McGee             |32  |14 |2.9   |0.5  |3.1  |
|Talen Horton-Tucker      |19  |2  |7     |0    |2.5  |
|Dion Waiters             |28  |5  |2     |0.4  |0.4  |
|J.R. Smith               |34  |10 |2     |0.3  |0.3  |
|Quinn Cook               |26  |6  |2.2   |0.8  |0.2  |
|Jared Dudley             |34  |9  |0     |0    |0.2  |
|Team Totals              |NA  |21 |112.8 |25.6 |44.1 |

**Playoff roster:** 16

---

# Summary

## Total Functions: 24

### Player Functions (8):
1. `player_per_game()` - Per game stats
2. `player_totals()` - Season totals
3. `player_per_minute()` - Per 36 minutes
4. `player_per_poss()` - Per 100 possessions
5. `player_advanced()` - Advanced stats
6. `player_shooting()` - Shooting by distance
7. `player_pbp()` - Play-by-play
8. `player_stats_bulk()` - **NEW** - Multiple players

### Team Functions (11):
**Season-Specific (8):**
1. `team_per_game()` - Per game stats
2. `team_totals()` - Season totals
3. `team_advanced()` - Advanced stats
4. `team_roster()` - Roster info
5. `team_per_minute()` - Per 36 minutes
6. `team_per_poss()` - Per 100 possessions
7. `team_shooting()` - Shooting stats
8. `team_pbp()` - Play-by-play

**Historical/Aggregate (3):**
9. `team_stats_totals()` - Historical totals (**Enhanced** with year filter)
10. `team_stats_per_game()` - Historical per game (**Enhanced** with year filter)
11. `team_stats_bulk()` - **NEW** - Multiple teams/years

### League Functions (3):
1. `league_per_game()` - League per game averages
2. `league_totals()` - League totals
3. `league_per_poss()` - League per 100 poss

### Championship Data (1):
1. `champions()` - NBA championship history

### Season Type Support
All player and team functions support `season_type` parameter:
- `"regular"` - Regular season (default)
- `"playoffs"` - Postseason

---

# New Features Summary

## 1. Bulk Functions
- `team_stats_bulk()` - Fetch multiple teams/years at once
- `player_stats_bulk()` - Fetch multiple players at once

## 2. Year Filtering
- `team_stats_totals(team, years)` - Filter historical data
- `team_stats_per_game(team, years)` - Filter historical data

## 3. Benefits
- Reduces code repetition
- Automatic data combination
- Progress tracking
- Error handling
- Cleaner analysis workflows
