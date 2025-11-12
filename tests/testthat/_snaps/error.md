# cnd

    Code
      do <- (function() cnd("This is a test error with a value: {v}."))
      do()
    Output
      <error in do(): This is a test error with a value: 13.>

# caller_arg

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

# as_caller_arg

    Code
      as_caller_arg("foobar")
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

# check_named_arg

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

