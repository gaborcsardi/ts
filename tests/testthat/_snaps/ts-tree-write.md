# ts_tree_write

    Code
      tree <- tsjsonc::ts_read_jsonc(tmp)
      ts_tree_write(ts_tree_delete(ts_tree_select(tree, "b", 2)))
      tsjsonc::ts_read_jsonc(tmp)
    Output
      # jsonc (test.jsonc, 1 line)
      1 | {"a": 1, "b": [true]}

---

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [true, false]}")
      ts_tree_write(tree)
    Condition
      Error in `ts_tree_write.default()`:
      ! Don't know which file to save JSONC document to. You need to specify the `file` argument.

---

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [true, false]}")
      ts_tree_write(tree, file = tmp)
      readChar(tmp, nchars = 1000)
    Output
      [1] "{\"a\": 1, \"b\": [true, false]}\n"

---

    Code
      textConnectionValue(con)
    Output
      [1] "{\"a\": 1, \"b\": [true, false]}"

---

    Code
      rawToChar(rawConnectionValue(con2))
    Output
      [1] "{\"a\": 1, \"b\": [true, false]}\n"

