test_that("ts_tree_new", {
  expect_snapshot({
    tree <- ts_tree_new(
      tsjsonc::ts_language_jsonc(),
      text = '{"a": 1, "b": [1,2,3]}'
    )
    tree
  })

  # error if both text and file are NULL or present
  expect_snapshot(error = TRUE, {
    ts_tree_new(tsjsonc::ts_language_jsonc())
  })
  expect_snapshot(error = TRUE, {
    ts_tree_new(
      tsjsonc::ts_language_jsonc(),
      text = '{"a": 1}',
      file = tempfile()
    )
  })

  # reading from file
  tmp <- file.path(tempfile(), "test.jsonc")
  on.exit(unlink(dirname(tmp), recursive = TRUE), add = TRUE)
  dir.create(dirname(tmp), recursive = TRUE)
  writeLines('{"a": 1, "b": [1,2,3]}', con = tmp)
  expect_snapshot(
    {
      tree <- ts_tree_new(tsjsonc::ts_language_jsonc(), file = tmp)
      tree
    },
    transform = redact_tempfile
  )
})

test_that("ts_tree_new leading whitespace", {
  expect_snapshot({
    tree <- ts_tree_new(
      tsjsonc::ts_language_jsonc(),
      text = '\n\n   \n{"a": 1, "b": [1,2,3]}'
    )
    tree
  })
})

test_that("ts_tree_new parse error", {
  expect_snapshot(error = TRUE, {
    ts_tree_new(
      tsjsonc::ts_language_jsonc(),
      text = '{"a": 1, "b": [1,2,3' # missing closing ]
    )
  })
})
