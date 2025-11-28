#' Print the document object model (DOM) of a tree-sitter tree
#'
#' `ts_tree_dom()` prints the document object model (DOM) tree of a ts_tree
#' object. This tree only includes semantic elements. E.g. for a JSON(C)
#' document it includes objects, arrays and various value types, but not
#' the syntax elements like brackets, commas or colons.
#'
#' @details
#' ## The ts and ts* packages:
#' Language implementations may override the default `ts_tree_ast()` method,
#' to provide language-specific features. Make sure you read the correct
#' documentation for the language you are using.
#'
#' ## The syntax tree and the DOM tree
#'
#' See [ts_tree_ast()] for the complete tree-sitter syntax tree that
#' includes all nodes, including syntax elements like brackets and commas.
#'
#' @section Examples:
#' ```{r}
#' tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')
#' ts_tree_ast(tree)
#' ```
#'
#' ```{r}
#' ts_tree_dom(tree)
#' ```
#'
#' @param tree A `ts_tree` object.
#' @return Character vector, the formatted annotated syntax tree, line by
#'   line. It has class [cli_tree][cli::tree()], from the cli package. It
#'   may contain ANSI escape sequences for coloring and hyperlinks.
#' @export
#' @seealso [ts_tree_ast()] to show the annotated syntax tree of a
#'   ts_tree object.
#' @family ts_tree functions
#' @examplesIf requireNamespace("tsjsonc", quietly = TRUE)
#' # see the output above
#' tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')
#' tree
#' ts_tree_ast(tree)
#' ts_tree_dom(tree)

ts_tree_dom <- function(tree) {
  UseMethod("ts_tree_dom")
}

#' @export

ts_tree_dom.default <- function(tree) {
  is_dom_node <- c(1L, which(!is.na(tree$dom_parent)))
  dom <- tree[is_dom_node, ]

  treetab <- data_frame(
    id = as.character(dom$id),
    children = lapply(dom$dom_children, as.character),
    label = paste0(
      dom$dom_type,
      " (",
      dom$id,
      ")",
      ifelse(
        is.na(dom$dom_name),
        "",
        cli::col_grey(paste0(" # ", dom$dom_name))
      )
    )
  )

  tree <- cli::tree(treetab)
  tree
}
