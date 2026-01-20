test_that("ts_tree_insert", {
  library(magrittr)
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
    tree %>% ts_tree_insert(key = "x", list(1, 2, 3)) %>% print(n = 100)
    tree %>% ts_tree_select("b") %>% ts_tree_insert("boo!", at = 1)
  })
})
