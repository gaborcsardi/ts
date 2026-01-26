test_that("ts_tree_delete", {
  skip_if_not_installed("tsjsonc")
  library(magrittr)
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
    tree %>% ts_tree_select("a") %>% ts_tree_delete()
    tree %>% ts_tree_select("b", -1L) %>% ts_tree_delete()
  })
})
