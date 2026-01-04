#' Construir URLs de Basketball Reference
#'
#' Función genérica para construir URLs de diferentes secciones de Basketball Reference
#'
#' @param tipo Tipo de URL: "equipo_temporada", "jugador", "temporada_stats", "playoffs"
#' @param parametros Lista con parámetros necesarios según el tipo
#'
#' @return String con la URL completa
#'
#' @examples
#' \dontrun{
#' url <- construir_url_bball_ref("equipo_temporada", list(codigo = "LAL", year = 2020))
#' }
#'
#' @export
construir_url_bball_ref <- function(tipo, parametros) {

  base_url <- "https://www.basketball-reference.com"

  switch(tipo,
         "equipo_temporada" = glue::glue("{base_url}/teams/{parametros$codigo}/{parametros$year}.html"),
         "jugador" = glue::glue("{base_url}/players/{parametros$letra}/{parametros$id}.html"),
         "temporada_stats" = glue::glue("{base_url}/leagues/NBA_{parametros$year}_{parametros$tipo_stats}.html"),
         "playoffs" = glue::glue("{base_url}/playoffs/NBA_{parametros$year}.html")
  )
}
