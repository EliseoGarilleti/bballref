# bballref

Herramientas de web scraping para Basketball Reference.

## Instalación

Puedes instalar bballref desde GitHub:
```r
# install.packages("devtools")
devtools::install_github("tu_usuario_github/bballref")
```

## Uso
```r
library(bballref)

# Obtener campeones históricos
campeones <- get_champions(año_inicio = 1980, año_fin = 2023)

# Obtener estadísticas de un equipo
totals_lal <- obtener_tabla_equipo(
  codigo_equipo = "LAL",
  year = 2020,
  id_tabla = "totals_stats",
  temporada = "regular"
)

# Estadísticas de playoffs
playoffs_lal <- obtener_tabla_equipo(
  codigo_equipo = "LAL",
  year = 2020,
  id_tabla = "advanced",
  temporada = "post"
)
```

## Licencia

MIT
