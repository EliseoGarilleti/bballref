# Obtener estadísticas de liga (función interna)

Función auxiliar para extraer estadísticas históricas de la liga NBA.

## Usage

``` r
obtener_stats_liga(tipo_stats, temporada, pausa = 2)
```

## Arguments

- tipo_stats:

  Tipo de estadística: "per_game", "totals", "per_poss"

- temporada:

  "regular" para temporada regular, "playoffs" para playoffs

- pausa:

  Segundos de pausa entre peticiones (default: 2)

## Value

Dataframe con estadísticas de liga
