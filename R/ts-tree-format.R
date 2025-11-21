#' Format a tree sitter tree for printing
#'
#' @param tree A `ts_tree` object.
#' @param options A list of options for the formatting, see methods.
#' @param ... Extra arguments for methods.
#' @export

ts_tree_format <- function(tree, options, ...) {
  UseMethod("ts_tree_format")
}
