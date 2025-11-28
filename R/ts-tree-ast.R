#' Show the annotated syntax tree of a tree-sitter tree
#'
#' `ts_tree_ast()` prints the annotated syntax tree of a ts_tree object.
#' This syntax tree contains all tree-sitter nodes, and it shows the
#' source code associated with each node, along with line numbers.
#'
#' @details
#' ## The ts and ts* packages:
#' Language implementations may override the default `ts_tree_ast()` method,
#' to provide language-specific features. Make sure you read the correct
#' documentation for the language you are using.
#'
#' ## The syntax tree and the DOM tree
#'
#' This syntax tree contains all nodes of the tree-sitter parse tree,
#' including both named and unnamed nodes and comments. E.g. for a JSON(C)
#' document it includes the pairs, brackets, braces, commas, colons,
#' double quotes and string escape sequences as separate nodes.
#'
#' See [ts_tree_dom()] for a tree that shows the semantic structure of the
#' parsed document.
#'
#' @section Example output:
#' ```{r}
#' tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')
#' ts_tree_ast(tree)
#' ```
#'
#' ```{r}
#' ts_tree_dom(tree)
#' ```
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_new()].
#' @return Character vector, the formatted annotated syntax tree, line by
#'   line. It has class [cli_tree][cli::tree()], from the cli package. It
#'   may contain ANSI escape sequences for coloring and hyperlinks.
#' @export
#' @seealso [ts_tree_dom()] to show the document object model (DOM) of a
#'   ts_tree object.
#' @family ts_tree functions
#' @examplesIf requireNamespace("tsjsonc", quietly = TRUE)
#' # see the output above
#' tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')
#' tree
#' ts_tree_ast(tree)
#' ts_tree_dom(tree)

ts_tree_ast <- function(tree) {
  UseMethod("ts_tree_ast")
}

#' @export

ts_tree_ast.default <- function(tree) {
  type <- tree$type
  fn <- attr(tree, "file")
  if (cli::ansi_has_hyperlink_support() && !is.null(fn)) {
    type <- cli::style_hyperlink(
      type,
      sprintf(
        "file://%s:%d:%d",
        normalizePath(fn, mustWork = NA),
        tree$start_row + 1L,
        tree$start_column + 1
      )
    )
  }

  linum <- tree$start_row + 1
  linum <- ifelse(duplicated(linum), "", as.character(linum))
  linum <- format(linum, justify = "right")
  # this is the spacer we need to put in for multi-line tokens
  nlspc <- paste0("\n\t", strrep(" ", nchar(linum[1])), "|")
  code <- ifelse(
    is.na(tree$code),
    "",
    paste0(strrep(" ", tree$start_column), tree$code)
  )

  # we put in a \t, and later use it to align the lines vertically
  treetab <- data_frame(
    id = as.character(tree$id),
    children = lapply(tree$children, as.character),
    label = paste0(
      type,
      " (",
      tree$id,
      ")",
      "\t",
      linum,
      "|",
      gsub("\n", nlspc, code, fixed = TRUE)
    )
  )
  tree <- cli::tree(treetab)

  # align lines vertically. the size of the alignment is measured
  # without the ANSI sequences, but then the substitution uses the
  # full ANSI string
  tabpos <- regexpr("\t", cli::ansi_strip(tree), fixed = TRUE)
  maxtab <- max(tabpos)
  tabpos2 <- regexpr("\t", tree, fixed = TRUE)
  regmatches(tree, tabpos2) <- strrep(" ", maxtab - tabpos + 4)

  tree
}
