# bballref

Herramientas modulares de web scraping para extraer datos de [Basketball Reference](https://www.basketball-reference.com/).

## Instalación

Puedes instalar bballref desde GitHub:
```r
# install.packages("devtools")
devtools::install_github("EliseoGarilleti/bballref")
```

## Funciones principales

### Campeones NBA
- `get_champions()`: Obtener lista histórica de campeones NBA

### Estadísticas de equipos
- `get_team_roster()`: Roster del equipo
- `get_team_per_game()`: Estadísticas por partido
- `get_team_totals()`: Totales de temporada
- `get_team_advanced()`: Estadísticas avanzadas
- `get_team_per_minute()`: Estadísticas por minuto
- `get_team_per_poss()`: Estadísticas por 100 posesiones
- `get_team_shooting()`: Estadísticas de tiro
- `get_team_pbp()`: Estadísticas play-by-play

### Estadísticas de jugadores
- `find_player_id()`: Buscar ID de jugador por nombre
- `get_player_per_game()`: Estadísticas por partido
- `get_player_totals()`: Totales de temporada
- `get_player_per_minute()`: Estadísticas por 36 minutos
- `get_player_per_poss()`: Estadísticas por 100 posesiones
- `get_player_advanced()`: Estadísticas avanzadas
- `get_player_shooting()`: Estadísticas de tiro
- `get_player_pbp()`: Estadísticas play-by-play

### Estadísticas de liga
- `get_league_per_game()`: Promedios de liga por partido
- `get_league_totals()`: Totales de liga
- `get_league_per_poss()`: Estadísticas de liga por 100 posesiones

## Ejemplos de uso

### 1. Obtener campeones históricos
```r
library(bballref)

# Todos los campeones disponibles
todos_campeones <- get_champions()

# Campeones desde 1980 hasta 2023
campeones_modernos <- get_champions(año_inicio = 1980, año_fin = 2023)

# Solo campeones de la década de 2010
campeones_2010s <- get_champions(año_inicio = 2010, año_fin = 2019)
```

### 2. Estadísticas de equipos - Temporada regular
```r
# Roster de Lakers 2020
roster_lal <- get_team_roster("LAL", 2020)

# Totales de temporada regular
totals_lal <- get_team_totals("LAL", 2020)

# Estadísticas por partido
per_game_lal <- get_team_per_game("LAL", 2020)

# Estadísticas avanzadas
advanced_lal <- get_team_advanced("LAL", 2020)
```

### 3. Estadísticas de playoffs
```r
# Totales de playoffs
totals_playoffs <- get_team_totals("LAL", 2020, "playoffs")

# Estadísticas avanzadas de playoffs
advanced_playoffs <- get_team_advanced("LAL", 2020, "playoffs")

# Estadísticas de tiro de playoffs
shooting_playoffs <- get_team_shooting("LAL", 2020, "playoffs")
```

### 4. Estadísticas de jugadores
```r
# Opción 1: Usar el nombre del jugador (¡recomendado!)
lebron_pg <- get_player_per_game("LeBron James")
curry_totals <- get_player_totals("Stephen Curry")

# También funciona con minúsculas
giannis_advanced <- get_player_advanced("giannis antetokounmpo", "playoffs")

# Opción 2: Usar el player_id directamente (más rápido, sin búsqueda)
kd_shooting <- get_player_shooting("duranke01")

# Buscar jugadores por nombre
find_player_id("LeBron James")  # Devuelve: "jamesle01"
find_player_id("james", return_all = TRUE)  # Devuelve todos los jugadores llamados "James"
```

**Nota:** Las funciones aceptan tanto el nombre del jugador como el player_id de Basketball Reference.
Si hay múltiples jugadores con el mismo nombre, se usará el primero encontrado (generalmente el más reciente).

### 5. Análisis comparativo de múltiples equipos
```r
library(purrr)
library(dplyr)

# Códigos de equipos finalistas
equipos <- c("LAL", "MIA")

# Obtener estadísticas de playoffs de ambos equipos
stats_finales_2020 <- map_df(equipos, ~get_team_totals(.x, 2020, "playoffs"))
```

### 6. Análisis histórico de campeones
```r
library(purrr)
library(dplyr)

# Obtener campeones desde 2000
campeones_2000s <- get_champions(año_inicio = 2000)

# Obtener rosters de todos los campeones
rosters_campeones <- map2_df(
  campeones_2000s$team,
  campeones_2000s$Year,
  ~get_team_roster(.x, .y)
)

# Analizar edad promedio de campeones
analisis_edad <- rosters_campeones %>%
  group_by(team, season) %>%
  summarise(edad_promedio = mean(as.numeric(Age), na.rm = TRUE))
```

## Parámetros de las funciones

Todas las funciones de equipos tienen la misma estructura:

```r
get_team_*(team_code, year, season_type = "regular")
```

- `team_code`: Código de 3 letras del equipo (ej: "LAL", "BOS", "CHI")
- `year`: Año de la temporada (ej: 2020)
- `season_type`: Tipo de temporada - "regular" (default) o "playoffs"

## Códigos de equipos comunes

| Equipo | Código |
|--------|--------|
| Los Angeles Lakers | LAL |
| Boston Celtics | BOS |
| Golden State Warriors | GSW |
| Miami Heat | MIA |
| Chicago Bulls | CHI |
| San Antonio Spurs | SAS |

[Ver lista completa](https://www.basketball-reference.com/teams/)

## Encontrar IDs de jugadores

Para usar las funciones de jugadores, necesitas el `player_id` de Basketball Reference:

1. Visita https://www.basketball-reference.com/players/
2. Haz clic en la primera letra del apellido del jugador
3. Busca al jugador en la lista
4. El ID aparece en la URL de su página (ej: `/players/j/jamesle01.html` → `"jamesle01"`)

### Ejemplos de player_id comunes

| Jugador | Player ID |
|---------|-----------|
| LeBron James | jamesle01 |
| Stephen Curry | curryst01 |
| Kevin Durant | duranke01 |
| Giannis Antetokounmpo | antetgi01 |
| Luka Doncic | doncilu01 |
| Nikola Jokic | jokicni01 |

## Contribuir

Pull requests son bienvenidos. Para cambios importantes, abre primero un issue para discutir qué te gustaría cambiar.

## Licencia

[MIT](LICENSE.md)
