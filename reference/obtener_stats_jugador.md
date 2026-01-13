# Obtener estadísticas de jugador (función interna)

Función auxiliar para extraer estadísticas de jugadores NBA desde
Basketball Reference.

## Usage

``` r
obtener_stats_jugador(player, tipo_stats, temporada, pausa = 2)
```

## Arguments

- player:

  Nombre del jugador o ID del jugador en Basketball Reference (ej:
  "LeBron James" o "jamesle01")

- tipo_stats:

  Tipo de estadística: "per_game_stats", "totals_stats",
  "per_minute_stats", etc.

- temporada:

  "regular" para temporada regular, "playoffs" para playoffs

- pausa:

  Segundos de pausa entre peticiones (default: 2)

## Value

Dataframe con estadísticas del jugador
