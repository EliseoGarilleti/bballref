#' Get NBA player per game stats
#'
#' Extract per game statistics for a specific NBA player.
#'
#' @param player Player name (e.g., "LeBron James") or Basketball Reference player ID (e.g., "jamesle01")
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with player per game stats across all seasons
#'
#' @examples
#' \dontrun{
#' # Using player name
#' lebron_pg <- get_player_per_game("LeBron James")
#'
#' # Using player ID
#' lebron_pg <- get_player_per_game("jamesle01")
#'
#' # Get playoff per game stats
#' lebron_pg_playoffs <- get_player_per_game("LeBron James", "playoffs")
#' }
#'
#' @export
get_player_per_game <- function(player, season_type = "regular") {
  obtener_stats_jugador(player, "per_game_stats", season_type)
}

#' Get NBA player totals
#'
#' Extract total statistics for a specific NBA player.
#'
#' @param player Player name (e.g., "LeBron James") or Basketball Reference player ID (e.g., "jamesle01")
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with player totals across all seasons
#'
#' @examples
#' \dontrun{
#' # Get LeBron James regular season totals
#' lebron_totals <- get_player_totals("jamesle01")
#'
#' # Get playoff totals
#' lebron_totals_playoffs <- get_player_totals("jamesle01", "playoffs")
#' }
#'
#' @export
get_player_totals <- function(player, season_type = "regular") {
  obtener_stats_jugador(player, "totals_stats", season_type)
}

#' Get NBA player per 36 minutes stats
#'
#' Extract per 36 minutes statistics for a specific NBA player.
#'
#' @param player Player name (e.g., "LeBron James") or Basketball Reference player ID (e.g., "jamesle01")
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with player per 36 minutes stats across all seasons
#'
#' @examples
#' \dontrun{
#' # Get LeBron James regular season per 36 stats
#' lebron_per36 <- get_player_per_minute("jamesle01")
#'
#' # Get playoff per 36 stats
#' lebron_per36_playoffs <- get_player_per_minute("jamesle01", "playoffs")
#' }
#'
#' @export
get_player_per_minute <- function(player, season_type = "regular") {
  obtener_stats_jugador(player, "per_minute_stats", season_type)
}

#' Get NBA player per 100 possessions stats
#'
#' Extract per 100 possessions statistics for a specific NBA player.
#'
#' @param player Player name (e.g., "LeBron James") or Basketball Reference player ID (e.g., "jamesle01")
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with player per 100 possessions stats across all seasons
#'
#' @examples
#' \dontrun{
#' # Get LeBron James regular season per 100 poss stats
#' lebron_per_poss <- get_player_per_poss("jamesle01")
#'
#' # Get playoff per 100 poss stats
#' lebron_per_poss_playoffs <- get_player_per_poss("jamesle01", "playoffs")
#' }
#'
#' @export
get_player_per_poss <- function(player, season_type = "regular") {
  obtener_stats_jugador(player, "per_poss", season_type)
}

#' Get NBA player advanced stats
#'
#' Extract advanced statistics for a specific NBA player.
#'
#' @param player Player name (e.g., "LeBron James") or Basketball Reference player ID (e.g., "jamesle01")
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with player advanced stats across all seasons
#'
#' @examples
#' \dontrun{
#' # Get LeBron James regular season advanced stats
#' lebron_advanced <- get_player_advanced("jamesle01")
#'
#' # Get playoff advanced stats
#' lebron_advanced_playoffs <- get_player_advanced("jamesle01", "playoffs")
#' }
#'
#' @export
get_player_advanced <- function(player, season_type = "regular") {
  obtener_stats_jugador(player, "advanced", season_type)
}

#' Get NBA player shooting stats
#'
#' Extract shooting statistics for a specific NBA player.
#'
#' @param player Player name (e.g., "LeBron James") or Basketball Reference player ID (e.g., "jamesle01")
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with player shooting stats across all seasons
#'
#' @examples
#' \dontrun{
#' # Get LeBron James regular season shooting stats
#' lebron_shooting <- get_player_shooting("jamesle01")
#'
#' # Get playoff shooting stats
#' lebron_shooting_playoffs <- get_player_shooting("jamesle01", "playoffs")
#' }
#'
#' @export
get_player_shooting <- function(player, season_type = "regular") {
  obtener_stats_jugador(player, "shooting", season_type)
}

#' Get NBA player play-by-play stats
#'
#' Extract play-by-play statistics for a specific NBA player.
#'
#' @param player Player name (e.g., "LeBron James") or Basketball Reference player ID (e.g., "jamesle01")
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with player play-by-play stats across all seasons
#'
#' @examples
#' \dontrun{
#' # Get LeBron James regular season pbp stats
#' lebron_pbp <- get_player_pbp("jamesle01")
#'
#' # Get playoff pbp stats
#' lebron_pbp_playoffs <- get_player_pbp("jamesle01", "playoffs")
#' }
#'
#' @export
get_player_pbp <- function(player, season_type = "regular") {
  obtener_stats_jugador(player, "pbp_stats", season_type)
}

#' Obtener estadísticas de jugador (función interna)
#'
#' Función auxiliar para extraer estadísticas de jugadores NBA desde Basketball Reference.
#'
#' @param player Nombre del jugador o ID del jugador en Basketball Reference (ej: "LeBron James" o "jamesle01")
#' @param tipo_stats Tipo de estadística: "per_game_stats", "totals_stats", "per_minute_stats", etc.
#' @param temporada "regular" para temporada regular, "playoffs" para playoffs
#' @param pausa Segundos de pausa entre peticiones (default: 2)
#'
#' @return Dataframe con estadísticas del jugador
#'
#' @keywords internal
obtener_stats_jugador <- function(player, tipo_stats, temporada, pausa = 2) {

  # Detectar si es un nombre (contiene espacio o mayúsculas en medio) o un ID
  # Los IDs son típicamente todo minúsculas sin espacios (ej: "jamesle01")
  # Los nombres tienen espacios o mayúsculas (ej: "LeBron James" o "lebron james")
  es_nombre <- grepl("\\s", player) || grepl("[A-Z]", player)

  player_id <- player

  if (es_nombre) {
    cat("Detectado nombre de jugador. Buscando ID...\n")
    player_id <- find_player_id(player)

    if (is.null(player_id)) {
      cat("  -> No se pudo encontrar el jugador:", player, "\n")
      return(NULL)
    }

    cat("  -> ID encontrado:", player_id, "\n")
  }

  cat("Obteniendo estadísticas de jugador:", player_id, "-", tipo_stats, "(", temporada, ")\n")

  Sys.sleep(pausa)

  # Construir URL (jugadores se organizan por primera letra del apellido)
  primera_letra <- substr(player_id, 1, 1)
  url <- glue::glue("https://www.basketball-reference.com/players/{primera_letra}/{player_id}.html")

  # Determinar ID de tabla
  id_tabla <- if (temporada == "playoffs") {
    paste0(tipo_stats, "_post")
  } else {
    tipo_stats
  }

  cat("  -> URL:", url, "\n")
  cat("  -> ID de tabla:", id_tabla, "\n")

  # Extraer tabla
  tabla <- tryCatch({
    extraer_tabla_de_html(url, id_tabla)
  }, error = function(e) {
    cat("  -> Error al extraer tabla:", e$message, "\n")
    return(NULL)
  })

  if (is.null(tabla)) {
    cat("  -> No se pudo obtener la tabla\n")
    return(NULL)
  }

  # Detectar si la primera fila contiene los encabezados reales
  nombres_columnas <- names(tabla)
  nombres_vacios <- is.na(nombres_columnas) | nombres_columnas == ""
  proporcion_vacios <- sum(nombres_vacios) / length(nombres_columnas)

  # Verificar si la primera fila parece contener encabezados
  primera_fila_es_header <- FALSE
  if (nrow(tabla) > 0 && proporcion_vacios > 0.2) {
    primera_fila <- as.character(tabla[1, ])
    # Patrón para detectar encabezados típicos de stats de jugadores
    patron_header <- "^(Rk|Season|Age|Tm|Lg|Pos|G|GS|MP|FG|FGA|FG%|3P|3PA|3P%|2P|2PA|2P%|eFG%|FT|FTA|FT%|ORB|DRB|TRB|AST|STL|BLK|TOV|PF|PTS|[A-Z]{1,5}%?|Awards)$"
    valores_header <- sum(grepl(patron_header, primera_fila), na.rm = TRUE)

    if (valores_header > length(nombres_columnas) * 0.3) {
      primera_fila_es_header <- TRUE
    }
  }

  # Si la primera fila contiene encabezados, usarla y eliminarla de los datos
  if (primera_fila_es_header) {
    cat("  -> Detectados encabezados en la primera fila, reestructurando tabla\n")
    nuevos_nombres <- as.character(tabla[1, ])
    tabla <- tabla[-1, ]
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

  # Limpiar y procesar tabla
  # Las tablas de jugadores suelen tener filas de totales ("Career", "Did Not Play", etc.)
  tabla_limpia <- tabla %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character))

  # Filtrar filas que no son temporadas válidas
  # Las temporadas válidas tienen formato "YYYY-YY" (ej: "2023-24")
  if ("Season" %in% names(tabla_limpia)) {
    filas_antes <- nrow(tabla_limpia)
    tabla_limpia <- tabla_limpia %>%
      dplyr::filter(grepl("^\\d{4}-\\d{2}$", Season))
    filas_despues <- nrow(tabla_limpia)

    if (filas_antes > filas_despues) {
      cat("  -> Eliminadas", filas_antes - filas_despues, "filas no válidas (totales/resúmenes)\n")
    }
  }

  # Agregar metadatos
  tabla_limpia <- tabla_limpia %>%
    dplyr::mutate(
      player_id = player_id,
      stat_type = tipo_stats,
      season_type = temporada
    )

  cat("  -> Éxito:", nrow(tabla_limpia), "temporadas obtenidas\n")

  return(tabla_limpia)
}
