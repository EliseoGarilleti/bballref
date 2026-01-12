#' Get team roster
#'
#' Extract roster information for an NBA team in a specific season.
#'
#' @param team_code Three-letter team code (e.g., "LAL", "BOS", "CHI")
#' @param year Season year (e.g., 2020)
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with roster data including metadata columns (team, season, season_type)
#'
#' @examples
#' \dontrun{
#' # Get Lakers 2020 roster
#' roster <- team_roster("LAL", 2020)
#'
#' # Get playoff roster
#' playoff_roster <- team_roster("LAL", 2020, "playoffs")
#' }
#'
#' @export
team_roster <- function(team_code, year, season_type = "regular") {
  obtener_tabla_equipo(team_code, year, "roster", season_type)
}

#' Get team per game statistics
#'
#' Extract per game statistics for an NBA team in a specific season.
#'
#' @param team_code Three-letter team code (e.g., "LAL", "BOS", "CHI")
#' @param year Season year (e.g., 2020)
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with per game stats including metadata columns (team, season, season_type)
#'
#' @examples
#' \dontrun{
#' # Get Lakers 2020 per game stats
#' per_game <- team_per_game("LAL", 2020)
#'
#' # Get playoff per game stats
#' playoff_per_game <- team_per_game("LAL", 2020, "playoffs")
#' }
#'
#' @export
team_per_game <- function(team_code, year, season_type = "regular") {
  obtener_tabla_equipo(team_code, year, "per_game_stats", season_type)
}

#' Get team totals statistics
#'
#' Extract season totals for an NBA team in a specific season.
#'
#' @param team_code Three-letter team code (e.g., "LAL", "BOS", "CHI")
#' @param year Season year (e.g., 2020)
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with season totals including metadata columns (team, season, season_type)
#'
#' @examples
#' \dontrun{
#' # Get Lakers 2020 season totals
#' totals <- team_totals("LAL", 2020)
#'
#' # Get playoff totals
#' playoff_totals <- team_totals("LAL", 2020, "playoffs")
#' }
#'
#' @export
team_totals <- function(team_code, year, season_type = "regular") {
  obtener_tabla_equipo(team_code, year, "totals_stats", season_type)
}

#' Get team advanced statistics
#'
#' Extract advanced statistics for an NBA team in a specific season.
#'
#' @param team_code Three-letter team code (e.g., "LAL", "BOS", "CHI")
#' @param year Season year (e.g., 2020)
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with advanced stats including metadata columns (team, season, season_type)
#'
#' @examples
#' \dontrun{
#' # Get Lakers 2020 advanced stats
#' advanced <- team_advanced("LAL", 2020)
#'
#' # Get playoff advanced stats
#' playoff_advanced <- team_advanced("LAL", 2020, "playoffs")
#' }
#'
#' @export
team_advanced <- function(team_code, year, season_type = "regular") {
  obtener_tabla_equipo(team_code, year, "advanced", season_type)
}

#' Get team per minute statistics
#'
#' Extract per minute statistics for an NBA team in a specific season.
#'
#' @param team_code Three-letter team code (e.g., "LAL", "BOS", "CHI")
#' @param year Season year (e.g., 2020)
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with per minute stats including metadata columns (team, season, season_type)
#'
#' @examples
#' \dontrun{
#' # Get Lakers 2020 per minute stats
#' per_minute <- team_per_minute("LAL", 2020)
#' }
#'
#' @export
team_per_minute <- function(team_code, year, season_type = "regular") {
  obtener_tabla_equipo(team_code, year, "per_minute_stats", season_type)
}

#' Get team per 100 possessions statistics
#'
#' Extract per 100 possessions statistics for an NBA team in a specific season.
#'
#' @param team_code Three-letter team code (e.g., "LAL", "BOS", "CHI")
#' @param year Season year (e.g., 2020)
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with per 100 possessions stats including metadata columns (team, season, season_type)
#'
#' @examples
#' \dontrun{
#' # Get Lakers 2020 per 100 possessions stats
#' per_poss <- team_per_poss("LAL", 2020)
#' }
#'
#' @export
team_per_poss <- function(team_code, year, season_type = "regular") {
  obtener_tabla_equipo(team_code, year, "per_poss", season_type)
}

#' Get team shooting statistics
#'
#' Extract shooting statistics for an NBA team in a specific season.
#'
#' @param team_code Three-letter team code (e.g., "LAL", "BOS", "CHI")
#' @param year Season year (e.g., 2020)
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with shooting stats including metadata columns (team, season, season_type)
#'
#' @examples
#' \dontrun{
#' # Get Lakers 2020 shooting stats
#' shooting <- team_shooting("LAL", 2020)
#' }
#'
#' @export
team_shooting <- function(team_code, year, season_type = "regular") {
  obtener_tabla_equipo(team_code, year, "shooting", season_type)
}

#' Get team play-by-play statistics
#'
#' Extract play-by-play statistics for an NBA team in a specific season.
#'
#' @param team_code Three-letter team code (e.g., "LAL", "BOS", "CHI")
#' @param year Season year (e.g., 2020)
#' @param season_type Season type: "regular" for regular season, "playoffs" for postseason (default: "regular")
#'
#' @return Dataframe with play-by-play stats including metadata columns (team, season, season_type)
#'
#' @examples
#' \dontrun{
#' # Get Lakers 2020 play-by-play stats
#' pbp <- team_pbp("LAL", 2020)
#' }
#'
#' @export
team_pbp <- function(team_code, year, season_type = "regular") {
  obtener_tabla_equipo(team_code, year, "pbp_stats", season_type)
}
