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

test_that("pmap", {
  expect_equal(
    pmap(
      list(1:3, 4:6),
      function(x, y) x + y
    ),
    list(5, 7, 9)
  )
})

test_that("imap", {
  expect_equal(
    imap(
      c(a = 1, b = 2, c = 3),
      function(x, i) paste0(i, x)
    ),
    list("a1", "b2", "c3")
  )

  expect_equal(
    imap(
      c(1, 2, 3),
      function(x, i) paste0(i, x)
    ),
    list("11", "22", "33")
  )
})

test_that("get_tree_lang", {
  skip_if_not_installed("tsjsonc")
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
  expect_equal(get_tree_lang(tree), "jsonc")
  expect_equal(get_tree_lang(list()), "<unknown>")
})

test_that("middle", {
  expect_equal(middle(1:5), 2:4)
  expect_equal(middle(1:2), integer())
  expect_equal(middle(1), integer())
  expect_equal(middle(integer()), integer())
})

test_that("is_named", {
  expect_true(is_named(c(a = 1, b = 2)))
  expect_false(is_named(c(1, 2)))
  x <- c(a = 1, 2)
  names(x) <- c("a", "")
  expect_false(is_named(x))
  x <- c(a = 1)
  x[2] <- 2
  expect_false(is_named(x))
  expect_true(is_named(c()))
})
