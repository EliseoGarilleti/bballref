#' Extraer tabla de HTML (visible o comentada)
#'
#' Extrae una tabla específica de una página HTML de Basketball Reference.
#' Maneja tanto tablas visibles como tablas comentadas (ocultas en el código HTML).
#'
#' @param url URL completa de la página
#' @param id_tabla ID exacto de la tabla HTML a extraer
#' @param verbose If TRUE, prints extraction progress messages (default: TRUE)
#'
#' @return Dataframe con los datos de la tabla, o NULL si no se encuentra
#'
#' @examples
#' \dontrun{
#' url <- "https://www.basketball-reference.com/teams/LAL/2020.html"
#' roster <- extraer_tabla_de_html(url, "roster")
#' totals <- extraer_tabla_de_html(url, "totals_stats")
#' }
#'
#'
#' @keywords internal
extraer_tabla_de_html <- function(url, id_tabla, verbose = TRUE) {

  # PASO 1: Intentar extraer como tabla visible
  pagina <- rvest::read_html(url)

  todas_tablas <- pagina %>% rvest::html_elements("table")
  ids_visibles <- todas_tablas %>% rvest::html_attr("id")

  idx <- which(ids_visibles == id_tabla)

  if (length(idx) > 0) {
    return(todas_tablas[[idx]] %>% rvest::html_table())
  }

  # PASO 2: Si no está visible, buscar en comentarios HTML
  html_raw <- as.character(pagina)

  patron_comentario <- "<!--[\\s\\S]*?-->"
  comentarios <- stringr::str_extract_all(html_raw, stringr::regex(patron_comentario))[[1]]

  # CAMBIO: Usar regex en vez de fixed()
  patron_tabla_especifica <- paste0('<table.*?id="', id_tabla, '"')
  idx_comentario <- which(stringr::str_detect(comentarios, stringr::regex(patron_tabla_especifica)))

  if (length(idx_comentario) == 0) {
    if (verbose) cat("Error: Table not found\n")
    return(NULL)
  }

  comentario <- comentarios[idx_comentario[1]]
  html_descomentado <- stringr::str_replace_all(comentario, c("<!--" = "", "-->" = ""))

  doc <- rvest::read_html(html_descomentado)
  tabla_elemento <- doc %>% rvest::html_element(paste0("#", id_tabla))

  if (inherits(tabla_elemento, "xml_missing")) {
    if (verbose) cat("Error: Table not found in comment\n")
    return(NULL)
  }

  return(tabla_elemento %>% rvest::html_table())
}
