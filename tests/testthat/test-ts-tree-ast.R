test_that("ts_tree_ast", {
  skip_if_not_installed("tsjsonc")
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
    ts_tree_ast(tree)
  })
})

test_that("ts_tree_ast with hyperlinks", {
  skip_if_not_installed("tsjsonc")
  withr::local_options(cli.hyperlink = TRUE)
  tmp <- tempfile()
  on.exit(unlink(tmp), add = TRUE)
  expect_snapshot(
    {
      writeLines('{"a": 1, "b": [1,2,3]}', con = tmp)
      tree <- tsjsonc::ts_read_jsonc(tmp)
      ts_tree_ast(tree)
    },
    transform = redact_tempfile
  )
})
