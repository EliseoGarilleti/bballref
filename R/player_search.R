#' Normalize text by removing accents and special characters
#'
#' @param text Character string to normalize
#' @return Normalized character string
#' @keywords internal
normalize_text <- function(text) {
  # Convert to lowercase
  text <- tolower(text)

  # Remove accents and special characters
  text <- iconv(text, to = "ASCII//TRANSLIT")

  # If iconv didn't work (returns NA), try manual replacements
  if (is.na(text)) {
    text <- tolower(text)
    text <- gsub("[áàäâã]", "a", text)
    text <- gsub("[éèëê]", "e", text)
    text <- gsub("[íìïî]", "i", text)
    text <- gsub("[óòöôõ]", "o", text)
    text <- gsub("[úùüû]", "u", text)
    text <- gsub("[ñ]", "n", text)
    text <- gsub("[ç]", "c", text)
    text <- gsub("[ć]", "c", text)
    text <- gsub("[č]", "c", text)
    text <- gsub("[ž]", "z", text)
    text <- gsub("[š]", "s", text)
    text <- gsub("[đ]", "d", text)
  }

  # Remove any remaining non-alphanumeric except spaces
  text <- gsub("[^a-z0-9 ]", "", text)

  return(text)
}

#' Find player ID by name (internal function)
#'
#' Search for a player's ID on Basketball Reference using their name.
#' Returns the player_id needed for other functions.
#' Handles accents and special characters automatically.
#'
#' @param player_name Player's name (first and/or last name, case and accent insensitive)
#' @param return_all If TRUE, returns all matches. If FALSE (default), returns only the first match
#' @param verbose If TRUE, prints search progress messages. If FALSE, runs silently (default: TRUE)
#' @param return_name If TRUE, returns a list with player_id and player_name. If FALSE (default), returns only player_id
#'
#' @return Character vector with player_id(s), or list with player_id and player_name, or NULL if no match found
#'
#' @examples
#' \dontrun{
#' # Find LeBron James
#' find_player_id("LeBron James")
#' find_player_id("lebron james")  # Case insensitive
#' find_player_id("james lebron")  # Order doesn't matter
#'
#' # Works with accents
#' find_player_id("Nikola Jokic")  # Works with or without ć
#' find_player_id("Nikola Jokić")  # Both work
#'
#' # Find all players named "James"
#' find_player_id("James", return_all = TRUE)
#'
#' # Get both ID and name
#' find_player_id("LeBron James", return_name = TRUE)
#' }
#'
#' @keywords internal
find_player_id <- function(player_name, return_all = FALSE, verbose = TRUE, return_name = FALSE) {

  if (verbose) cat("Searching player:", player_name, "\n")

  # Normalizar nombre (minúsculas, eliminar acentos, eliminar espacios extras)
  nombre_normalizado <- normalize_text(trimws(player_name))
  palabras <- strsplit(nombre_normalizado, "\\s+")[[1]]

  if (length(palabras) == 0) {
    if (verbose) cat("Error: Empty player name\n")
    return(NULL)
  }

  # Determinar letras a buscar (empezar por la primera letra de cada palabra)
  # Típicamente el apellido está al final, pero también buscaremos por la primera palabra
  letras_buscar <- unique(substr(palabras, 1, 1))

  resultados <- list()

  for (letra in letras_buscar) {
    url <- glue::glue("https://www.basketball-reference.com/players/{letra}/")

    tryCatch({
      Sys.sleep(1)  # Pausa para no saturar el servidor

      pagina <- rvest::read_html(url)

      # Buscar tabla de jugadores
      tabla <- pagina %>%
        rvest::html_element("#players") %>%
        rvest::html_table()

      if (is.null(tabla) || nrow(tabla) == 0) {
        next
      }

      # Extraer links de jugadores
      links <- pagina %>%
        rvest::html_element("#players") %>%
        rvest::html_elements("th[data-stat='player'] a") %>%
        rvest::html_attr("href")

      # Extraer nombres de jugadores
      nombres <- pagina %>%
        rvest::html_element("#players") %>%
        rvest::html_elements("th[data-stat='player'] a") %>%
        rvest::html_text()

      # Extraer player_id de los links
      player_ids <- gsub("^/players/./(.+)\\.html$", "\\1", links)

      # Crear dataframe con resultados
      if (length(nombres) > 0 && length(player_ids) > 0) {
        df_letra <- data.frame(
          nombre = nombres,
          player_id = player_ids,
          stringsAsFactors = FALSE
        )

        resultados[[letra]] <- df_letra
      }

    }, error = function(e) {
      if (verbose) cat("Error searching letter", letra, "\n")
    })
  }

  if (length(resultados) == 0) {
    if (verbose) cat("No players found\n")
    return(NULL)
  }

  # Combinar todos los resultados
  todos_resultados <- do.call(rbind, resultados)

  # Filtrar por coincidencias
  # Buscar que todas las palabras del nombre aparezcan en el nombre del jugador
  # Normalizar ambos nombres para comparar sin acentos
  coincidencias <- sapply(todos_resultados$nombre, function(nombre_completo) {
    nombre_completo_norm <- normalize_text(nombre_completo)
    all(sapply(palabras, function(palabra) {
      grepl(palabra, nombre_completo_norm, fixed = TRUE)
    }))
  })

  jugadores_encontrados <- todos_resultados[coincidencias, ]

  if (nrow(jugadores_encontrados) == 0) {
    if (verbose) cat("No matches found for:", player_name, "\n")
    return(NULL)
  }

  if (verbose) {
    cat("Found", nrow(jugadores_encontrados), "player(s):", jugadores_encontrados$nombre[1])
    if (nrow(jugadores_encontrados) > 1) {
      cat(" (and", nrow(jugadores_encontrados) - 1, "more)")
    }
    cat("\n")
  }

  if (return_name) {
    # Devolver tanto el ID como el nombre
    return(list(
      player_id = jugadores_encontrados$player_id[1],
      player_name = jugadores_encontrados$nombre[1]
    ))
  } else if (return_all) {
    return(jugadores_encontrados$player_id)
  } else {
    return(jugadores_encontrados$player_id[1])
  }
}
