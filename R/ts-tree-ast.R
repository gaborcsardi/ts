#' Show the annotated syntax tree tree-sitter tree
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_read()].
#' @export
#' @examples
#' # TODO

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
