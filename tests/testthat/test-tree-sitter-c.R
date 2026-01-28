test_that("get_ranges", {
  skip_if_not_installed("tsjsonc")
  withr::local_seed(13)
  randomstr <- function() {
    l <- as.integer(runif(1) * 3)
    strrep("x", l)
  }
  json <- "[1,2,3]"
  txttab <- rbind(strsplit(json, "")[[1]], replicate(nchar(json), randomstr()))
  txt <- paste(txttab, collapse = "")
  start_col <- cumsum(nchar(txttab))[seq(1, length(txttab), by = 2)]
  end_col <- start_col + nchar(txttab[1, ]) - 1L
  ranges <- data.frame(
    stringsAsFactors = FALSE,
    start_row = rep(1L, ncol(txttab)),
    start_col = start_col,
    end_row = rep(1L, ncol(txttab)),
    end_col = end_col,
    start_byte = start_col,
    end_byte = end_col
  )

  expect_snapshot({
    txt
    tree <- ts_tree_new(
      tsjsonc::ts_language_jsonc(),
      text = txt,
      ranges = ranges
    )
    tree
    ts_tree_ast(tree)
  })

  # invalid ranges
  expect_snapshot(
    error = TRUE,
    {
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = txt, ranges = 1:10)
      ranges2 <- data.frame(a = 0:1, b = 0:1, c = 0:1, d = 0:1, e = 1, f = 0:1)
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = txt, ranges = ranges2)
      ranges3 <- ranges
      ranges3$start_byte[1] <- 100L
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = txt, ranges = ranges3)
    },
    variant = if (getRversion() <= "3.5.100") "old" else "new"
  )
})

test_that("new_lookahead_sym", {
  skip_if_not_installed("tsjsonc")
  expect_snapshot({
    tree <- ts_tree_new(
      tsjsonc::ts_language_jsonc(),
      text = '[{"a": }]',
      fail_on_parse_error = FALSE
    )
    tree[]
    tree$is_missing
    exp <- tree$expected[[which(tree$is_missing)]]
    do.call(rbind, exp)
  })
})

test_that("ts_xtree_free", {
  ts_tree_new(tsjsonc::ts_language_jsonc(), text = '{"a": 1}')
  gc()
  gc()
  expect_true(TRUE)
})

test_that("parse", {
  expect_snapshot(
    error = TRUE,
    {
      ts_tree_new(
        structure("jsonc", class = c("ts_language_jsonc", "ts_language")),
        text = '{"a": '
      )
    },
    variant = if (getRversion() <= "3.5.100") "old" else "new"
  )
})

test_that("check_predicate_eq", {
  skip_if_not_installed("tsjsonc")
  withr::local_options(width = 1000)

  # compare to string
  tree <- ts_tree_new(
    tsjsonc::ts_language_jsonc(),
    text = '{"a": 1, "b": 2}'
  )
  expect_snapshot({
    ts_tree_query(
      tree,
      "((pair key: (string (string_content) @key)) (#eq? @key \"a\"))"
    )
  })
  expect_snapshot({
    ts_tree_query(
      tree,
      "((pair key: (string (string_content) @key)) (#not-eq? @key \"a\"))"
    )
  })

  # compare two captures
  tree <- ts_tree_new(
    tsjsonc::ts_language_jsonc(),
    text = '{"a": "a", "b": "x"}'
  )
  expect_snapshot({
    ts_tree_query(
      tree,
      "((pair key: (string (string_content) @key)
        value: (string (string_content) @value)) @pair
        (#eq? @key @value))"
    )
  })
  expect_snapshot({
    ts_tree_query(
      tree,
      "((pair key: (string (string_content) @key)
        value: (string (string_content) @value))
        (#not-eq? @key @value))"
    )
  })
  # any-eq
  # any-not-eq
})

test_that("r_grepl", {
  skip_if_not_installed("tsjsonc")
  withr::local_options(width = 1000)

  tree <- ts_tree_new(
    tsjsonc::ts_language_jsonc(),
    text = '{"a": 1, "b": 2}'
  )
  expect_snapshot({
    ts_tree_query(
      tree,
      "((pair key: (string (string_content) @key))
        (#match? @key \"^a\"))"
    )
  })
})

test_that("check_predicate_match", {
  #
})

test_that("check_predicate_any_of", {
  #
})
