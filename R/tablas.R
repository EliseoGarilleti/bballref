#' Obtener tabla de estadísticas de un equipo (función interna)
#'
#' Función auxiliar para extraer tablas de estadísticas de equipos NBA desde Basketball Reference.
#' Maneja automáticamente tablas de temporada regular y playoffs.
#'
#' @param codigo_equipo Código de 3 letras del equipo (ej: "LAL", "BOS", "CHI")
#' @param year Año de la temporada (ej: 2020)
#' @param id_tabla Tipo de tabla: "totals_stats", "advanced", "roster", "per_game_stats", etc.
#' @param temporada "regular" para temporada regular, "playoffs" para playoffs
#' @param pausa Segundos de pausa entre peticiones (default: 2)
#'
#' @return Dataframe con datos limpios y columnas de metadata añadidas (team, season, season_type, table_id)
#'
#' @keywords internal
obtener_tabla_equipo <- function(codigo_equipo, year, id_tabla, temporada, pausa = 2) {

  cat("Obteniendo", id_tabla, "(", temporada, ") de", codigo_equipo, year, "\n")

  Sys.sleep(pausa)

  url <- construir_url_bball_ref("equipo_temporada",
                                 list(codigo = codigo_equipo, year = year))

  id_real <- if (temporada == "playoffs") {
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

  # Detectar si la primera fila contiene los encabezados reales
  # Esto pasa cuando hay muchas columnas sin nombre o con nombres genéricos
  nombres_columnas <- names(tabla)
  nombres_vacios <- is.na(nombres_columnas) | nombres_columnas == ""
  proporcion_vacios <- sum(nombres_vacios) / length(nombres_columnas)

  # Si más del 30% de las columnas no tienen nombre, la primera fila probablemente tiene los encabezados
  if (proporcion_vacios > 0.3 && nrow(tabla) > 0) {
    cat("  -> Detectados encabezados en la primera fila, reestructurando tabla\n")
    # Usar la primera fila como nombres de columnas
    nuevos_nombres <- as.character(tabla[1, ])
    tabla <- tabla[-1, ]  # Eliminar la primera fila
    names(tabla) <- nuevos_nombres
    nombres_columnas <- nuevos_nombres
  } else if (any(nombres_vacios)) {
    cat("  -> Arreglando", sum(nombres_vacios), "columnas sin nombre\n")
    nombres_columnas[nombres_vacios] <- paste0("col_", seq_len(sum(nombres_vacios)))
    names(tabla) <- nombres_columnas
  }

  # Hacer nombres únicos
  nombres_columnas <- make.unique(nombres_columnas, sep = "_")
  names(tabla) <- nombres_columnas

  # Limpiar nombres de columnas: reemplazar símbolos problemáticos
  cat("  -> Limpiando nombres de columnas\n")
  nombres_columnas <- gsub("^3P", "three_P", nombres_columnas)
  nombres_columnas <- gsub("^3PA", "three_PA", nombres_columnas)
  nombres_columnas <- gsub("^3P%", "three_Ppct", nombres_columnas)
  nombres_columnas <- gsub("^2P", "two_P", nombres_columnas)
  nombres_columnas <- gsub("^2PA", "two_PA", nombres_columnas)
  nombres_columnas <- gsub("^2P%", "two_Ppct", nombres_columnas)
  nombres_columnas <- gsub("%", "pct", nombres_columnas)
  names(tabla) <- nombres_columnas

  tabla_limpia <- tabla %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
    dplyr::mutate(
      team = codigo_equipo,
      season = as.character(year),
      season_type = temporada,
      table_id = id_tabla
    )

  cat("  -> Éxito:", nrow(tabla_limpia), "filas obtenidas\n")

  return(tabla_limpia)
}
