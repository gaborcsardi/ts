#' Delete selected elements from a tree-sitter tree
#'
#' @ts ts_tree_delete_details
#' The formatting of the rest of the document is left as is.
#'
#' @details
#' \eval{ts:::doc_insert("ts_tree_delete_details", "tsjsonc")}
#'
#' @ts ts_tree_delete_param_tree
#' A `ts_tree` object.
#'
#' @param tree
#' \eval{ts:::doc_insert("ts::ts_tree_delete_param_tree", "ts")}
#' @param ... Extra arguments for methods.
#'
#' @ts ts_tree_delete_return
#' The modified `ts_tree` object with the selected elements removed.
#' @return
#' \eval{ts:::doc_insert("ts::ts_tree_delete_return", "ts")}
#'
#' @export

ts_tree_delete <- function(tree, ...) {
  UseMethod("ts_tree_delete")
}
