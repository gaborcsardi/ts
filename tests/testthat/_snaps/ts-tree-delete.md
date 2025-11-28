# ts_tree_delete

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}")
      ts_tree_delete(ts_tree_select(tree, "a"))
    Output
      # jsonc (1 line)
      1 | {"b": [1,2,3]}
    Code
      ts_tree_delete(ts_tree_select(tree, "b", -1L))
    Output
      # jsonc (1 line)
      1 | {"a": 1, "b": [1,2]}

