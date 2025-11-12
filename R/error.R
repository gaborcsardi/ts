cnd <- function(
  ...,
  class = NULL,
  call = caller_env(),
  .envir = parent.frame()
) {
  call <- frame_get(call, sys.call)
  structure(
    list(message = glue(..., .envir = .envir), call = call),
    class = c(class, "error", "condition")
  )
}

caller_arg <- function(arg) {
  arg <- substitute(arg)
  expr <- do.call(substitute, list(arg), envir = caller_env())
  structure(list(expr), class = "ts_caller_arg")
}

as_caller_arg <- function(x) {
  structure(list(x), class = "ts_caller_arg")
}

as.character.ts_caller_arg <- function(x, ...) {
  lbl <- paste(format(x[[1]]), collapse = "\n")
  gsub("\n.*$", "...", lbl)
}

caller_env <- function(n = 1) {
  parent.frame(n + 1)
}

frame_get <- function(frame, accessor) {
  if (identical(frame, .GlobalEnv)) {
    return(NULL)
  }
  frames <- evalq(sys.frames(), frame)
  for (i in seq_along(frames)) {
    if (identical(frames[[i]], frame)) {
      return(accessor(i))
    }
  }
  NULL
}

check_named_arg <- function(arg, frame = -1) {
  arg <- as.character(substitute(arg))
  if (!arg %in% names(sys.call(frame)[-1])) {
    stop(cnd(
      paste0("The `", arg, "` argument must be fully named."),
      call = caller_env()
    ))
  }
  invisible(TRUE)
}

ts_parse_error_cnd <- function(table, text, call = caller_env()) {
  call <- frame_get(call, sys.call)
  cnd <- structure(
    list(
      call = call,
      table = table,
      text = strsplit(rawToChar(text), "\r?\n")[[1]]
    ),
    class = c("ts_parse_error", "error", "condition")
  )
  cnd$message <- paste0(
    format_ts_parse_error_(cnd),
    collapse = "\n"
  )
  cnd
}

# TODO: taking the first row of the error is not always ideal, because
# ERROR nodes may contain a leading comma before the element that has the
# actual error, and if there is a line break after the comma, then we
# mark the comma as the place of the error, instead of the real error in
# next line.
#
# One workaround is to mark all lines of the ERROR node.
# Another is to ignore the first child of the ERROR node if it is a comma,
# but I am unsure if that's always correct. Sometimes that error may be
# at the comma. Plus maybe we'd need to ignore more than just a first comma.
# So maybe we should mark all rows of the ERROR node.

format_ts_parse_error_ <- function(x, n = 2, ...) {
  file <- attr(x$table, "file") %||% "<text>"
  nodes <- utils::head(which(x$table$type == "ERROR" | x$table$is_missing), n)
  # if two errors start at the same position only show the first
  nodes <- nodes[!duplicated(x$table$start_byte[nodes])]

  rows <- x$table$start_row[nodes] + 1L
  cols <- x$table$start_column[nodes] + 1L
  erows <- x$table$end_row[nodes] + 1L

  ecols <- ifelse(
    rows == erows,
    x$table$end_column[nodes] + 1L,
    nchar(x$text[rows])
  )

  lang <- if (grepl("^ts", class(x)[1])) {
    sub("^ts", "", class(x)[1])
  } else {
    "ts"
  }
  
  unlist(mapply(
    format_ts_parse_error_1,
    lang,
    file,
    rows,
    cols,
    ecols,
    MoreArgs = list(text = x$text)
  ))
}

format_ts_parse_error_1 <- function(lang, text, file, row, col, ecol) {
  head <- sprintf("%s parse error `%s`:%d:%d", toupper(lang), file, row, col)

  nchar <- function(x) {
    cli::ansi_nchar(x, type = "width")
  }

  rows <- c(if (row > 1L) row - 1L, row, if (row < length(text)) row + 1L)
  linum <- structure(cli::col_grey(sprintf("%d| ", rows)), names = rows)
  nlinum <- max(nchar(linum))

  # assume a minimum width of 40, otherwise it is hard to format
  width <- max(cli::console_width(), 40L) - nlinum

  prefix <- substr(text[row], 1L, col - 1L)
  error <- substr(text[row], col, ecol)
  suffix <- substr(text[row], ecol + 1L, nchar(text[row]))

  npre <- nchar(prefix)
  nerr <- nchar(error)
  nsuf <- nchar(suffix)
  truncated <- FALSE
  if (npre + nerr + nsuf > width) {
    truncated <- TRUE
    dots <- cli::col_grey("...")
    # need to truncate, first suffix
    if (nsuf > 10) {
      suffix <- paste0(dots, substr(suffix, nchar(suffix) - 7, nchar(suffix)))
      nsuf <- nchar(suffix)
    }
    if (npre + nerr + nsuf > width) {
      # need to truncate, then prefix
      if (npre > 10) {
        prefix <- paste0(substr(prefix, 1, 7), dots)
        npre <- nchar(prefix)
      }
      if (npre + nerr + nsuf > width) {
        # need to truncate error
        err_width <- width - npre - nsuf
        error <- paste0(
          substr(error, 1, err_width %/% 2),
          dots,
          substr(error, nchar(error) - err_width %/% 2 + 4, nchar(error))
        )
      }
    }
  }

  # if we truncated the line, then do not show the context lines
  ctx_before <- ctx_after <- NULL
  if (truncated) {
    linum <- linum[as.character(row)]
  } else {
    ctx_before <- if (row > 1) {
      paste0(linum[as.character(row - 1)], text[row - 1])
    }
    ctx_after <- if (row < length(text)) {
      paste0(linum[as.character(row + 1)], text[row + 1])
    }
  }

  mark <- paste0(
    strrep(" ", nlinum + nchar(prefix)),
    cli::col_red(strrep("^", max(nchar(error), 1)))
  )

  c(
    head,
    ctx_before,
    paste0(linum[as.character(row)], prefix, error, suffix),
    mark,
    ctx_after
  )
}

#' @export

format.ts_parse_error <- function(x, ...) {
  c("<ts_parse_error>", format_ts_parse_error_(x, ...))
}

#' @export

print.ts_parse_error <- function(x, ...) {
  writeLines(format(x, ...))
  invisible(x)
}
