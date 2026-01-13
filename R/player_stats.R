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
#' lebron_pg <- player_per_game("LeBron James")
#'
#' # Using player ID
#' lebron_pg <- player_per_game("jamesle01")
#'
#' # Get playoff per game stats
#' lebron_pg_playoffs <- player_per_game("LeBron James", "playoffs")
#' }
#'
#' @export
player_per_game <- function(player, season_type = "regular") {
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
#' lebron_totals <- player_totals("jamesle01")
#'
#' # Get playoff totals
#' lebron_totals_playoffs <- player_totals("jamesle01", "playoffs")
#' }
#'
#' @export
player_totals <- function(player, season_type = "regular") {
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
#' lebron_per36 <- player_per_minute("jamesle01")
#'
#' # Get playoff per 36 stats
#' lebron_per36_playoffs <- player_per_minute("jamesle01", "playoffs")
#' }
#'
#' @export
player_per_minute <- function(player, season_type = "regular") {
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
#' lebron_per_poss <- player_per_poss("jamesle01")
#'
#' # Get playoff per 100 poss stats
#' lebron_per_poss_playoffs <- player_per_poss("jamesle01", "playoffs")
#' }
#'
#' @export
player_per_poss <- function(player, season_type = "regular") {
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
#' lebron_advanced <- player_advanced("jamesle01")
#'
#' # Get playoff advanced stats
#' lebron_advanced_playoffs <- player_advanced("jamesle01", "playoffs")
#' }
#'
#' @export
player_advanced <- function(player, season_type = "regular") {
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
#' lebron_shooting <- player_shooting("jamesle01")
#'
#' # Get playoff shooting stats
#' lebron_shooting_playoffs <- player_shooting("jamesle01", "playoffs")
#' }
#'
#' @export
player_shooting <- function(player, season_type = "regular") {
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
#' lebron_pbp <- player_pbp("jamesle01")
#'
#' # Get playoff pbp stats
#' lebron_pbp_playoffs <- player_pbp("jamesle01", "playoffs")
#' }
#'
#' @export
player_pbp <- function(player, season_type = "regular") {
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
  player_name <- player  # Guardar el nombre original para mostrar

  if (es_nombre) {
    # Buscar el ID y el nombre real del jugador
    busqueda <- find_player_id(player, verbose = FALSE, return_name = TRUE)

    if (is.null(busqueda)) {
      cat("Error: Player not found -", player, "\n")
      return(NULL)
    }

    player_id <- busqueda$player_id
    player_name <- busqueda$player_name
  } else {
    # Si es un ID, intentar obtener el nombre desde la web
    # Por ahora usar el ID como nombre
    player_name <- player_id
  }

  cat("Searching player:", player_name, "\n")

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
  nombres_vacios <- is.na(nombres_columnas) | nombres_columnas == "" | grepl("^col_", nombres_columnas)

  # Si hay columnas con nombres vacíos o tipo "col_X", verificar primera fila
  if (nrow(tabla) > 0 && any(nombres_vacios)) {
    primera_fila <- as.character(tabla[1, ])
    # Verificar si la primera fila contiene nombres de columnas válidos
    # (no vacíos, no numéricos puros, contienen letras)
    valores_validos <- !is.na(primera_fila) & primera_fila != "" & grepl("[A-Za-z]", primera_fila)

    # Si la mayoría de valores en primera fila parecen nombres de columna, usarla
    if (sum(valores_validos) > length(nombres_columnas) * 0.5) {
      nuevos_nombres <- primera_fila
      # Reemplazar valores vacíos o NA con nombres genéricos
      nuevos_nombres[is.na(nuevos_nombres) | nuevos_nombres == ""] <- paste0("col_", seq_len(sum(is.na(nuevos_nombres) | nuevos_nombres == "")))
      tabla <- tabla[-1, ]
      names(tabla) <- nuevos_nombres
      nombres_columnas <- nuevos_nombres
    }
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
  # Las tablas de jugadores suelen tener filas de totales ("Career", "Did Not Play", etc.)
  tabla_limpia <- tabla %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character))

  # Filtrar filas que no son temporadas válidas
  # Las temporadas válidas tienen formato "YYYY-YY" (ej: "2023-24")
  if ("Season" %in% names(tabla_limpia)) {
    tabla_limpia <- tabla_limpia %>%
      dplyr::filter(grepl("^\\d{4}-\\d{2}$", Season))
  }

  # Agregar metadatos
  tabla_limpia <- tabla_limpia %>%
    dplyr::mutate(
      player = player_name,
      season_type = temporada
    )

  cat("Success:", nrow(tabla_limpia), "rows obtained\n")

  return(tabla_limpia)
}
