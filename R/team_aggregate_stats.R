#' Get team aggregate totals across all seasons
#'
#' Extract aggregate total statistics for a specific NBA team across all seasons.
#' This shows the team's cumulative totals from all seasons combined.
#'
#' @param team_code 3-letter team code (e.g., "LAL", "BOS", "ATL")
#'
#' @return Dataframe with team aggregate totals across all seasons
#'
#' @examples
#' \dontrun{
#' # Get Lakers aggregate totals
#' lakers_total <- team_stats_totals("LAL")
#'
#' # Get Celtics aggregate totals
#' celtics_total <- team_stats_totals("BOS")
#' }
#'
#' @export
team_stats_totals <- function(team_code) {

  cat("Searching team aggregate stats:", team_code, "(totals)\n")

  Sys.sleep(2)

  url <- glue::glue("https://www.basketball-reference.com/teams/{team_code}/stats_basic_totals.html")

  tabla <- tryCatch({
    extraer_tabla_de_html(url, "stats", verbose = FALSE)
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

  # Si más del 30% de las columnas no tienen nombre, la primera fila probablemente tiene los encabezados
  if (proporcion_vacios > 0.3 && nrow(tabla) > 0) {
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

  tabla_limpia <- tabla %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
    dplyr::mutate(
      team = team_code,
      stat_type = "aggregate_totals"
    )

  cat("Success:", nrow(tabla_limpia), "rows obtained\n")

  return(tabla_limpia)
}

#' Get team aggregate per game stats across all seasons
#'
#' Extract aggregate per game statistics for a specific NBA team across all seasons.
#' This shows the team's average per game stats from all seasons combined.
#'
#' @param team_code 3-letter team code (e.g., "LAL", "BOS", "ATL")
#'
#' @return Dataframe with team aggregate per game stats across all seasons
#'
#' @examples
#' \dontrun{
#' # Get Lakers aggregate per game stats
#' lakers_pg <- team_stats_per_game("LAL")
#'
#' # Get Celtics aggregate per game stats
#' celtics_pg <- team_stats_per_game("BOS")
#' }
#'
#' @export
team_stats_per_game <- function(team_code) {

  cat("Searching team aggregate stats:", team_code, "(per game)\n")

  Sys.sleep(2)

  url <- glue::glue("https://www.basketball-reference.com/teams/{team_code}/stats_per_game_totals.html")

  tabla <- tryCatch({
    extraer_tabla_de_html(url, "stats", verbose = FALSE)
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

  # Si más del 30% de las columnas no tienen nombre, la primera fila probablemente tiene los encabezados
  if (proporcion_vacios > 0.3 && nrow(tabla) > 0) {
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

  tabla_limpia <- tabla %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
    dplyr::mutate(
      team = team_code,
      stat_type = "aggregate_per_game"
    )

  cat("Success:", nrow(tabla_limpia), "rows obtained\n")

  return(tabla_limpia)
}
