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

get_tree_lang <- function(tree) {
  cls <- grep("^ts_tree_", class(tree), value = TRUE)
  if (length(cls) == 0) {
    "<unknown>"
  } else {
    sub("^ts_tree_", "ts_language_", cls[1])
  }
}

middle <- function(x) {
  if (length(x) <= 2) {
    x[numeric()]
  } else {
    x[-c(1, length(x))]
  }
}
