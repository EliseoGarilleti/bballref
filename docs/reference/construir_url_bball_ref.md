# Construir URLs de Basketball Reference

Función genérica para construir URLs de diferentes secciones de
Basketball Reference

## Usage

``` r
construir_url_bball_ref(tipo, parametros)
```

## Arguments

- tipo:

  Tipo de URL: "equipo_temporada", "jugador", "temporada_stats",
  "playoffs"

- parametros:

  Lista con parámetros necesarios según el tipo

## Value

String con la URL completa

## Examples

``` r
if (FALSE) { # \dontrun{
url <- construir_url_bball_ref("equipo_temporada", list(codigo = "LAL", year = 2020))
} # }
```
