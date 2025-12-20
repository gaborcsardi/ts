dglue <- function(..., .envir = parent.frame()) {
  glue(..., .open = "<<", .close = ">>", .envir = .envir)
}

doc_insert <- function(key) {
  keypcs <- strsplit(key, "::", fixed = TRUE)[[1]]
  if (length(keypcs) == 2) {
    package <- keypcs[1]
    key <- keypcs[2]
  } else {
    package <- "ts"
  }
  lib <- dirname(find.package(package))
  output <- doc_create_chunk(key, lib, package, 1L, "<<contents>>")

  mch <- gregexpr("\\\\eval\\{[^\\}]+\\}", output, perl = TRUE)
  regmatches(output, mch)[[1]] <- lapply(
    regmatches(output, mch)[[1]],
    function(x) {
      x <- sub("^\\\\eval\\{", "", x)
      x <- sub("\\}$", "", x)
      eval(parse(text = x))
    }
  )
  output
}

doc_tabs <- function(key) {
  package <- if (nzchar(ev <- Sys.getenv("R_TS_PACKAGE"))) {
    ev
  }

  if (is.null(package)) {
    # list all installed ts packages
    psrs <- ts_list_parsers()
    psrs <- psrs[!duplicated(psrs$package), ]
  } else {
    # only list `package`
    dsc <- utils::packageDescription(package)
    psrs <- data.frame(
      package = package,
      version = dsc$Version,
      library = dirname(find.package(package)),
      title = dsc$Title,
      loaded = package %in% loadedNamespaces(),
      stringsAsFactors = FALSE
    )
  }

  tsdocpath <- doc_path("ts")
  t_tab <- read_char(file.path(tsdocpath, "tab.html"))
  t_div <- read_char(file.path(tsdocpath, "tabs.html"))
  t_btn <- read_char(file.path(tsdocpath, "btn.html"))
  output <- buttons <- tabs <- ""

  for (i in seq_len(nrow(psrs))) {
    language <- sub("^ts", "", psrs$package[i])
    tab <- doc_create_chunk(key, psrs$library[i], psrs$package[i], i, t_tab)
    btn <- dglue(
      t_btn,
      .envir = c(psrs[i, ], list(idx = i, language = language))
    )
    if (!is.null(tab)) {
      tabs <- paste0(tabs, tab, "\n")
      buttons <- paste0(buttons, btn, "\n")
    }
  }
  if (tabs != "") {
    output <- dglue(t_div, .envir = list(tabs = tabs, buttons = buttons))
  }

  output
}

doc_path <- function(package) {
  pkgdir <- find.package(package)
  docpath <- file.path(pkgdir, "docs")
  if (!file.exists(docpath)) {
    docpath <- file.path(pkgdir, "inst", "docs")
  }

  docpath
}

doc_create_chunk <- function(key, lib, package, idx, template) {
  file <- paste0(key, ".Rd")
  path <- file.path(doc_path(package), file)
  if (!file.exists(path)) {
    return(NULL)
  }
  x <- read_char(path)
  lns <- strsplit(x, "\n", fixed = TRUE)[[1]]
  rulepos <- which(lns == "# ---")
  lns <- lns[(rulepos + 1):length(lns)]
  lang_data <- list(
    idx = idx,
    package = package,
    language = sub("^ts", "", package),
    contents = paste(lns, collapse = "\n")
  )
  dglue(template, .envir = lang_data)
}

doc_extra <- function() {
  tsdocpath <- doc_path("ts")
  jspath <- file.path(tsdocpath, "tabs.js")
  js <- read_char(jspath)

  csspath <- file.path(doc_path("ts"), "w3.css")
  css <- paste0("<style>\n", read_char(csspath), "\n</style>\n")
  if (Sys.getenv("IN_PKGDOWN") == "true") {
    csspath2 <- file.path(doc_path("ts"), "pkgdown.css")
    css2 <- paste0("<style>\n", read_char(csspath2), "\n</style>\n")
    css <- paste0(css, css2)
  }
  css <- gsub("%", "\\%", css, fixed = TRUE)

  dglue("\\if{html}{\\out{<<js>>\n<<css>>}}")
}

roxy_tag_parse.roxy_tag_ts <- function(x) {
  lns <- strsplit(x$raw, "\n", fixed = TRUE)[[1]]
  lns1p <- strsplit(lns[1], " ", fixed = TRUE)[[1]]
  file <- lns1p[1]
  title <- paste(lns1p[-1], collapse = " ")

  x$raw <- paste(lns[-1], collapse = "\n")

  x <- roxygen2::tag_markdown_with_sections(x)
  x$val <- list(
    file = file,
    title = title,
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
      value <- paste0(
        "#| title: ",
        tag$val$title,
        "\n# ---\n",
        tag$val$val
      )
      write_if_newer(value, path)
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
