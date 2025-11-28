# ts_tree_new

    Code
      tree <- ts_tree_new(tsjsonc::ts_language_jsonc(), text = "{\"a\": 1, \"b\": [1,2,3]}")
      tree
    Output
      # jsonc (1 line)
      1 | {"a": 1, "b": [1,2,3]}

---

    Code
      ts_tree_new(tsjsonc::ts_language_jsonc())
    Condition
      Error in `ts_tree_new.ts_language()`:
      ! Invalid arguments in `ts_tree_new()`: exactly one of `file` and `text` must be given.

---

    Code
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = "{\"a\": 1}", file = tempfile())
    Condition
      Error in `ts_tree_new.ts_language()`:
      ! Invalid arguments in `ts_tree_new()`: exactly one of `file` and `text` must be given.

---

    Code
      tree <- ts_tree_new(tsjsonc::ts_language_jsonc(), file = tmp)
      tree
    Output
      # jsonc (test.jsonc, 1 line)
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

# ts_tree_new parse error

    Code
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = "{\"a\": 1, \"b\": [1,2,3")
    Condition
      Error in `ts_tree_new.ts_language()`:
      ! JSONC parse error `<text>`:1:21
      1| {"a": 1, "b": [1,2,3
                             ^

