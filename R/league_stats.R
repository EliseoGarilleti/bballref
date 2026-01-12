#' Get NBA league averages per game
#'
#' Extract historical NBA league averages per game statistics.
#'
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with league averages per game across all seasons
#'
#' @examples
#' \dontrun{
#' # Get regular season league averages
#' league_per_game <- league_per_game()
#'
#' # Get playoff league averages
#' league_per_game_playoffs <- league_per_game("playoffs")
#' }
#'
#' @export
league_per_game <- function(season_type = "regular") {
  obtener_stats_liga("per_game", season_type)
}

#' Get NBA league totals
#'
#' Extract historical NBA league totals statistics.
#'
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with league totals across all seasons
#'
#' @examples
#' \dontrun{
#' # Get regular season league totals
#' league_totals <- league_totals()
#'
#' # Get playoff league totals
#' league_totals_playoffs <- league_totals("playoffs")
#' }
#'
#' @export
league_totals <- function(season_type = "regular") {
  obtener_stats_liga("totals", season_type)
}

#' Get NBA league per 100 possessions stats
#'
#' Extract historical NBA league per 100 possessions statistics.
#'
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with league per 100 possessions stats across all seasons
#'
#' @examples
#' \dontrun{
#' # Get regular season per 100 poss stats
#' league_per_poss <- league_per_poss()
#'
#' # Get playoff per 100 poss stats
#' league_per_poss_playoffs <- league_per_poss("playoffs")
#' }
#'
#' @export
league_per_poss <- function(season_type = "regular") {
  obtener_stats_liga("per_poss", season_type)
}

#' Obtener estadísticas de liga (función interna)
#'
#' Función auxiliar para extraer estadísticas históricas de la liga NBA.
#'
#' @param tipo_stats Tipo de estadística: "per_game", "totals", "per_poss"
#' @param temporada "regular" para temporada regular, "playoffs" para playoffs
#' @param pausa Segundos de pausa entre peticiones (default: 2)
#'
#' @return Dataframe con estadísticas de liga
#'
#' @keywords internal
obtener_stats_liga <- function(tipo_stats, temporada, pausa = 2) {

  season_label <- if (temporada == "playoffs") "playoffs" else "regular season"
  cat("Searching league:", tipo_stats, paste0("(", season_label, ")"), "\n")

  Sys.sleep(pausa)

  # Construir URL
  url <- glue::glue("https://www.basketball-reference.com/leagues/NBA_stats_{tipo_stats}.html")

  # Determinar ID de tabla
  id_tabla <- if (temporada == "playoffs") {
    "stats-Playoffs"
  } else {
    "stats-Regular-Season"
  }

  # Extraer tabla
  tabla <- tryCatch({
    extraer_tabla_de_html(url, id_tabla, verbose = FALSE)
  }, error = function(e) {
    cat("Error: Could not extract table\n")
    return(NULL)
  })

  if (is.null(tabla)) {
    cat("Error: Table not found\n")
    return(NULL)
  }

  # Detectar si la primera fila contiene los encabezados reales
  nombres_columnas <- names(tabla)
  nombres_vacios <- is.na(nombres_columnas) | nombres_columnas == ""
  proporcion_vacios <- sum(nombres_vacios) / length(nombres_columnas)

  # Verificar si la primera fila parece contener encabezados
  # (strings cortos, palabras en mayúscula, típicos de encabezados)
  primera_fila_es_header <- FALSE
  if (nrow(tabla) > 0 && proporcion_vacios > 0.2) {
    primera_fila <- as.character(tabla[1, ])
    # Contar cuántos valores en la primera fila parecen encabezados
    # (cortos, con mayúsculas, o palabras comunes de stats)
    patron_header <- "^(Rk|Season|Lg|Age|Ht|Wt|[A-Z]{1,5}%?|G|MP|FG|FGA|[A-Z]+)$"
    valores_header <- sum(grepl(patron_header, primera_fila), na.rm = TRUE)

    if (valores_header > length(nombres_columnas) * 0.3) {
      primera_fila_es_header <- TRUE
    }
  }

  # Si la primera fila contiene encabezados, usarla y eliminarla de los datos
  if (primera_fila_es_header) {
    # Usar la primera fila como nombres de columnas
    nuevos_nombres <- as.character(tabla[1, ])
    tabla <- tabla[-1, ]  # Eliminar la primera fila
    names(tabla) <- nuevos_nombres
    nombres_columnas <- nuevos_nombres
  } else if (any(nombres_vacios)) {
    nombres_columnas[nombres_vacios] <- paste0("col_", seq_len(sum(nombres_vacios)))
    names(tabla) <- nombres_columnas
  }

  # Hacer nombres únicos
  nombres_columnas <- make.unique(nombres_columnas, sep = "_")
  names(tabla) <- nombres_columnas

  # Limpiar nombres de columnas: reemplazar símbolos problemáticos
  nombres_columnas <- gsub("^3P", "three_P", nombres_columnas)
  nombres_columnas <- gsub("^3PA", "three_PA", nombres_columnas)
  nombres_columnas <- gsub("^3P%", "three_Ppct", nombres_columnas)
  nombres_columnas <- gsub("^2P", "two_P", nombres_columnas)
  nombres_columnas <- gsub("^2PA", "two_PA", nombres_columnas)
  nombres_columnas <- gsub("^2P%", "two_Ppct", nombres_columnas)
  nombres_columnas <- gsub("%", "pct", nombres_columnas)
  names(tabla) <- nombres_columnas

  # Limpiar y procesar tabla
  # Las tablas de liga suelen tener filas de encabezado repetidas
  # Intentar filtrar por la columna Season si existe
  if ("Season" %in% names(tabla)) {
    tabla_limpia <- tabla %>%
      dplyr::filter(!grepl("^Season$|^Lg$", Season, ignore.case = TRUE))  # Eliminar filas de encabezado repetidas
  } else {
    # Si no hay columna Season, usar la primera columna
    primera_col <- names(tabla)[1]
    tabla_limpia <- tabla %>%
      dplyr::filter(!grepl("^Season$|^Lg$", .data[[primera_col]], ignore.case = TRUE))
  }

  tabla_limpia <- tabla_limpia %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
    dplyr::mutate(
      stat_type = tipo_stats,
      season_type = temporada
    )

  cat("Success:", nrow(tabla_limpia), "rows obtained\n")

  return(tabla_limpia)
}
