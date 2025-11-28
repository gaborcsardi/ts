# ts_tree_insert

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}")
      print(ts_tree_insert(tree, key = "x", list(1, 2, 3)), n = 100)
    Output
      # jsonc (13 lines)
       1 | {
       2 |     "a": 1,
       3 |     "b": [
       4 |         1,
       5 |         2,
       6 |         3
       7 |     ],
       8 |     "x": [
       9 |         1,
      10 |         2,
      11 |         3
      12 |     ]
      13 | }
    Code
      ts_tree_insert(ts_tree_select(tree, "b"), "boo!", at = 1)
    Output
      # jsonc (6 lines)
      1 | {"a": 1, "b": [
      2 |     1,
      3 |     "boo!",
      4 |     2,
      5 |     3
      6 | ]}

