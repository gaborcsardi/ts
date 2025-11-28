# cnd

    Code
      do <- (function() ts_cnd("This is a test error with a value: {v}."))
      do()
    Output
      <error in do(): This is a test error with a value: 13.>

# ts_caller_arg

    Code
      do(1)
    Output
      [[1]]
      [1] 1
      
      attr(,"class")
      [1] "ts_caller_arg"
    Code
      do(v)
    Output
      [[1]]
      v
      
      attr(,"class")
      [1] "ts_caller_arg"

# as_ts_caller_arg

    Code
      as_ts_caller_arg("foobar")
    Output
      [[1]]
      [1] "foobar"
      
      attr(,"class")
      [1] "ts_caller_arg"

# as.character.ts_caller_arg

    Code
      do(v1)
    Output
      [1] "v1"
    Code
      do(1 + 1 + 1)
    Output
      [1] "1 + 1 + 1"
    Code
      do(foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo +
        foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo +
        foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo)
    Output
      [1] "foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo_foo + ..."

# ts_check_named_arg

    Code
      f(42)
    Condition
      Error in `f()`:
      ! The `foobar` argument must be fully named.
    Code
      f(fooba = 42)
    Condition
      Error in `f()`:
      ! The `foobar` argument must be fully named.

# ts_parse_error_cnd

    Code
      stop(ts_parse_error_cnd(tree = tree, text = charToRaw(txt)))
    Condition
      Error:
      ! JSONC parse error `<text>`:1:29
      1| {"a": 1, "b": [true, false, error]}
                                     ^^^^^^

# format_ts_parse_error_1

    Code
      stop(err)
    Condition
      Error:
      ! JSONC parse error `<text>`:1:37
      1| {"a": 1...error, ..., "ok"]}
                   ^^^^^^^

---

    Code
      stop(err2)
    Condition
      Error:
      ! JSONC parse error `<text>`:1:37
      1| {"a": 1...loooooooooooo...ooooooong]}
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^

---

    Code
      stop(err3)
    Condition
      Error:
      ! JSONC parse error `<text>`:2:29
      1| {"a": 1, 
      2|  "b": [true, false, "very", bad]
                                     ^^^^
      3| }

---

    Code
      stop(err4)
    Condition
      Error:
      ! JSONC parse error `<text>`:2:30
      2|   "b": ...looooooooooooooooooooooong]
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^

# format.ts_parse_error, print.ts_parse_error

    Code
      format(err)
    Output
      [1] "<ts_parse_error>"                          
      [2] "JSONC parse error `<text>`:1:29"           
      [3] "1| {\"a\": 1, \"b\": [true, false, error]}"
      [4] "                               ^^^^^^"     
    Code
      print(err)
    Output
      <ts_parse_error>
      JSONC parse error `<text>`:1:29
      1| {"a": 1, "b": [true, false, error]}
                                     ^^^^^^

