#' Show the syntax tree structure of a file or string
#'
#' @inheritParams ts_tokens
#'
#' @export
#' @examples
#' # TODO

ts_sexpr <- function(
  language,
  file = NULL,
  text = NULL,
  ranges = NULL
) {
  if (is.null(text) + is.null(file) != 1) {
    stop(cnd(
      "Invalid arguments in `sexpr()`: exactly one of `file` \\
       and `text` must be given."
    ))
  }
  if (is.null(text)) {
    text <- readBin(file, "raw", n = file.size(file))
  }
  if (is.character(text)) {
    text <- charToRaw(paste(text, collapse = "\n"))
  }
  call_with_cleanup(c_s_expr, text, language, ranges)
}

#' Get the token table of a file or string
#'
#' @param language Language of the file or string, a `ts_language` object.
#' @param file Path of a file. Use either `file` or `text`.
#' @param text String. Use either `file` or `text`, but not both.
#' @param ranges Can be used to parse part(s) of the input. It must be a
#'   data frame with integer columns `start_row`, `start_col`, `end_row`,
#'   `end_col`, `start_byte`, `end_byte`, in this order.
#' @param fail_on_parse_error Logical, whether to error if there are
#'   parse errors in the document. Default is `TRUE`.
#'
#' @return A data frame with one row per token, and columns:
#' * `id`: integer, the id of the token.
#' * `parent`: integer, the id of the parent token. The root token has
#'   parent `NA`
#' * `field_name`: character, the field name of the token in its parent.
#' * `type`: character, the type of the token.
#' * `code`: character, the actual code of the token.
#' * `start_byte`, `end_byte`: integer, the byte positions of the token
#'   in the input.
#' * `start_row`, `start_column`, `end_row`, `end_column`: integer, the
#'   position of the token in the input.
#' * `is_missing`: logical, whether the token is a missing token added by
#'   the parser to recover from errors.
#' * `has_error`: logical, whether the token has a parse error.
#' * `children`: list of integer vectors, the ids of the children tokens.
#'
#' @export
#' @examples
#' # TODO

ts_tokens <- function(
  language,
  file = NULL,
  text = NULL,
  ranges = NULL,
  fail_on_parse_error = TRUE
) {
  if (is.null(text) + is.null(file) != 1) {
    stop(cnd(
      "Invalid arguments in `token()`: exactly one of `file` \\
       and `text` must be given."
    ))
  }
  if (is.null(text)) {
    text <- readBin(file, "raw", n = file.size(file))
  }
  if (is.character(text)) {
    text <- charToRaw(paste(text, collapse = "\n"))
  }
  tab <- call_with_cleanup(c_tokens, text, language, ranges)
  lvls <- seq_len(nrow(tab))
  tab$children <- I(unname(split(lvls, factor(tab$parent, levels = lvls))))
  attr(tab, "file") <- file

  tab
}

#' Show the annotated syntax tree of a file or string
#' @inheritParams ts_tokens
#' @export
#' @examples
#' # TODO

ts_syntax_tree <- function(
  language,
  file = NULL,
  text = NULL,
  ranges = NULL,
  fail_on_parse_error = TRUE
) {
  tkns <- ts_tokens(
    language,
    file,
    ranges = ranges,
    text = text,
    fail_on_parse_error = fail_on_parse_error
  )

  type <- tkns$type
  fn <- attr(tkns, "file")
  if (cli::ansi_has_hyperlink_support() && !is.null(fn)) {
    type <- cli::style_hyperlink(
      type,
      sprintf(
        "file://%s:%d:%d",
        normalizePath(fn, mustWork = NA),
        tkns$start_row + 1L,
        tkns$start_column + 1
      )
    )
  }

  linum <- tkns$start_row + 1
  linum <- ifelse(duplicated(linum), "", as.character(linum))
  linum <- format(linum, justify = "right")
  # this is the spacer we need to put in for multi-line tokens
  nlspc <- paste0("\n\t", strrep(" ", nchar(linum[1])), "|")
  code <- ifelse(
    is.na(tkns$code),
    "",
    paste0(strrep(" ", tkns$start_column), tkns$code)
  )

  # we put in a \t, and later use it to align the lines vertically
  treetab <- data_frame(
    id = as.character(tkns$id),
    children = lapply(tkns$children, as.character),
    label = paste0(
      type,
      " (",
      tkns$id,
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

#' Run tree-sitter queries on a file or string
#'
#' See https://tree-sitter.github.io/tree-sitter/ on writing tree-sitter
#' queries.
#'
#' @param query Character string, the tree-sitter query to run.
#' @inheritParams ts_tokens
#' @return A list with entries `patterns` and `matched_captures`.
#'   `patterns` contains information about all patterns in the queries and
#'   it is a data frame with columns: `id`, `name`, `pattern`, `match_count`.
#'   `matched_captures` contains information about all matches, and it has
#'   columns `id`, `pattern`, `match`, `start_byte`, `end_byte`, `start_row`,
#'   `start_column`, `end_row`, `end_column`, `name`, `code`. The `pattern`
#'   column of `matched_captured` refers to the `id` column of `patterns`.
#'
#' @export

ts_query <- function(
  language,
  file = NULL,
  text = NULL,
  query,
  ranges = NULL
) {
  if (is.null(text) + is.null(file) != 1) {
    stop(cnd(
      "Invalid arguments in `query()`: exactly one of `file` \\
       and `text` must be given."
    ))
  }

  qlen <- nchar(query, type = "bytes") + 1L # + \n
  qbeg <- c(1L, cumsum(qlen))
  qnms <- names(query) %||% rep(NA_character_, length(query))
  query1 <- paste0(query, "\n", collapse = "")

  if (!is.null(text)) {
    if (is.character(text)) {
      text <- charToRaw(paste(text, collapse = "\n"))
    }
    res <- call_with_cleanup(c_code_query, text, query1, language, ranges)
  } else {
    res <- call_with_cleanup(c_code_query_path, file, query1, language, ranges)
  }

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
