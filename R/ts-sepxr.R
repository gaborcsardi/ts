#' Show the syntax tree structure of a file or string
#'
#' @param tokens A `ts_tokens` object as returned by [ts_parse()].
#'
#' @export
#' @examples
#' # TODO

ts_sexpr <- function(tokens) {
  call_with_cleanup(c_s_expr, tokens)
}
