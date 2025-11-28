# ts_tree_sexpr

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [true, false]}")
      ts_tree_sexpr(tree)
    Output
      [1] "(document (object (pair key: (string (string_content)) value: (number)) (pair key: (string (string_content)) value: (array (true) (false)))))"

