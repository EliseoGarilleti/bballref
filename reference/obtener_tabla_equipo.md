# Obtener tabla de estadísticas de un equipo (función interna)

Función auxiliar para extraer tablas de estadísticas de equipos NBA
desde Basketball Reference. Maneja automáticamente tablas de temporada
regular y playoffs.

## Usage

``` r
obtener_tabla_equipo(codigo_equipo, year, id_tabla, temporada, pausa = 2)
```

## Arguments

- codigo_equipo:

  Código de 3 letras del equipo (ej: "LAL", "BOS", "CHI")

- year:

  Año de la temporada (ej: 2020)

- id_tabla:

  Tipo de tabla: "totals_stats", "advanced", "roster", "per_game_stats",
  etc.

- temporada:

  "regular" para temporada regular, "playoffs" para playoffs

- pausa:

  Segundos de pausa entre peticiones (default: 2)

## Value

Dataframe con datos limpios y columnas de metadata añadidas (team,
season, season_type, table_id)
