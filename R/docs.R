docs <- function(key) {
  psrs <- ts_list_parsers()
  psrs <- psrs[!duplicated(psrs$package), ]
  file <- paste0("key", ".Rd")
  output <- ""
  for (i in seq_len(nrow(psrs))) {
    path <- file.path(psrs$library[i], psrs$package[i], "docs", file)
    if (file.exists(path)) {
      output <- paste0(output, "\n\n", paste(readLines(path), collapse = "\n"))
    }
  }
  output
}
