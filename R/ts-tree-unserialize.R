#' TODO
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_new()].
#' @export

ts_tree_unserialize <- function(tree) {
  UseMethod("ts_tree_unserialize")
}
