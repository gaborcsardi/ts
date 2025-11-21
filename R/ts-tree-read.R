#' Read (parse) a file or a string
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

ts_tree_read <- function(
  language,
  file = NULL,
  text = NULL,
  ranges = NULL,
  fail_on_parse_error = TRUE
) {
  if (is.null(text) + is.null(file) != 1) {
    stop(cnd(
      "Invalid arguments in `ts_tree_read()`: exactly one of `file` \\
       and `text` must be given."
    ))
  }
  if (is.null(text)) {
    text <- readBin(file, "raw", n = file.size(file))
  }
  if (is.character(text)) {
    text <- charToRaw(paste(text, collapse = "\n"))
  }

  tree <- call_with_cleanup(c_parse, text, language, ranges)

  lvls <- seq_len(nrow(tree))
  tree$children <- I(unname(split(
    lvls,
    factor(tree$parent, levels = lvls)
  )))

  # trailing whitespace for each token
  # first we add the leading whitespace to the document token
  # this way printing $code and $tws will print the whole document
  tree$tws <- rep("", nrow(tree))
  if ((lead <- tree$start_byte[1]) > 0) {
    tree$tws[1] <- rawToChar(text[1:lead])
  }

  # then the whitespace of the terminal nodes
  term <- which(!is.na(tree$code))
  from <- tree$end_byte[term] + 1L
  to <- c(tree$start_byte[term][-1], tree$end_byte[1])
  for (i in seq_along(term)) {
    if (from[i] <= to[i]) {
      tree$tws[term[i]] <- rawToChar(text[from[i]:to[i]])
    }
  }

  attr(tree, "text") <- text
  attr(tree, "file") <- if (!is.null(file)) normalizePath(file)
  cls <- sub("^ts_language_", "ts_tree_", class(language)[1])
  class(tree) <- c(cls, "ts_tree", class(tree))

  if (fail_on_parse_error && (tree$has_error[1] || any(tree$is_missing))) {
    stop(ts_parse_error_cnd(table = tree, text = text))
  }

  tree
}
