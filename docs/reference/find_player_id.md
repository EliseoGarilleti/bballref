# Find player ID by name (internal function)

Search for a player's ID on Basketball Reference using their name.
Returns the player_id needed for other functions. Handles accents and
special characters automatically.

## Usage

``` r
find_player_id(
  player_name,
  return_all = FALSE,
  verbose = TRUE,
  return_name = FALSE
)
```

## Arguments

- player_name:

  Player's name (first and/or last name, case and accent insensitive)

- return_all:

  If TRUE, returns all matches. If FALSE (default), returns only the
  first match

- verbose:

  If TRUE, prints search progress messages. If FALSE, runs silently
  (default: TRUE)

- return_name:

  If TRUE, returns a list with player_id and player_name. If FALSE
  (default), returns only player_id

## Value

Character vector with player_id(s), or list with player_id and
player_name, or NULL if no match found

## Examples

``` r
if (FALSE) { # \dontrun{
# Find LeBron James
find_player_id("LeBron James")
find_player_id("lebron james")  # Case insensitive
find_player_id("james lebron")  # Order doesn't matter

# Works with accents
find_player_id("Nikola Jokic")  # Works with or without ć
find_player_id("Nikola Jokić")  # Both work

# Find all players named "James"
find_player_id("James", return_all = TRUE)

# Get both ID and name
find_player_id("LeBron James", return_name = TRUE)
} # }
```
