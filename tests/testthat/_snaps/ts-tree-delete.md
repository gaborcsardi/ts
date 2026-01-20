# ts_tree_delete

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}")
      tree %>% ts_tree_select("a") %>% ts_tree_delete()
    Output
      # jsonc (1 line)
      1 | {"b": [1,2,3]}
    Code
      tree %>% ts_tree_select("b", -1L) %>% ts_tree_delete()
    Output
      # jsonc (1 line)
      1 | {"a": 1, "b": [1,2]}

