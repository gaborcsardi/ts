# ts_tree_write

    Code
      tree <- tsjsonc::ts_read_jsonc(tmp)
      tree %>% ts_tree_select("b", 2) %>% ts_tree_delete() %>% ts_tree_write()
      tsjsonc::ts_read_jsonc(tmp)
    Output
      # jsonc (test.jsonc, 1 line)
      1 | {"a": 1, "b": [true]}

---

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [true, false]}")
      tree %>% ts_tree_write(file = tmp)
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

