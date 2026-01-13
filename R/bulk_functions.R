#' Get team statistics for multiple teams and/or years
#'
#' Extract team statistics for multiple teams and/or years at once.
#' Combines results into a single dataframe.
#'
#' @param stat_function The team stat function to use (e.g., team_per_game, team_totals)
#' @param teams Character vector of team codes (e.g., c("LAL", "BOS", "GSW"))
#' @param years Numeric vector of years (e.g., 2020:2024 or c(2020, 2022, 2024))
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#' @param progress Show progress bar (default: TRUE)
#'
#' @return Dataframe with combined results from all teams/years
#'
#' @examples
#' \dontrun{
#' # Multiple teams, same year
#' finals_2020 <- team_stats_bulk(team_per_game, c("LAL", "MIA"), 2020)
#'
#' # One team, multiple years
#' lakers_history <- team_stats_bulk(team_per_game, "LAL", 2018:2024)
#'
#' # Multiple teams, multiple years
#' contenders <- team_stats_bulk(team_totals, c("LAL", "BOS", "GSW"), 2022:2024)
#' }
#'
#' @export
team_stats_bulk <- function(stat_function, teams, years, season_type = "regular", progress = TRUE) {

  # Validar que stat_function es una función
  if (!is.function(stat_function)) {
    stop("stat_function must be a function (e.g., team_per_game, team_totals)")
  }

  # Crear todas las combinaciones de equipos y años
  combinations <- expand.grid(
    team = teams,
    year = years,
    stringsAsFactors = FALSE
  )

  n_total <- nrow(combinations)

  cat("Fetching data for", n_total, "team-season combinations...\n")

  # Función para obtener datos de una combinación
  fetch_one <- function(i) {
    team <- combinations$team[i]
    year <- combinations$year[i]

    if (progress) {
      cat("  [", i, "/", n_total, "] ", team, " ", year, "\n", sep = "")
    }

    result <- tryCatch({
      stat_function(team, year, season_type)
    }, error = function(e) {
      if (progress) {
        cat("    Error: ", conditionMessage(e), "\n")
      }
      return(NULL)
    })

    return(result)
  }

  # Obtener todos los datos
  all_data <- lapply(1:n_total, fetch_one)

  # Filtrar NULLs (errores)
  all_data <- Filter(Negate(is.null), all_data)

  if (length(all_data) == 0) {
    cat("No data retrieved\n")
    return(NULL)
  }

  # Combinar en un único dataframe
  result <- dplyr::bind_rows(all_data)

  cat("Success: Combined", nrow(result), "rows from", length(all_data), "team-seasons\n")

  return(result)
}

#' Get player statistics for multiple players
#'
#' Extract career statistics for multiple players at once.
#' Combines results into a single dataframe for easy comparison.
#'
#' @param stat_function The player stat function to use (e.g., player_per_game, player_totals)
#' @param players Character vector of player names or IDs (e.g., c("LeBron James", "Michael Jordan"))
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#' @param progress Show progress bar (default: TRUE)
#'
#' @return Dataframe with combined career stats from all players
#'
#' @examples
#' \dontrun{
#' # Compare multiple players' careers
#' goats <- player_stats_bulk(
#'   player_per_game,
#'   c("LeBron James", "Michael Jordan", "Kobe Bryant")
#' )
#'
#' # Compare playoff performances
#' playoff_stars <- player_stats_bulk(
#'   player_advanced,
#'   c("Stephen Curry", "Kevin Durant", "Giannis Antetokounmpo"),
#'   season_type = "playoffs"
#' )
#' }
#'
#' @export
player_stats_bulk <- function(stat_function, players, season_type = "regular", progress = TRUE) {

  # Validar que stat_function es una función
  if (!is.function(stat_function)) {
    stop("stat_function must be a function (e.g., player_per_game, player_totals)")
  }

  n_total <- length(players)

  cat("Fetching data for", n_total, "players...\n")

  # Función para obtener datos de un jugador
  fetch_one <- function(i) {
    player <- players[i]

    if (progress) {
      cat("  [", i, "/", n_total, "] ", player, "\n", sep = "")
    }

    result <- tryCatch({
      stat_function(player, season_type)
    }, error = function(e) {
      if (progress) {
        cat("    Error: ", conditionMessage(e), "\n")
      }
      return(NULL)
    })

    return(result)
  }

  # Obtener todos los datos
  all_data <- lapply(1:n_total, fetch_one)

  # Filtrar NULLs (errores)
  all_data <- Filter(Negate(is.null), all_data)

  if (length(all_data) == 0) {
    cat("No data retrieved\n")
    return(NULL)
  }

  # Combinar en un único dataframe
  result <- dplyr::bind_rows(all_data)

  cat("Success: Combined", nrow(result), "rows from", length(all_data), "players\n")

  return(result)
}
