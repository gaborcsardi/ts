test_that("cnd", {
  v <- 13
  expect_snapshot({
    do <- function() ts_cnd("This is a test error with a value: {v}.")
    do()
  })
})

test_that("ts_caller_arg", {
  do <- function(x) {
    ts_caller_arg(x)
  }
  v <- 13
  expect_snapshot({
    do(1)
    do(v)
  })
})

test_that("as_ts_caller_arg", {
  expect_snapshot(as_ts_caller_arg("foobar"))
})

test_that("as.character.ts_caller_arg", {
  do <- function(x) {
    as.character(ts_caller_arg(x))
  }
  v1 <- 13
  expect_snapshot({
    do(v1)
    do(1 + 1 + 1)
    do(
      foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo +
        foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo +
        foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo
    )
  })
})

test_that("frame_get", {
  expect_null(frame_get(.GlobalEnv, sys.call))
  fake(frame_get, "identical", FALSE)
  expect_null(frame_get(environment(), sys.call()))
})

test_that("ts_check_named_arg", {
  f <- function(foobar = NULL) {
    if (!missing(foobar)) {
      ts_check_named_arg(foobar)
    }
  }
  expect_silent(f(foobar = 42))
  expect_silent(f())

  expect_snapshot(error = TRUE, {
    f(42)
    f(fooba = 42)
  })
})

test_that("ts_parse_error_cnd", {
  skip_if_not_installed("tsjsonc")
  txt <- '{"a": 1, "b": [true, false, error]}'
  tree <- tsjsonc::ts_parse_jsonc(txt, fail_on_parse_error = FALSE)
  expect_snapshot(error = TRUE, {
    stop(ts_parse_error_cnd(tree = tree, text = charToRaw(txt)))
  })
})

test_that("format_ts_parse_error_1", {
  skip_if_not_installed("tsjsonc")
  withr::local_options(cli.width = 40)
  txt <- '{"a": 1, "b": [true, false, "very", error, "this", "is", "ok"]}'
  tree <- tsjsonc::ts_parse_jsonc(txt, fail_on_parse_error = FALSE)
  err <- ts_parse_error_cnd(tree = tree, text = charToRaw(txt))
  expect_snapshot(error = TRUE, {
    stop(err)
  })

  # truncate error
  txt2 <- '{"a": 1, "b": [true, false, "very", looooooooooooooooooooooong]}'
  tree2 <- tsjsonc::ts_parse_jsonc(txt2, fail_on_parse_error = FALSE)
  err2 <- ts_parse_error_cnd(tree = tree2, text = charToRaw(txt2))
  expect_snapshot(error = TRUE, {
    stop(err2)
  })

  # show context
  txt3 <- '{"a": 1, \n "b": [true, false, "very", bad]\n}'
  tree3 <- tsjsonc::ts_parse_jsonc(txt3, fail_on_parse_error = FALSE)
  err3 <- ts_parse_error_cnd(tree = tree3, text = charToRaw(txt3))
  expect_snapshot(error = TRUE, {
    stop(err3)
  })

  # omit context on truncation
  txt4 <- '{"a": 1, \n  "b": [true, false, "very", looooooooooooooooooooooong]\n}'
  tree4 <- tsjsonc::ts_parse_jsonc(txt4, fail_on_parse_error = FALSE)
  err4 <- ts_parse_error_cnd(tree = tree4, text = charToRaw(txt4))
  expect_snapshot(error = TRUE, {
    stop(err4)
  })
})

test_that("format.ts_parse_error, print.ts_parse_error", {
  skip_if_not_installed("tsjsonc")
  txt <- '{"a": 1, "b": [true, false, error]}'
  tree <- tsjsonc::ts_parse_jsonc(txt, fail_on_parse_error = FALSE)
  err <- ts_parse_error_cnd(tree = tree, text = charToRaw(txt))
  expect_snapshot({
    format(err)
    print(err)
  })
})
