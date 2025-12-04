docs <- function(key) {
  psrs <- ts_list_parsers()
  psrs <- psrs[!duplicated(psrs$package), ]
  file <- paste0(key, ".Rd")
  output <- ""
  for (i in seq_len(nrow(psrs))) {
    path <- file.path(psrs$library[i], psrs$package[i], "docs", file)
    if (file.exists(path)) {
      output <- paste0(output, "\n\n", paste(readLines(path), collapse = "\n"))
    }
  }
  output
}

roxy_tag_parse.roxy_tag_ts <- function(x) {
  lns <- strsplit(x$raw, "\n", fixed = TRUE)[[1]]
  file <- lns[1]
  x$raw <- paste(lns[-1], collapse = "\n")

  x <- roxygen2::tag_markdown_with_sections(x)
  x$val <- list(
    file = file,
    val = x$val
  )
  x
}

roclet_ts <- function() {
  roxygen2::roclet("ts")
}

roclet_process.roclet_ts <- function(x, blocks, env, base_path) {
  for (block in blocks) {
    tags <- roxygen2::block_get_tags(block, "ts")

    for (tag in tags) {
      path <- file.path(base_path, "inst", "docs", paste0(tag$val$file, ".Rd"))
      write_if_newer(tag$val$val, path)
    }
  }
  invisible(list())
}

write_if_newer <- function(txt, path) {
  bin <- charToRaw(txt)
  nl <- charToRaw("\n")
  if (length(bin) > 0 && bin[[length(bin)]] != nl) {
    bin <- c(bin, nl)
  }
  if (file.exists(path)) {
    old <- readBin(path, what = "raw", n = file.size(path))
    if (identical(old, bin)) {
      return(invisible(FALSE))
    }
  }
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  cli::cli_alert_info("Manual stub at {.file {basename(path)}}.")
  writeBin(bin, path)
  invisible(TRUE)
}

roclet_output.roclet_ts <- function(x, results, base_path, ...) {
  invisible(NULL)
}

ts_roclet_register <- function() {
  registerS3method(
    "roxy_tag_parse",
    "roxy_tag_ts",
    roxy_tag_parse.roxy_tag_ts,
    asNamespace("roxygen2")
  )
  registerS3method(
    "roclet_process",
    "roclet_ts",
    roclet_process.roclet_ts,
    asNamespace("roxygen2")
  )
  registerS3method(
    "roclet_output",
    "roclet_ts",
    roclet_output.roclet_ts,
    asNamespace("roxygen2")
  )
}
