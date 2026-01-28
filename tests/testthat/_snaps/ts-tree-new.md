# ts_tree_new

    Code
      tree <- ts_tree_new(tsjsonc::ts_language_jsonc(), text = "{\"a\": 1, \"b\": [1,2,3]}")
      tree
    Output
      # jsonc (1 line)
      1 | {"a": 1, "b": [1,2,3]}

# ts_tree_new leading whitespace

    Code
      tree <- ts_tree_new(tsjsonc::ts_language_jsonc(), text = "\n\n   \n{\"a\": 1, \"b\": [1,2,3]}")
      tree
    Output
      # jsonc (4 lines)
      1 | 
      2 | 
      3 |    
      4 | {"a": 1, "b": [1,2,3]}

