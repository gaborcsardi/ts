# ts_tree_new

    Code
      ts_tree_new(tsjsonc::ts_language_jsonc())
    Error <error>
      Invalid arguments in `ts_tree_new()`: exactly one of `file` and `text` must be given.

---

    Code
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = "{\"a\": 1}", file = tempfile())
    Error <error>
      Invalid arguments in `ts_tree_new()`: exactly one of `file` and `text` must be given.

---

    Code
      tree <- ts_tree_new(tsjsonc::ts_language_jsonc(), file = tmp)
      tree
    Output
      # jsonc (test.jsonc, 1 line)
      1 | {"a": 1, "b": [1,2,3]}

# ts_tree_new parse error

    Code
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = "{\"a\": 1, \"b\": [1,2,3")
    Error <ts_parse_error>
      JSONC parse error `<text>`:1:21
      1| {"a": 1, "b": [1,2,3
                             ^

