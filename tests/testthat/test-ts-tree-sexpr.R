test_that("ts_tree_sexpr", {
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [true, false]}')
    ts_tree_sexpr(tree)
  })
})
