#' Show the syntax tree structure of a file or string
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_read()].
#'
#' @export
#' @examples
#' # TODO

ts_tree_sexpr <- function(tree) {
  UseMethod("ts_tree_sexpr")
}

#' @export

ts_tree_sexpr.default <- function(tree) {
  call_with_cleanup(c_s_expr, tree)
}
