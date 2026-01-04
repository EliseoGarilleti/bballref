#' Extraer tabla de HTML (visible o comentada)
#'
#' Extrae una tabla específica de una página HTML de Basketball Reference.
#' Maneja tanto tablas visibles como tablas comentadas (ocultas en el código HTML).
#'
#' @param url URL completa de la página
#' @param id_tabla ID exacto de la tabla HTML a extraer
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
#' @export
extraer_tabla_de_html <- function(url, id_tabla) {

  cat("Buscando tabla con ID:", id_tabla, "\n")

  # PASO 1: Intentar extraer como tabla visible
  pagina <- rvest::read_html(url)

  todas_tablas <- pagina %>% rvest::html_elements("table")
  ids_visibles <- todas_tablas %>% rvest::html_attr("id")

  idx <- which(ids_visibles == id_tabla)

  if (length(idx) > 0) {
    cat("  -> Encontrada como tabla visible\n")
    return(todas_tablas[[idx]] %>% rvest::html_table())
  }

  # PASO 2: Si no está visible, buscar en comentarios HTML
  cat("  -> No está visible, buscando en comentarios...\n")

  html_raw <- as.character(pagina)

  patron_comentario <- "<!--[\\s\\S]*?-->"
  comentarios <- stringr::str_extract_all(html_raw, stringr::regex(patron_comentario))[[1]]

  idx_comentario <- which(stringr::str_detect(comentarios, stringr::fixed(id_tabla)))

  if (length(idx_comentario) == 0) {
    cat("  -> Tabla NO encontrada (ni visible ni comentada)\n")
    return(NULL)
  }

  comentario <- comentarios[idx_comentario[1]]
  html_descomentado <- stringr::str_replace_all(comentario, c("<!--" = "", "-->" = ""))

  doc <- rvest::read_html(html_descomentado)
  tabla_elemento <- doc %>% rvest::html_element(paste0("#", id_tabla))

  if (inherits(tabla_elemento, "xml_missing")) {
    cat("  -> Tabla NO encontrada dentro del comentario\n")
    return(NULL)
  }

  cat("  -> Encontrada como tabla comentada\n")
  return(tabla_elemento %>% rvest::html_table())
}
