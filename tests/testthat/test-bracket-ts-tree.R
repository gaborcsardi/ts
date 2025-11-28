test_that("[", {
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [true, false]}')
    tree
    tree[]
  })
})
