#' Run tree-sitter queries on a file or string
#'
#' @details
#' See https://tree-sitter.github.io/tree-sitter/ on writing tree-sitter
#' queries.
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_new()].
#' @param query Character string, the tree-sitter query to run.
#' @return A list with entries `patterns` and `matched_captures`.
#'   `patterns` contains information about all patterns in the queries and
#'   it is a data frame with columns: `id`, `name`, `pattern`, `match_count`.
#'   `matched_captures` contains information about all matches, and it has
#'   columns `id`, `pattern`, `match`, `start_byte`, `end_byte`, `start_row`,
#'   `start_column`, `end_row`, `end_column`, `name`, `code`. The `pattern`
#'   column of `matched_captured` refers to the `id` column of `patterns`.
#'
#' @export

ts_tree_query <- function(tree, query) {
  UseMethod("ts_tree_query")
}

#' @export

ts_tree_query.default <- function(tree, query) {
  qlen <- nchar(query, type = "bytes") + 1L # + \n
  qbeg <- c(1L, cumsum(qlen))
  qnms <- names(query) %||% rep(NA_character_, length(query))
  query1 <- paste0(query, "\n", collapse = "")

  res <- call_with_cleanup(c_code_query, tree, query1)

  qorig <- as.integer(cut(res[[1]][[3]], breaks = qbeg, include.lowest = TRUE))
  list(
    patterns = data_frame(
      id = seq_along(res[[1]][[1]]),
      name = qnms[qorig],
      pattern = res[[1]][[1]],
      match_count = res[[1]][[2]]
    ),
    captures = data_frame(
      id = seq_along(res[[2]]),
      name = res[[2]]
    ),
    matched_captures = data_frame(
      id = map_int(res[[3]], "[[", 3L),
      pattern = map_int(res[[3]], "[[", 1L),
      match = map_int(res[[3]], "[[", 2L),
      type = map_chr(res[[3]], "[[", 12L),
      start_byte = map_int(res[[3]], "[[", 6L),
      end_byte = map_int(res[[3]], "[[", 7L),
      start_row = map_int(res[[3]], "[[", 8L),
      start_column = map_int(res[[3]], "[[", 9L),
      end_row = map_int(res[[3]], "[[", 10L),
      end_column = map_int(res[[3]], "[[", 11L),
      name = map_chr(res[[3]], "[[", 4L),
      code = map_chr(res[[3]], "[[", 5L)
    )
  )
}
