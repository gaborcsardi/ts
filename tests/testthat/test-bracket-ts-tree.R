test_that("[", {
  skip_if_not_installed("tsjsonc")
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [true, false]}')
    tree
    tree[]
  })
})
