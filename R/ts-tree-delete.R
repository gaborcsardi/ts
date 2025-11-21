#' TODO
#'
#' @param tree A `ts_tree` object.
#' @param ... Extra arguments for methods.
#' @export

ts_tree_delete <- function(tree, ...) {
  UseMethod("ts_tree_delete")
}
