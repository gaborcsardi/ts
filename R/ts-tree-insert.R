#' Insert a new element into a tree sitter tree
#'
#' TODO
#'
#' @param tree A `ts_tree` object.
#' @param new The new element to insert.
#' @param key The key of the new element, if inserting into a keyed element.
#' @param at The position to insert the new element at. The interpretation of
#'   this argument depends on the method that implements the insertion.
#' @param options A list of options for the insertion, see methods.
#' @param ... Extra arguments for methods.
#'
#' @export

ts_tree_insert <- function(tree, new, key, at, options, ...) {
  UseMethod("ts_tree_insert")
}
