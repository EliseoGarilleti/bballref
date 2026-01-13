#' Get NBA champions list
#'
#' Extract historical list of NBA champions from Basketball Reference,
#' with automatic year range validation.
#'
#' @param first_year First year to include (NULL = from earliest available)
#' @param last_year Last year to include (NULL = to latest available)
#'
#' @return Dataframe with columns: Year, Champion, team
#'
#' @examples
#' \dontrun{
#' # All available champions
#' champs <- champions()
#'
#' # Champions from 1980 to 2023
#' champs <- champions(first_year = 1980, last_year = 2023)
#'
#' # Champions from 2000 to latest available
#' champs <- champions(first_year = 2000)
#' }
#'
#' @export
champions <- function(first_year = NULL, last_year = NULL) {

  url <- "https://www.basketball-reference.com/playoffs/"

  cat("Fetching NBA champions...\n")

  pagina <- rvest::read_html(url)

  tabla_raw <- pagina %>%
    rvest::html_element("#champions_index") %>%
    rvest::html_table()

  campeones <- tabla_raw %>%
    setNames(as.character(tabla_raw[1, ])) %>%
    dplyr::slice(-1) %>%
    dplyr::mutate(Year = as.numeric(Year))

  min_year_available <- min(campeones$Year, na.rm = TRUE)
  max_year_available <- max(campeones$Year, na.rm = TRUE)

  cat("  -> Available years:", min_year_available, "-", max_year_available, "\n")

  if (is.null(first_year)) first_year <- min_year_available
  if (is.null(last_year)) last_year <- max_year_available

  if (first_year < min_year_available) {
    warning("First year (", first_year, ") is before available data (", min_year_available, "). Using ", min_year_available)
    first_year <- min_year_available
  }

  if (last_year > max_year_available) {
    warning("Last year (", last_year, ") is after available data (", max_year_available, "). Using ", max_year_available)
    last_year <- max_year_available
  }

  if (first_year > last_year) {
    stop("Error: first_year (", first_year, ") cannot be greater than last_year (", last_year, ")")
  }

  campeones <- campeones %>%
    dplyr::filter(Year >= first_year, Year <= last_year)

  campeones <- campeones %>%
    dplyr::mutate(
      team = dplyr::case_when(
        stringr::str_detect(Champion, "Thunder") ~ "OKC",
        stringr::str_detect(Champion, "Lakers") ~ "LAL",
        stringr::str_detect(Champion, "Celtics") ~ "BOS",
        stringr::str_detect(Champion, "Bulls") ~ "CHI",
        stringr::str_detect(Champion, "Warriors") ~ "GSW",
        stringr::str_detect(Champion, "Heat") ~ "MIA",
        stringr::str_detect(Champion, "Spurs") ~ "SAS",
        stringr::str_detect(Champion, "Pistons") ~ "DET",
        stringr::str_detect(Champion, "76ers|Sixers") ~ "PHI",
        stringr::str_detect(Champion, "Mavericks") ~ "DAL",
        stringr::str_detect(Champion, "Cavaliers") ~ "CLE",
        stringr::str_detect(Champion, "Raptors") ~ "TOR",
        stringr::str_detect(Champion, "Bucks") ~ "MIL",
        stringr::str_detect(Champion, "Rockets") ~ "HOU",
        stringr::str_detect(Champion, "Nuggets") ~ "DEN",
        TRUE ~ NA_character_
      )
    ) %>%
    dplyr::select(1:5, 11)

  cat("  -> Success:", nrow(campeones), "champions obtained (", first_year, "-", last_year, ")\n")

  return(campeones)
}
