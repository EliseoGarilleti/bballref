#' Get team aggregate totals across all seasons
#'
#' Extract aggregate total statistics for a specific NBA team across all seasons
#' or a specific range of seasons. This shows the team's cumulative totals.
#'
#' @param team_code 3-letter team code (e.g., "LAL", "BOS", "ATL")
#' @param years Numeric vector of years to filter (optional). If NULL, returns all seasons.
#'   Can be a range (e.g., 2015:2024) or specific years (e.g., c(2020, 2022, 2024))
#'
#' @return Dataframe with team aggregate totals across specified seasons
#'
#' @examples
#' \dontrun{
#' # Get Lakers aggregate totals (all seasons)
#' lakers_total <- team_stats_totals("LAL")
#'
#' # Get Lakers totals for specific years
#' lakers_recent <- team_stats_totals("LAL", years = 2015:2024)
#'
#' # Get Celtics totals for selected seasons
#' celtics_selected <- team_stats_totals("BOS", years = c(2008, 2010, 2020))
#' }
#'
#' @export
team_stats_totals <- function(team_code, years = NULL) {

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

  # Filtrar por años si se especifica
  if (!is.null(years)) {
    # Extraer año de la columna Season (formato: "2019-20" -> 2020)
    if ("Season" %in% names(tabla_limpia)) {
      tabla_limpia <- tabla_limpia %>%
        dplyr::mutate(
          year_end = dplyr::case_when(
            # Formato "2019-20" -> extraer último número y convertir a año completo
            stringr::str_detect(Season, "^[0-9]{4}-[0-9]{2}$") ~
              as.numeric(paste0("20", stringr::str_extract(Season, "[0-9]{2}$"))),
            # Si ya es un año de 4 dígitos, usarlo directamente
            stringr::str_detect(Season, "^[0-9]{4}$") ~ as.numeric(Season),
            # Default: NA
            TRUE ~ NA_real_
          )
        ) %>%
        dplyr::filter(!is.na(year_end), year_end %in% years) %>%
        dplyr::select(-year_end)

      cat("Filtered to years:", paste(years, collapse = ", "), "\n")
    }
  }

  cat("Success:", nrow(tabla_limpia), "rows obtained\n")

  return(tabla_limpia)
}

#' Get team aggregate per game stats across all seasons
#'
#' Extract aggregate per game statistics for a specific NBA team across all seasons
#' or a specific range of seasons. This shows the team's average per game stats.
#'
#' @param team_code 3-letter team code (e.g., "LAL", "BOS", "ATL")
#' @param years Numeric vector of years to filter (optional). If NULL, returns all seasons.
#'   Can be a range (e.g., 2015:2024) or specific years (e.g., c(2020, 2022, 2024))
#'
#' @return Dataframe with team aggregate per game stats across specified seasons
#'
#' @examples
#' \dontrun{
#' # Get Lakers aggregate per game stats (all seasons)
#' lakers_pg <- team_stats_per_game("LAL")
#'
#' # Get Lakers per game stats for recent years
#' lakers_recent <- team_stats_per_game("LAL", years = 2015:2024)
#'
#' # Get Celtics per game stats for selected seasons
#' celtics_selected <- team_stats_per_game("BOS", years = c(2008, 2010, 2020))
#' }
#'
#' @export
team_stats_per_game <- function(team_code, years = NULL) {

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

  # Filtrar por años si se especifica
  if (!is.null(years)) {
    # Extraer año de la columna Season (formato: "2019-20" -> 2020)
    if ("Season" %in% names(tabla_limpia)) {
      tabla_limpia <- tabla_limpia %>%
        dplyr::mutate(
          year_end = dplyr::case_when(
            # Formato "2019-20" -> extraer último número y convertir a año completo
            stringr::str_detect(Season, "^[0-9]{4}-[0-9]{2}$") ~
              as.numeric(paste0("20", stringr::str_extract(Season, "[0-9]{2}$"))),
            # Si ya es un año de 4 dígitos, usarlo directamente
            stringr::str_detect(Season, "^[0-9]{4}$") ~ as.numeric(Season),
            # Default: NA
            TRUE ~ NA_real_
          )
        ) %>%
        dplyr::filter(!is.na(year_end), year_end %in% years) %>%
        dplyr::select(-year_end)

      cat("Filtered to years:", paste(years, collapse = ", "), "\n")
    }
  }

  cat("Success:", nrow(tabla_limpia), "rows obtained\n")

  return(tabla_limpia)
}
