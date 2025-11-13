#' Select parts of a tree-sitter tree
#'
#' TODO: include links to methods here dynamically?
#'
#' @param tokens A `ts_tokens` object as returned by [ts_parse()].
#' @param ... Selection expressions, see details.
#' @export

ts_select <- function(tokens, ...) {
  UseMethod("ts_select")
}

#' @export

`[[.ts_tokens` <- function(x, i, ...) {
  if (missing(i)) {
    i <- list()
  }
  unserialize_selected(ts_select(x, i, ...))
}

#' @export

ts_select_refine <- function(tokens, ...) {
  UseMethod("ts_select_refine")
}

#' @export

ts_select_query <- function(tokens, query) {
  mch <- ts_query(tokens, query)$matched_captures
  ids <- if (nrow(mch) == 0) {
    integer()
  } else {
    tokens0 <- tokens[
      tokens$start_byte %in% mch$start_byte & tokens$end_byte %in% mch$end_byte,
    ]
    mkeys <- paste0(mch$type, ":", mch$start_byte, ":", mch$end_byte)
    jkeys <- paste0(
      tokens0$type,
      ":",
      tokens0$start_byte,
      ":",
      tokens0$end_byte
    )
    tokens0$id[match(mkeys, jkeys)]
  }
  ts_select(tokens, ts_selector_ids(ids))
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
      selector = ts_selector_default(),
      nodes = if (length(top) > 0) top else 1L
    )
  )
}

#' @export

ts_selector_default <- function() {
  structure(
    list(),
    class = c("ts_selector_default", "ts_selector", "list")
  )
}

#' @export

ts_selector_ids <- function(ids) {
  structure(
    list(ids = ids),
    class = c("ts_selector_ids", "ts_selector", "list")
  )
}

#' @rdname select-set
#' @usage NULL
#' @details
#' [deleted()] is a special marker to delete elements from a tree-sitter
#' ts_tokens object with [select<-()] or the double bracket operator.
#'
#' @return [deleted()] returns a marker object to be used at the right
#'   hand side of the [select<-()] or the double bracket replacement
#'   functions, see examples below.
#'
#' @export
#' @examples
#' # TODO

ts_deleted <- function() {
  structure(
    list(),
    class = c("ts_action_delete", "ts_action", "list")
  )
}

#' @export

`ts_select<-` <- function(tokens, ..., value) {
  UseMethod("ts_select<-")
}

#' @export

`ts_select<-.ts_tokens` <- function(tokens, ..., value) {
  res <- if (inherits(value, "ts_tokens")) {
    value # nocov
  } else if (inherits(value, "ts_action_delete")) {
    delete_selected(ts_select_refine(tokens, ...))
  } else {
    update_selected(ts_select_refine(tokens, ...), value)
  }
  attr(res, "selection") <- NULL
  res
}

#' @rdname select-set
#' @export

`[[<-.ts_tokens` <- function(x, i, value) {
  if (missing(i)) {
    i <- list()
  }
  res <- if (inherits(value, "ts_tokens")) {
    value # nocov
  } else if (inherits(value, "ts_action_delete")) {
    delete_selected(ts_select_refine(x, i))
  } else {
    update_selected(ts_select_refine(x, i), value)
  }
  attr(res, "selection") <- NULL
  res
}
