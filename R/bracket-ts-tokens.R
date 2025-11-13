#' Convert ts_tokens object to a data frame
#'
#' Create a data frame for the syntax tree of a JSON document, by indexing
#' a ts_tokens object with single brackets. This is occasionally useful for
#' exploration and debugging.
#'
#' @param x ts_tokens object.
#' @param i,j indices.
#' @param drop Ignored.
#'
#' @name ts_tokens-brackets
#' @return A data frame with columns: TODO.
#' @export
#' @seealso TODO
#' @examples
#' # TODO

`[.ts_tokens` <- function(x, i, j, drop = FALSE) {
  class(x) <- setdiff(class(x), "ts_tokens")
  requireNamespace("pillar", quietly = TRUE)
  NextMethod("[")
}
