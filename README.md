# bballref

Herramientas modulares de web scraping para extraer datos de [Basketball Reference](https://www.basketball-reference.com/).

## Instalación

Puedes instalar bballref desde GitHub:
```r
# install.packages("devtools")
devtools::install_github("EliseoGarilleti/bballref")
```

## Funciones principales

- `get_champions()`: Obtener lista histórica de campeones NBA
- `obtener_tabla_equipo()`: Extraer estadísticas de equipos por temporada
- `extraer_tabla_de_html()`: Función de bajo nivel para extraer tablas específicas
- `construir_url_bball_ref()`: Construir URLs de Basketball Reference

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
roster_lal <- obtener_tabla_equipo(
  codigo_equipo = "LAL",
  year = 2020,
  id_tabla = "roster",
  temporada = "regular"
)

# Totales de temporada regular
totals_lal <- obtener_tabla_equipo(
  codigo_equipo = "LAL",
  year = 2020,
  id_tabla = "totals_stats",
  temporada = "regular"
)

# Estadísticas por partido
per_game_lal <- obtener_tabla_equipo(
  codigo_equipo = "LAL",
  year = 2020,
  id_tabla = "per_game_stats",
  temporada = "regular"
)

# Estadísticas avanzadas
advanced_lal <- obtener_tabla_equipo(
  codigo_equipo = "LAL",
  year = 2020,
  id_tabla = "advanced",
  temporada = "regular"
)
```

### 3. Estadísticas de playoffs
```r
# Totales de playoffs
totals_playoffs <- obtener_tabla_equipo(
  codigo_equipo = "LAL",
  year = 2020,
  id_tabla = "totals_stats",
  temporada = "post"
)

# Estadísticas avanzadas de playoffs
advanced_playoffs <- obtener_tabla_equipo(
  codigo_equipo = "LAL",
  year = 2020,
  id_tabla = "advanced",
  temporada = "post"
)
```

### 4. Análisis comparativo de múltiples equipos
```r
library(purrr)
library(dplyr)

# Códigos de equipos finalistas
equipos <- c("LAL", "MIA")

# Obtener estadísticas de ambos equipos
stats_finales_2020 <- map_df(equipos, ~obtener_tabla_equipo(
  codigo_equipo = .x,
  year = 2020,
  id_tabla = "totals_stats",
  temporada = "post"
))
```

### 5. Análisis histórico de campeones
```r
library(purrr)
library(dplyr)

# Obtener campeones desde 2000
campeones_2000s <- get_champions(año_inicio = 2000)

# Obtener rosters de todos los campeones
rosters_campeones <- map2_df(
  campeones_2000s$codigo_equipo,
  campeones_2000s$Year,
  ~obtener_tabla_equipo(
    codigo_equipo = .x,
    year = .y,
    id_tabla = "roster",
    temporada = "regular"
  )
)

# Analizar edad promedio de campeones
analisis_edad <- rosters_campeones %>%
  group_by(team, season) %>%
  summarise(edad_promedio = mean(as.numeric(Age), na.rm = TRUE))
```

## Tablas disponibles

### Tablas visibles (no requieren descomentado HTML):
- `roster`: Información básica de jugadores
- `per_game_stats`: Estadísticas por partido
- `per_minute_stats`: Estadísticas por minuto

### Tablas comentadas (extraídas automáticamente):
- `totals_stats`: Totales de temporada
- `advanced`: Estadísticas avanzadas
- `per_poss`: Per 100 posesiones
- `shooting`: Estadísticas de tiro
- `pbp_stats`: Play-by-play

**Nota:** Añade `_post` al `id_tabla` para obtener estadísticas de playoffs (ej: `totals_stats_post`).

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

## Contribuir

Pull requests son bienvenidos. Para cambios importantes, abre primero un issue para discutir qué te gustaría cambiar.

## Licencia

[MIT](LICENSE.md)
