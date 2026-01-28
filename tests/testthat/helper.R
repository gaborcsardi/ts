redact_tempfile <- function(x) {
  x <- sub(tempdir(), "<tempdir>", x, fixed = TRUE)
  x <- sub(normalizePath(tempdir()), "<tempdir>", x, fixed = TRUE)
  x <- sub(
    normalizePath(tempdir(), winslash = "/"),
    "<tempdir>",
    x,
    fixed = TRUE
  )
  x <- sub("\\R\\", "/R/", x, fixed = TRUE)
  x <- sub("[\\\\/]file[a-zA-Z0-9]+", "/<tempfile>", x)
  x <- sub("[A-Z]:.*Rtmp[a-zA-Z0-9]+[\\\\/]", "<tempdir>/", x)
  x
}

skip_if_not_installed <- function(pkg) {
  if (
    Sys.getenv("NOT_CRAN") != "true" &&
      tolower(Sys.getenv("_R_CHECK_FORCE_SUGGESTS_")) == "false" &&
      !requireNamespace(pkg, quietly = TRUE)
  ) {
    testthat::skip(paste0(pkg, " is not installed"))
  }
}
