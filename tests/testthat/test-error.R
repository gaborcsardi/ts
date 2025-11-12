test_that("cnd", {
  v <- 13
  expect_snapshot({
    do <- function() cnd("This is a test error with a value: {v}.")
    do()
  })
})

test_that("caller_arg", {
  do <- function(x) {
    caller_arg(x)
  }
  v <- 13
  expect_snapshot({
    do(1)
    do(v)
  })
})

test_that("as_caller_arg", {
  expect_snapshot(as_caller_arg("foobar"))
})

test_that("as.character.ts_caller_arg", {
  do <- function(x) {
    as.character(caller_arg(x))
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

test_that("check_named_arg", {
  f <- function(foobar = NULL) {
    if (!missing(foobar)) {
      check_named_arg(foobar)
    }
  }
  expect_silent(f(foobar = 42))
  expect_silent(f())

  expect_snapshot(error = TRUE, {
    f(42)
    f(fooba = 42)
  })
})
