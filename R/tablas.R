#' Obtener tabla de estadísticas de un equipo
#'
#' Función principal para extraer tablas de estadísticas de equipos NBA desde Basketball Reference.
#' Maneja automáticamente tablas de temporada regular y playoffs.
#'
#' @param codigo_equipo Código de 3 letras del equipo (ej: "LAL", "BOS", "CHI")
#' @param year Año de la temporada (ej: 2020)
#' @param id_tabla Tipo de tabla: "totals_stats", "advanced", "roster", "per_game_stats", etc.
#' @param temporada "regular" para temporada regular, "post" para playoffs
#' @param pausa Segundos de pausa entre peticiones (default: 2)
#'
#' @return Dataframe con datos limpios y columnas de metadata añadidas (team, season, temporada_tipo, id_tabla)
#'
#' @examples
#' \dontrun{
#' # Estadísticas totales de Lakers 2020 (temporada regular)
#' totals_regular <- obtener_tabla_equipo("LAL", 2020, "totals_stats", "regular")
#'
#' # Estadísticas avanzadas de playoffs
#' advanced_playoffs <- obtener_tabla_equipo("LAL", 2020, "advanced", "post")
#'
#' # Roster del equipo
#' roster <- obtener_tabla_equipo("LAL", 2020, "roster", "regular")
#' }
#'
#' @export
obtener_tabla_equipo <- function(codigo_equipo, year, id_tabla, temporada, pausa = 2) {

  cat("Obteniendo", id_tabla, "(", temporada, ") de", codigo_equipo, year, "\n")

  Sys.sleep(pausa)

  url <- construir_url_bball_ref("equipo_temporada",
                                 list(codigo = codigo_equipo, year = year))

  id_real <- if (temporada == "post") {
    paste0(id_tabla, "_post")
  } else {
    id_tabla
  }

  cat("  -> ID de tabla a buscar:", id_real, "\n")

  tabla <- tryCatch({
    extraer_tabla_de_html(url, id_real)
  }, error = function(e) {
    cat("  -> Error al extraer tabla:", e$message, "\n")
    return(NULL)
  })

  if (is.null(tabla)) {
    cat("  -> No se pudo obtener la tabla\n")
    return(NULL)
  }

  tabla_limpia <- tabla %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
    dplyr::mutate(
      team = codigo_equipo,
      season = as.character(year),
      temporada_tipo = temporada,
      id_tabla = id_tabla
    )

  cat("  -> Éxito:", nrow(tabla_limpia), "filas obtenidas\n")

  return(tabla_limpia)
}
