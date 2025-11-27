#' Print the document object model (DOM) of a syntax tree
#'
#' TODO
#'
#' @param tree A `ts_tree` object.
#' @export

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
