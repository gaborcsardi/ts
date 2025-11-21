#' Select parts of a tree-sitter tree
#'
#' TODO: include links to methods here dynamically?
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_read()].
#' @param ... Selection expressions, see details.
#' @export

ts_tree_select <- function(tree, ...) {
  UseMethod("ts_tree_select")
}

#' @export

`[[.ts_tree` <- function(x, i, ...) {
  if (missing(i)) {
    i <- list()
  }
  ts_tree_unserialize(ts_tree_select(x, i, ...))
}

#' TODO: move this into ts_select
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_read()].
#' @param ... Selection expressions.
#' @export

ts_tree_select_refine <- function(tree, ...) {
  UseMethod("ts_tree_select_refine")
}

#' TODO: move this into ts_select
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_read()].
#' @param query String, a tree-sitter query.
#' @return TODO
#' @export

ts_tree_select_query <- function(tree, query) {
  mch <- ts_tree_query(tree, query)$matched_captures
  ids <- if (nrow(mch) == 0) {
    integer()
  } else {
    tree0 <- tree[
      tree$start_byte %in% mch$start_byte & tree$end_byte %in% mch$end_byte,
    ]
    mkeys <- paste0(mch$type, ":", mch$start_byte, ":", mch$end_byte)
    jkeys <- paste0(
      tree0$type,
      ":",
      tree0$start_byte,
      ":",
      tree0$end_byte
    )
    tree0$id[match(mkeys, jkeys)]
  }
  ts_tree_select(tree, ts_tree_selector_ids(ids))
}

# A section is a list of records. Each record has a selector
# and a list of selected nodes.
#
# 1. there is an explicit selection
# 2. otherwise the top element is selected (or elements if many)
# 3. otherwise the document node is selected

get_selection <- function(json, default = TRUE) {
  sel <- attr(json, "selection")
  if (!is.null(sel)) {
    sel
  } else if (default) {
    get_default_selection(json)
  } else {
    NULL
  }
}

get_selected_nodes <- function(json, default = TRUE) {
  sel <- get_selection(json, default = default)
  if (is.null(sel)) {
    return(integer())
  } else {
    sel[[length(sel)]]$nodes
  }
}

get_default_selection <- function(json) {
  top <- json$children[[1]]
  top <- top[json$type[top] != "comment"]
  list(
    list(
      selector = ts_tree_selector_default(),
      nodes = if (length(top) > 0) top else 1L
    )
  )
}

#' TODO
#' @export

ts_tree_selector_default <- function() {
  structure(
    list(),
    class = c("ts_tree_selector_default", "ts_tree_selector", "list")
  )
}

#' TODO: move this into ts_select
#'
#' @param ids Integer vector, the ids of the nodes to select.
#' @export

ts_tree_selector_ids <- function(ids) {
  structure(
    list(ids = ids),
    class = c("ts_tree_selector_ids", "ts_tree_selector", "list")
  )
}

#' TODO
#' @name select-set
#' @rdname select-set
#' @param tree,x A `ts_tree` object as returned by [ts_tree_read()].
#' @param ... Selection expressions, see details.
#' @param value An R expression to serialize or `ts_tree_deleted()`.
#' @return The modified `ts_tree` object.
#' @export
#' @examples
#' # TODO

`ts_tree_select<-` <- function(tree, ..., value) {
  UseMethod("ts_tree_select<-")
}

#' @export

`ts_tree_select<-.ts_tree` <- function(tree, ..., value) {
  res <- if (inherits(value, "ts_tree")) {
    value # nocov
  } else if (inherits(value, "ts_tree_action_delete")) {
    ts_tree_delete(ts_tree_select_refine(tree, ...))
  } else {
    ts_tree_update(ts_tree_select_refine(tree, ...), value)
  }
  attr(res, "selection") <- NULL
  res
}

#' TODO
#' @rdname select-set
#' @param i A list with selection expressions, see details.
#' @export

`[[<-.ts_tree` <- function(x, i, value) {
  if (missing(i)) {
    i <- list()
  }
  res <- if (inherits(value, "ts_tree")) {
    value # nocov
  } else if (inherits(value, "ts_tree_action_delete")) {
    ts_tree_delete(ts_tree_select_refine(x, i))
  } else {
    ts_tree_update(ts_tree_select_refine(x, i), value)
  }
  attr(res, "selection") <- NULL
  res
}

#' @rdname select-set
#' @usage NULL
#' @details
#' `ts_tree_deleted()` is a special marker to delete elements from a tree-sitter
#' ts_tree object with `ts_tree_select<-` or the double bracket operator.
#'
#' @return `ts_tree_deleted()` returns a marker object to be used at the right
#'   hand side of the `ts_tree_select<-` or the double bracket replacement
#'   functions, see examples below.
#'
#' @export
#' @examples
#' # TODO

ts_tree_deleted <- function() {
  structure(
    list(),
    class = c("ts_tree_action_delete", "ts_tree_action", "list")
  )
}
