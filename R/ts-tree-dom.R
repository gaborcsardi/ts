#' Print the document object model (DOM) of a syntax tree
#'
#' TODO
#'
#' @param tree A `ts_tree` object.
#' @export

ts_tree_dom <- function(tree) {
  UseMethod("ts_tree_dom")
}

#' @export

ts_tree_dom.default <- function(tree) {
  ts_tree_ast(tree)
}
