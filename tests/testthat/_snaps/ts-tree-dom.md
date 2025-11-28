# ts_tree_dom

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}")
      ts_tree_dom(tree)
    Output
      document (1)
      \-object (2)
        +-number (10) # a
        \-array (18) # b
          +-number (20)
          +-number (22)
          \-number (24)

