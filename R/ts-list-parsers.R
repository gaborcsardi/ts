#' List installed tree-sitter parsers
#'
#' @param lib_path Library paths to search for installed packages.
#'   Default is [base::.libPaths()].
#' @return A data frame with columns:
#' * `package`: character, the name of the package.
#' * `version`: character, the version of the package.
#' * `title`: character, the title of the package.
#' * `library`: character, the library path where the package is installed.
#' * `loaded`: logical, whether the package is currently loaded.
#' @export
#' @examples
#' ts_list_parsers()

ts_list_parsers <- function(lib_path = .libPaths()) {
  pkgs <- list_installed_packages(lib_path)
  pkgs <- pkgs[grepl("^ts.", basename(pkgs))]
  dscs <- lapply(pkgs, function(pkg) {
    packageDescription(basename(pkg), lib.loc = dirname(pkg))
  })
  dscs <- Filter(has_ts_parser, dscs)
  tspkgs <- data_frame(
    package = map_chr(dscs, "[[", "Package"),
    version = map_chr(dscs, "[[", "Version"),
    title = map_chr(dscs, "[[", "Title"),
    library = map_chr(dscs, function(dsc) {
      path <- attr(dsc, "file") %||% NA_character_
      if (basename(path) == "DESCRIPTION") {
        dirname(dirname(path))
      } else {
        dirname(dirname(dirname(path)))
      }
    })
  )
  tspkgs$loaded <- tspkgs$package %in% loadedNamespaces()
  class(tspkgs) <- c("ts_parser_list", class(tspkgs))
  tspkgs
}

#' @export

print.ts_parser_list <- function(x, ...) {
  writeLines(format(x, ...))
  invisible(x)
}

#' @export

format.ts_parser_list <- function(x, ...) {
  # TODO: better formatting
  NextMethod()
}

format_rd_parser_list <- function(lst) {
  if (nrow(lst) == 0) {
    return("No tree-sitter parsers are installed.")
  }
  lines <- map_chr(
    seq_len(nrow(lst)),
    function(i) {
      pkg <- lst$package[i]
      ver <- lst$version[i]
      title <- lst$title[i]
      loaded <- if (lst$loaded[i]) " (loaded)" else ""
      glue(
        "\\item \\link[{pkg}:{pkg}-package]{{{pkg}}} \\
        ({ver}){loaded}: {title}."
      )
    }
  )
  paste0(
    "\\itemize{\n",
    paste(lines, collapse = "\n"),
    "\n}\n"
  )
}

has_ts_parser <- function(dsc) {
  !is.null(dsc$Imports) &&
    "ts" %in% parse_deps("Imports", dsc$Imports)$package
}

list_installed_packages <- function(lib_path = .libPaths()) {
  unlist(lapply(lib_path, dir, full.names = TRUE))
}

parse_deps <- function(type, deps) {
  deps <- str_trim(strsplit(deps, ",")[[1]])
  deps <- lapply(strsplit(deps, "\\("), str_trim)
  deps <- lapply(deps, sub, pattern = "\\)$", replacement = "")
  deps <- deps[vapply(deps, function(x) length(x) != 0, FUN.VALUE = logical(1))]
  res <- data.frame(
    stringsAsFactors = FALSE,
    type = if (length(deps)) type else character(),
    package = vapply(deps, "[", "", 1),
    version = vapply(deps, "[", "", 2)
  )
  res$version <- gsub("\\s+", " ", res$version)
  res$version[is.na(res$version)] <- "*"
  res
}

str_trim <- function(x) {
  sub("^\\s+", "", sub("\\s+$", "", x, useBytes = TRUE), useBytes = TRUE)
}
