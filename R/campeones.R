#' Obtener lista de campeones de la NBA
#'
#' Extrae la lista histórica de campeones de la NBA desde Basketball Reference,
#' con validación automática de rangos de años.
#'
#' @param año_inicio Primer año a incluir (NULL = desde el primero disponible)
#' @param año_fin Último año a incluir (NULL = hasta el último disponible)
#'
#' @return Dataframe con columnas: Year, Champion, codigo_equipo
#'
#' @examples
#' \dontrun{
#' # Todos los campeones disponibles
#' campeones <- get_champions()
#'
#' # Campeones desde 1980 hasta 2023
#' campeones <- get_champions(año_inicio = 1980, año_fin = 2023)
#'
#' # Campeones desde 2000 hasta el último disponible
#' campeones <- get_champions(año_inicio = 2000)
#' }
#'
#' @export
get_champions <- function(año_inicio = NULL, año_fin = NULL) {

  url <- "https://www.basketball-reference.com/playoffs/"

  cat("Obteniendo campeones de NBA...\n")

  pagina <- rvest::read_html(url)

  tabla_raw <- pagina %>%
    rvest::html_element("#champions_index") %>%
    rvest::html_table()

  campeones <- tabla_raw %>%
    setNames(as.character(tabla_raw[1, ])) %>%
    dplyr::slice(-1) %>%
    dplyr::mutate(Year = as.numeric(Year))

  año_min_disponible <- min(campeones$Year, na.rm = TRUE)
  año_max_disponible <- max(campeones$Year, na.rm = TRUE)

  cat("  -> Años disponibles:", año_min_disponible, "-", año_max_disponible, "\n")

  if (is.null(año_inicio)) año_inicio <- año_min_disponible
  if (is.null(año_fin)) año_fin <- año_max_disponible

  if (año_inicio < año_min_disponible) {
    warning("Año inicial (", año_inicio, ") es anterior al disponible (", año_min_disponible, "). Usando ", año_min_disponible)
    año_inicio <- año_min_disponible
  }

  if (año_fin > año_max_disponible) {
    warning("Año final (", año_fin, ") es posterior al disponible (", año_max_disponible, "). Usando ", año_max_disponible)
    año_fin <- año_max_disponible
  }

  if (año_inicio > año_fin) {
    stop("Error: año_inicio (", año_inicio, ") no puede ser mayor que año_fin (", año_fin, ")")
  }

  campeones <- campeones %>%
    dplyr::filter(Year >= año_inicio, Year <= año_fin)

  campeones <- campeones %>%
    dplyr::mutate(
      codigo_equipo = dplyr::case_when(
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
    )

  cat("  -> Éxito:", nrow(campeones), "campeones obtenidos (", año_inicio, "-", año_fin, ")\n")

  return(campeones)
}
