# ts_tree_write

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [true, false]}")
      tree %>% ts_tree_write()
    Error <error>
      Don't know which file to save JSONC document to. You need to specify the `file` argument.

