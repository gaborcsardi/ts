# ts_check_named_arg

    Code
      f(42)
    Error <error>
      The `foobar` argument must be fully named.
    Code
      f(fooba = 42)
    Error <error>
      The `foobar` argument must be fully named.

# ts_parse_error_cnd

    Code
      stop(ts_parse_error_cnd(tree = tree, text = charToRaw(txt)))
    Error <ts_parse_error>
      JSONC parse error `<text>`:1:29
      1| {"a": 1, "b": [true, false, error]}
                                     ^^^^^^

# format_ts_parse_error_1

    Code
      stop(err)
    Error <ts_parse_error>
      JSONC parse error `<text>`:1:37
      1| {"a": 1...error, ..., "ok"]}
                   ^^^^^^^

---

    Code
      stop(err2)
    Error <ts_parse_error>
      JSONC parse error `<text>`:1:37
      1| {"a": 1...loooooooooooo...ooooooong]}
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^

---

    Code
      stop(err3)
    Error <ts_parse_error>
      JSONC parse error `<text>`:2:29
      1| {"a": 1, 
      2|  "b": [true, false, "very", bad]
                                     ^^^^
      3| }

---

    Code
      stop(err4)
    Error <ts_parse_error>
      JSONC parse error `<text>`:2:30
      2|   "b": ...looooooooooooooooooooooong]
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^

