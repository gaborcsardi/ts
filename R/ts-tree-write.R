#' Write a tree-sitter tree to a file
#'
#' Writes the text content of a ts `ts_tree` object to a file or connection.
#'
#' @param tree A `ts_tree` object as returned by [ts_tree_read()].
#' @param file Character string, connection, or `NULL`. The file or connection
#'   to write to. By default it writes to the same file that was used in
#'   [ts_tree_read()], if `tree` was read from a file.
#' @export
#' @examples
#' # TODO

ts_tree_write <- function(tree, file = NULL) {
  UseMethod("ts_tree_write")
}

#' @export

ts_tree_write.default <- function(tree, file = NULL) {
  file <- file %||% attr(tree, "file")
  if (is.null(file)) {
    lang <- toupper(get_tree_lang(tree))
    stop(cnd(
      "Don't know which file to save {lang} document to. You need to \\
       specify the `file` argument."
    ))
  }

  text <- attr(tree, "text")
  if (length(text) > 0 && text[length(text)] != 0xa) {
    text <- c(text, as.raw(0xa))
  }
  if (inherits(file, "connection")) {
    if (summary(file)$mode == "wb") {
      writeBin(text, con = file)
    } else {
      cat(rawToChar(text), file = file)
    }
  } else {
    writeBin(text, con = file)
  }
  invisible()
}
