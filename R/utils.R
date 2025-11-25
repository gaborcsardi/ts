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

pmap <- function(.l, .f) {
  do.call(mapply, c(list(FUN = .f, SIMPLIFY = FALSE, USE.NAMES = FALSE), .l))
}

imap <- function(.x, .f) {
  idx <- names(.x) %||% seq_along(.x)
  mapply(.f, .x, idx, SIMPLIFY = FALSE, USE.NAMES = FALSE)
}

get_tree_lang <- function(tree) {
  cls <- grep("^ts_tree_", class(tree), value = TRUE)
  if (length(cls) == 0) {
    "<unknown>"
  } else {
    sub("^ts_tree_", "", cls[1])
  }
}

middle <- function(x) {
  if (length(x) <= 2) {
    x[numeric()]
  } else {
    x[-c(1, length(x))]
  }
}

is_named <- function(x) {
  nms <- names(x)
  length(x) == length(nms) && !anyNA(nms) && all(nms != "")
}
