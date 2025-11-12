`%||%` <- function(l, r) {
  if (is.null(l)) {
    r
  } else {
    l
  }
}

map_int <- function(.x, .f, ...) {
  vapply(.x, .f, integer(1), ...)
}

map_chr <- function(.x, .f, ...) {
  vapply(.x, .f, character(1), ...)
}

map_lgl <- function(.x, .f, ...) {
  vapply(.x, .f, logical(1), ...)
}
