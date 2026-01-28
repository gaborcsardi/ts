test_that("ts_tree_dom", {
  skip_if_not_installed("tsjsonc")
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
    ts_tree_dom(tree)
  })
})
