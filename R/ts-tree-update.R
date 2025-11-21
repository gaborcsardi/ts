#' TODO
#'
#' @param tree A `ts_tree` object.
#' @param new R expression to serialize into a new element.
#' @param options A list of options for the update, see methods.
#' @param ... Extra arguments for methods.
#' @export

ts_tree_update <- function(tree, new, options, ...) {
  UseMethod("ts_tree_update")
}
