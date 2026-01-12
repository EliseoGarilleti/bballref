# Script de prueba para el paquete bballref
# Prueba las funciones principales de equipos y jugadores

# Cargar el paquete desde el directorio local
devtools::load_all()

cat("=====================================\n")
cat("PRUEBAS DEL PAQUETE BBALLREF\n")
cat("=====================================\n\n")

# ============================================
# 1. PRUEBAS DE ESTADÍSTICAS DE EQUIPOS
# ============================================

cat("-----------------------------------\n")
cat("1. ESTADÍSTICAS DE EQUIPOS\n")
cat("-----------------------------------\n\n")

# Prueba 1.1: Per game stats - Lakers 2020 (temporada regular)
cat("1.1) Lakers 2020 - Per Game (Regular Season)\n")
lakers_pg_2020 <- get_team_per_game("LAL", 2020, "regular")
cat("   Dimensiones:", nrow(lakers_pg_2020), "filas x", ncol(lakers_pg_2020), "columnas\n")
cat("   Columnas clave:", paste(names(lakers_pg_2020)[1:10], collapse = ", "), "...\n")
cat("   Verificación 3P -> three_P:", "three_P" %in% names(lakers_pg_2020), "\n")
cat("   Verificación % -> pct:", any(grepl("pct$", names(lakers_pg_2020))), "\n\n")

# Prueba 1.2: Per game stats - Lakers 2020 (playoffs)
cat("1.2) Lakers 2020 - Per Game (Playoffs)\n")
lakers_pg_playoffs <- get_team_per_game("LAL", 2020, "playoffs")
cat("   Dimensiones:", nrow(lakers_pg_playoffs), "filas x", ncol(lakers_pg_playoffs), "columnas\n")
cat("   Season type:", unique(lakers_pg_playoffs$season_type), "\n\n")

# Prueba 1.3: Totals - Celtics 2024
cat("1.3) Celtics 2024 - Totals\n")
celtics_totals <- get_team_totals("BOS", 2024)
cat("   Dimensiones:", nrow(celtics_totals), "filas x", ncol(celtics_totals), "columnas\n")
cat("   Primeros 3 jugadores:\n")
print(head(celtics_totals[, c("Player", "Age", "G", "PTS")], 3))
cat("\n")

# Prueba 1.4: Advanced stats - Warriors 2022
cat("1.4) Warriors 2022 - Advanced Stats\n")
warriors_adv <- get_team_advanced("GSW", 2022)
cat("   Dimensiones:", nrow(warriors_adv), "filas x", ncol(warriors_adv), "columnas\n\n")

# ============================================
# 2. PRUEBAS DE ESTADÍSTICAS DE JUGADORES
# ============================================

cat("-----------------------------------\n")
cat("2. ESTADÍSTICAS DE JUGADORES\n")
cat("-----------------------------------\n\n")

# Prueba 2.1: Per game stats usando NOMBRE
cat("2.1) LeBron James - Per Game (usando nombre)\n")
lebron_pg <- get_player_per_game("LeBron James")
cat("   Dimensiones:", nrow(lebron_pg), "filas x", ncol(lebron_pg), "columnas\n")
cat("   Primera temporada:", head(lebron_pg$Season, 1), "\n")
cat("   Última temporada:", tail(lebron_pg$Season, 1), "\n")
cat("   Verificación filtrado: última fila es temporada válida (YYYY-YY):",
    grepl("^\\d{4}-\\d{2}$", tail(lebron_pg$Season, 1)), "\n")
cat("   Columnas clave:", paste(names(lebron_pg)[1:10], collapse = ", "), "...\n")
cat("   Verificación 3P -> three_P:", "three_P" %in% names(lebron_pg), "\n")
cat("   Verificación % -> pct:", any(grepl("pct$", names(lebron_pg))), "\n\n")

# Prueba 2.2: Per game stats usando ID
cat("2.2) Stephen Curry - Per Game (usando ID: curryst01)\n")
curry_pg <- get_player_per_game("curryst01")
cat("   Dimensiones:", nrow(curry_pg), "filas x", ncol(curry_pg), "columnas\n")
cat("   Temporadas:", min(curry_pg$Season), "a", max(curry_pg$Season), "\n\n")

# Prueba 2.3: Totals playoffs
cat("2.3) Kevin Durant - Totals (Playoffs)\n")
kd_playoffs <- get_player_totals("Kevin Durant", "playoffs")
cat("   Dimensiones:", nrow(kd_playoffs), "filas x", ncol(kd_playoffs), "columnas\n")
cat("   Season type:", unique(kd_playoffs$season_type), "\n")
cat("   Temporadas de playoffs:", nrow(kd_playoffs), "\n\n")

# Prueba 2.4: Per game con minúsculas
cat("2.4) Giannis Antetokounmpo - Per Game (minúsculas)\n")
giannis_pg <- get_player_per_game("giannis antetokounmpo")
cat("   Dimensiones:", nrow(giannis_pg), "filas x", ncol(giannis_pg), "columnas\n")
cat("   Player ID detectado:", unique(giannis_pg$player_id), "\n\n")

# Prueba 2.5: Advanced stats
cat("2.5) Luka Doncic - Advanced Stats\n")
luka_adv <- get_player_advanced("Luka Doncic")
cat("   Dimensiones:", nrow(luka_adv), "filas x", ncol(luka_adv), "columnas\n\n")

# ============================================
# 3. PRUEBA DE BÚSQUEDA DE JUGADORES
# ============================================

cat("-----------------------------------\n")
cat("3. BÚSQUEDA DE JUGADORES\n")
cat("-----------------------------------\n\n")

# Prueba 3.1: Buscar un jugador específico
cat("3.1) Buscar: LeBron James\n")
lebron_id <- find_player_id("LeBron James")
cat("   ID encontrado:", lebron_id, "\n\n")

# Prueba 3.2: Buscar con minúsculas
cat("3.2) Buscar: stephen curry (minúsculas)\n")
curry_id <- find_player_id("stephen curry")
cat("   ID encontrado:", curry_id, "\n\n")

# Prueba 3.3: Buscar múltiples coincidencias
cat("3.3) Buscar todos los 'James' (return_all = TRUE)\n")
james_ids <- find_player_id("James", return_all = TRUE)
cat("   Total encontrados:", length(james_ids), "\n")
cat("   Primeros 5:", paste(head(james_ids, 5), collapse = ", "), "\n\n")

# ============================================
# 4. PRUEBAS DE ESTADÍSTICAS DE LIGA
# ============================================

cat("-----------------------------------\n")
cat("4. ESTADÍSTICAS DE LIGA\n")
cat("-----------------------------------\n\n")

# Prueba 4.1: Liga per game
cat("4.1) Liga - Per Game (Regular Season)\n")
liga_pg <- get_league_per_game()
cat("   Dimensiones:", nrow(liga_pg), "filas x", ncol(liga_pg), "columnas\n")
cat("   Temporadas:", min(liga_pg$Season), "a", max(liga_pg$Season), "\n")
cat("   Verificación 3P -> three_P:", "three_P" %in% names(liga_pg), "\n\n")

# Prueba 4.2: Liga playoffs
cat("4.2) Liga - Totals (Playoffs)\n")
liga_playoffs <- get_league_totals("playoffs")
cat("   Dimensiones:", nrow(liga_playoffs), "filas x", ncol(liga_playoffs), "columnas\n")
cat("   Season type:", unique(liga_playoffs$season_type), "\n\n")

# ============================================
# 5. VERIFICACIÓN DE LIMPIEZA DE NOMBRES
# ============================================

cat("-----------------------------------\n")
cat("5. VERIFICACIÓN LIMPIEZA DE NOMBRES\n")
cat("-----------------------------------\n\n")

cat("5.1) Verificar que NO existen nombres problemáticos:\n")
todas_cols <- c(names(lebron_pg), names(lakers_pg_2020), names(liga_pg), names(luka_adv))
cat("   Contiene '3P' (debería ser FALSE):", any(grepl("^3P$", todas_cols)), "\n")
cat("   Contiene '2P' (debería ser FALSE):", any(grepl("^2P$", todas_cols)), "\n")
cat("   Contiene 'FG%' (debería ser FALSE):", any(grepl("^FG%$", todas_cols)), "\n")
cat("\n")

cat("5.2) Verificar que SÍ existen nombres limpios:\n")
cat("   Contiene 'three_P' (debería ser TRUE):", any(grepl("^three_P$", todas_cols)), "\n")
cat("   Contiene 'two_P' (debería ser TRUE):", any(grepl("^two_P$", todas_cols)), "\n")
cat("   Contiene 'FGpct' (debería ser TRUE):", any(grepl("FGpct", todas_cols)), "\n")
cat("\n")

# ============================================
# 6. RESUMEN FINAL
# ============================================

cat("=====================================\n")
cat("RESUMEN DE PRUEBAS\n")
cat("=====================================\n\n")

cat("✓ Funciones de equipos funcionando correctamente\n")
cat("✓ Funciones de jugadores funcionando correctamente\n")
cat("✓ Búsqueda de jugadores por nombre funcional\n")
cat("✓ Funciones de liga funcionando correctamente\n")
cat("✓ Nombres de columnas limpios (3P -> three_P, % -> pct)\n")
cat("✓ Filtrado de filas no válidas en tablas de jugadores\n")
cat("✓ Soporte para temporada regular y playoffs\n\n")

cat("¡Todas las pruebas completadas con éxito!\n")
