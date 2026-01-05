#' @ts ts_tree_select_details
#' A selection starts from the root of the DOM tree, the document node
#' (see [ts_tree_dom()]), unless `refine = TRUE` is set, in which case it
#' starts from the current selection.
#'
#' <p>
#'
#' A list of selection expressions is applied in order. Each selection
#' expression selects nodes from the currently selected nodes.
#'
#' <p>
#'
#' See the various types of selection expressions below.
#'
#' ## Selectors
#'
#' ### All elements: `TRUE`
#'
#' Selects all child nodes of the current nodes.
#'
#' \eval{ts:::doc_tabs("ts_tree_select_true")}
#'
#' ### Specific keys: character vector
#'
#' Selects child nodes with the given names from nodes with named children.
#' If a node has no named children, it selects nothing from that node.
#'
#' \eval{ts:::doc_tabs("ts_tree_select_character")}
#'
#' ### By position: integer vector
#'
#' Selects child nodes by position. Positive indices count from the start,
#' negative indices count from the end. Zero indices are not allowed.
#'
#' \eval{ts:::doc_tabs("ts_tree_select_integer")}
#'
#' ### Matching keys: regular expression
#'
#' A character scalar named `regex` can be used to select child nodes
#' whose names match the given regular expression, from nodes with named
#' children. If a node has no named children, it selects nothing from that
#' node.
#'
#' \eval{ts:::doc_tabs("ts_tree_select_regex")}
#'
#' ### Tree sitter query matches
#'
#' A character scalar named `query` can be used to select nodes matching
#' a tree-sitter query. See [ts_tree_query()] for details on tree-sitter
#' queries.
#'
#' <p>
#'
#' Instead of a character scalar this can also be a two-element list, where
#' the first element is the query string and the second element is a
#' character vector of capture names to select. In this case only nodes
#' matching the given capture names will be selected.
#'
#' \eval{ts:::doc_tabs("ts_tree_select_tsquery")}
#'
#' ### Explicit node ids
#'
#' You can use `I(c(...))` to select nodes by their ids directly. This is
#' for advanced use cases only.
#'
#' \eval{ts:::doc_tabs("ts_tree_select_ids")}
#'
#' ## Refining selections
#'
#' If the `refine` argument of [ts_tree_select()] is `TRUE`, then
#' the selection starts from the already selected elements (all of them
#' simultanously), instead of starting from the document element.
#'
#' ## The `[[` and `[[<-` operators
#'
#' The `[[` operator works similarly to [ts_tree_select()] on ts_tree
#' objects, but it might be more readable.
#'
#' <p>
#'
#' The `[[<-` operator works similarly to [ts_tree_select<-()], but it
#' might be more readable.
#'
NULL

#' Select parts of a tree-sitter tree
#'
#' @ts ts_tree_select_description
#' This function is the heart of ts. To edit a tree-sitter tree, you first
#' need to select the parts you want to delete or update.
#' @description
#' \eval{ts:::doc_insert("ts::ts_tree_select_description")}
#'
#' ## Installed ts parsers
#'
#' This is the manual path of the `ts_tree_select()` S3 generic function.
#' See the S3 methods in the installed ts parser packages (if any):
#'
#' \eval{ts:::format_rd_parser_list(ts:::ts_list_parsers(), "ts_tree_select")}
#'
#' @details
#' \eval{ts:::doc_insert("ts::ts_tree_select_details")}
#' \eval{ts:::doc_extra()}
#'
#' @ts ts_tree_select_param_tree
#' A `ts_tree` object as returned by [ts_tree_new()].
#' @ts ts_tree_select_param_dots
#' Selection expressions, see details.
#' @ts ts_tree_select_param_refine
#' Logical, whether to refine the current selection or start
#' a new selection.
#' @param tree \eval{ts:::doc_insert("ts_tree_select_param_tree")}
#' @param ... \eval{ts:::doc_insert("ts_tree_select_param_dots")}
#' @param refine \eval{ts:::doc_insert("ts_tree_select_param_refine")}
#' @ts ts_tree_select_return
#' A `ts_tree` object with the selected parts.
#' @return \eval{ts:::doc_insert("ts::ts_tree_select_return")}
#' @export
#' @examplesIf requireNamespace("tsjsonc", quietly = TRUE)
#' json <- ts_tree_new(
#'   tsjsonc::ts_language_jsonc(),
#'   text = '{ "a": 1, "b": 2, "c": { "d": 3, "e": 4 } }'
#' )
#'
#' json |> ts_tree_select("c", "d")

ts_tree_select <- function(tree, ..., refine = FALSE) {
  slts <- normalize_selectors(tree, list(...))
  if (length(slts) == 1 && is.null(slts[[1]])) {
    attr(tree, "selection") <- NULL
    return(tree)
  }
  current <- if (refine) {
    ts_tree_selection(tree)
  } else {
    ts_tree_selector_default(tree)
  }
  cnodes <- current[[length(current)]]$nodes

  for (idx in seq_along(slts)) {
    slt <- slts[[idx]]
    nxt <- integer()
    for (cur in cnodes) {
      nxt <- unique(c(nxt, ts_tree_select1(tree, cur, slt)))
    }
    current[[length(current) + 1L]] <- list(
      selector = slt,
      nodes = sort(nxt)
    )
    cnodes <- current[[length(current)]]$nodes
  }
  attr(tree, "selection") <- current
  tree
}

normalize_selectors <- function(tree, slts) {
  names(slts) <- names(slts) %||% rep("", length(slts))
  slts <- imap(slts, function(x, nm) {
    if (nm == "regex") {
      x <- structure(
        list(pattern = x),
        class = c("ts_tree_selector_regex", "ts_tree_selector", "list")
      )
    } else if (nm == "query") {
      # we do the query up front, so we don't rerun it for every node
      x <- structure(
        list(
          query = if (is.character(x)) x else x[[1]],
          captures = if (!is.character(x)) x[[2]] else NULL
        ),
        class = c("ts_tree_selector_tsquery", "ts_tree_selector", "list")
      )
      x$nodes <- select_query(tree, x$query, x$captures)
    } else if (inherits(x, "AsIs")) {
      x <- structure(
        list(ids = unclass(x)),
        class = c("ts_tree_selector_ids", "ts_tree_selector", "list")
      )
    }
    x <- if (inherits(x, "ts_tree_selector") || !is.list(x)) list(x) else x
    x
  })
  unlist(slts, recursive = FALSE, use.names = FALSE)
}

#' TODO
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_new()].
#' @param node Integer, the node id to select from.
#' @param slt A selector object, see details in [ts_tree_select()].
#' @export

ts_tree_select1 <- function(tree, node, slt) {
  treesel <- structure(
    list(tree = tree, slt = slt),
    class = paste0(class(tree), ".", class(slt)[1])
  )
  UseMethod("ts_tree_select1", treesel)
}

#' @export

ts_tree_select1.default <- function(tree, node, slt) {
  lang <- toupper(get_tree_lang(tree))
  stop(ts_cnd(
    "Don't know how to select nodes from a `ts_tree` ({lang}) object \\
     using selector of class `{class(slt)[1]}`."
  ))
}

#' @export

ts_tree_select1.ts_tree.ts_tree_selector_default <- function(tree, node, slt) {
  top <- tree$children[[1]]
  top <- top[tree$type[top] != "comment"]
  if (length(top) > 0) top else 1L
}

#' @export

ts_tree_select1.ts_tree.NULL <- function(tree, node, slt) {
  integer()
}

#' @export

ts_tree_select1.ts_tree.ts_tree_selector_ids <- function(tree, node, slt) {
  # TODO: should we select in subtree of node? Probably.
  slt$ids
}

#' @export

ts_tree_select1.ts_tree.ts_tree_selector_tsquery <- function(tree, node, slt) {
  # TODO: should we select in subtree of node? Probably.
  slt$nodes
}

#' @export

ts_tree_select1.ts_tree.character <- function(tree, node, slt) {
  chdn <- tree$dom_children[[node]]
  if (!is_named(chdn)) {
    return(integer())
  }
  chdn[names(chdn) %in% slt]
}

#' @export

ts_tree_select1.ts_tree.integer <- function(tree, node, slt) {
  if (any(slt == 0)) {
    stop(ts_cnd("Zero indices are not allowed in ts selectors."))
  }
  chdn <- tree$dom_children[[node]]
  slt <- slt[slt <= length(chdn) & slt >= -length(chdn)]

  res <- integer(length(slt))
  pos <- slt >= 0
  if (any(pos)) {
    res[pos] <- chdn[slt[pos]]
  }
  if (any(!pos)) {
    res[!pos] <- rev(rev(chdn)[abs(slt[!pos])])
  }
  res
}

#' @export

ts_tree_select1.ts_tree.numeric <- function(tree, node, slt) {
  ts_tree_select1.ts_tree.integer(tree, node, as.integer(slt))
}

#' @export

ts_tree_select1.ts_tree.ts_tree_selector_regex <- function(tree, node, slt) {
  chdn <- tree$dom_children[[node]]
  if (!is_named(chdn)) {
    return(integer())
  }
  chdn[grepl(slt$pattern, names(chdn))]
}

#' @export

ts_tree_select1.ts_tree.logical <- function(tree, node, slt) {
  if (isTRUE(slt)) {
    tree$dom_children[[node]]
  } else {
    stop(ts_cnd(
      "Invalid logical selector in `ts_tree_select()`: only scalar `TRUE` is \\
       supported."
    ))
  }
}

#' Unserialize selected parts of a tree-sitter tree
#'
#' TODO
#' @param x A `ts_tree` object as returned by [ts_tree_new()].
#' @param i Selection expressions, see details in [ts_tree_select()].
#' @param ... Passed to [ts_tree_select()].
#' @rdname double-bracket-ts-tree
#' @export

`[[.ts_tree` <- function(x, i, ...) {
  if (missing(i)) {
    i <- list()
  }
  ts_tree_unserialize(ts_tree_select(x, i, ...))
}

select_query <- function(tree, query, captures = NULL) {
  mch <- ts_tree_query(tree, query)

  if (!is.null(captures)) {
    bad <- !captures %in% mch$captures$name
    if (any(bad)) {
      stop(ts_cnd(
        "Invalid capture names in `select_query()`: \\
         {ts_collapse(captures[bad])}."
      ))
    }
    mc <- mch$matched_captures[
      mch$matched_captures$name %in% captures,
    ]
  } else {
    mc <- mch$matched_captures
  }

  ids <- if (nrow(mc) == 0) {
    integer()
  } else {
    toml0 <- tree[
      tree$start_byte %in% mc$start_byte & tree$end_byte %in% mc$end_byte,
    ]
    mkeys <- paste0(mc$type, ":", mc$start_byte, ":", mc$end_byte)
    jkeys <- paste0(toml0$type, ":", toml0$start_byte, ":", toml0$end_byte)
    toml0$id[match(mkeys, jkeys)]
  }
  # TODO: should we do this?
  minimize_selection(tree, ids)
}

# remove nodes that are in the subtree of other selected nodes
# start from the last nodes and go up

minimize_selection <- function(tree, ids) {
  ids <- sort(unique(ids))
  sel <- logical(nrow(tree))
  sel[ids] <- TRUE
  for (id in rev(ids)) {
    parent <- tree$parent[id]
    while (!is.na(parent)) {
      if (sel[parent]) {
        sel[id] <- FALSE
        break
      }
      parent <- tree$parent[parent]
    }
  }
  which(sel)
}

# A section is a list of records. Each record has a selector
# and a list of selected nodes.
#
# 1. there is an explicit selection
# 2. otherwise the top element is selected (or elements if many)
# 3. otherwise the document node is selected

#' Helper functions for tree-sitter tree selections
#'
#' It is unlikely that you will need to use these functions directly, except
#' when implementing a new language for the ts package.
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_new()].
#' @param default Logical, whether to return the default selection if there
#'   is no explicit selection, or `NULL`.
#' @return `ts_tree_selection()` returns a list of selection records.
#'
#' @details `ts_tree_selection()` returns the current selection, as a list
#'   of selectors.
#'
#' @export

ts_tree_selection <- function(tree, default = TRUE) {
  sel <- attr(tree, "selection")
  if (!is.null(sel)) {
    sel
  } else if (default) {
    ts_tree_selector_default(tree)
  } else {
    NULL
  }
}

#' @rdname ts_tree_selection
#' @return `ts_tree_selected_nodes()` returns the ids of the currently
#'   selected nodes.
#' @details `ts_tree_selected_nodes()` returns the ids of the currently
#'   selected nodes.
#' @export

ts_tree_selected_nodes <- function(tree, default = TRUE) {
  sel <- ts_tree_selection(tree, default = default)
  if (is.null(sel)) {
    return(integer())
  } else {
    sel[[length(sel)]]$nodes
  }
}

ts_tree_selector_default <- function(tree) {
  slt <- structure(
    list(),
    class = c("ts_tree_selector_default", "ts_tree_selector", "list")
  )
  list(list(
    selector = slt,
    nodes = ts_tree_select1(tree, NULL, slt)
  ))
}

#' TODO
#' @name select-set
#' @rdname select-set
#' @param tree A `ts_tree` object as returned by [ts_tree_new()].
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
    ts_tree_delete(ts_tree_select(tree, ..., refine = TRUE))
  } else {
    ts_tree_update(ts_tree_select(tree, ..., refine = TRUE), value)
  }
  attr(res, "selection") <- NULL
  res
}

#' Edit parts of a tree-sitter tree
#'
#' TODO
#' @rdname double-bracket-set-ts-tree
#' @param x A `ts_tree` object as returned by [ts_tree_new()].
#' @param i A list with selection expressions, see details.
#' @param value An R expression to serialize or `ts_tree_deleted()`.
#' @return The modified `ts_tree` object.
#' @export

`[[<-.ts_tree` <- function(x, i, value) {
  # nocov start -- not sure if still is still needed, if [[ are not nested
  if (missing(i)) {
    i <- list()
  }
  # nocov end
  res <- if (inherits(value, "ts_tree")) {
    value # nocov
  } else if (inherits(value, "ts_tree_action_delete")) {
    ts_tree_delete(ts_tree_select(x, i, refine = TRUE))
  } else {
    ts_tree_update(ts_tree_select(x, i, refine = TRUE), value)
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
