#' Convert ts_tree object to a data frame
#'
#' Create a data frame for the syntax tree of a JSON document, by indexing
#' a ts_tree object with single brackets. This is occasionally useful for
#' exploration and debugging.
#'
#' @param x ts_tree object.
#' @param i,j indices.
#' @param drop Ignored.
#'
#' @name ts_tree-brackets
#' @return A data frame with columns: TODO.
#' @export
#' @seealso TODO
#' @examples
#' # TODO

`[.ts_tree` <- function(x, i, j, drop = FALSE) {
  class(x) <- setdiff(class(x), "ts_tree")
  requireNamespace("pillar", quietly = TRUE)
  NextMethod("[")
}
