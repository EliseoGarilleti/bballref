# Extraer tabla de HTML (visible o comentada)

Extrae una tabla específica de una página HTML de Basketball Reference.
Maneja tanto tablas visibles como tablas comentadas (ocultas en el
código HTML).

## Usage

``` r
extraer_tabla_de_html(url, id_tabla, verbose = TRUE)
```

## Arguments

- url:

  URL completa de la página

- id_tabla:

  ID exacto de la tabla HTML a extraer

- verbose:

  If TRUE, prints extraction progress messages (default: TRUE)

## Value

Dataframe con los datos de la tabla, o NULL si no se encuentra

## Examples

``` r
if (FALSE) { # \dontrun{
url <- "https://www.basketball-reference.com/teams/LAL/2020.html"
roster <- extraer_tabla_de_html(url, "roster")
totals <- extraer_tabla_de_html(url, "totals_stats")
} # }

```
