test_that("%||%", {
  expect_equal(NULL %||% "foo", "foo")
  expect_equal("foo" %||% stop("nope"), "foo")
})

test_that("map_int", {
  expect_equal(
    map_int(1:3, function(x) x),
    1:3
  )

  expect_equal(
    map_int(c(a = 1, b = 2), function(x) as.integer(x)),
    c(a = 1L, b = 2L)
  )

  expect_equal(
    map_int(integer(), function(x) stop("not called")),
    integer()
  )

  expect_equal(
    map_int(letters[1:3], function(x) 1L),
    c(a = 1L, b = 1L, c = 1L)
  )
})

test_that("map_chr", {
  expect_equal(
    map_chr(1:3, function(x) as.character(x)),
    c("1", "2", "3")
  )

  expect_equal(
    map_chr(c(a = 1, b = 2), function(x) as.character(x)),
    c(a = "1", b = "2")
  )

  expect_equal(
    map_chr(integer(), function(x) stop("not called")),
    character()
  )

  expect_equal(
    map_chr(letters[1:3], function(x) "x"),
    c(a = "x", b = "x", c = "x")
  )
})
test_that("map_lgl", {
  expect_equal(
    map_lgl(1:3, function(x) x > 2),
    c(FALSE, FALSE, TRUE)
  )

  expect_equal(
    map_lgl(c(a = 1, b = 2), function(x) x > 1),
    c(a = FALSE, b = TRUE)
  )

  expect_equal(
    map_lgl(integer(), function(x) stop("not called")),
    logical()
  )
})
