# ts_tree_select

    Code
      ts_tree_unserialize(ts_tree_select(tree, "a"))
    Output
      [[1]]
      [1] 0
      
    Code
      ts_tree_unserialize(ts_tree_select(tree, "b", 2))
    Output
      [[1]]
      [1] 2
      
    Code
      ts_tree_unserialize(ts_tree_select(tree, "b", -1L))
    Output
      [[1]]
      [1] 3
      
    Code
      ts_tree_unserialize(ts_tree_select(tree, "b", c(1L, 3L)))
    Output
      [[1]]
      [1] 1
      
      [[2]]
      [1] 3
      
    Code
      ts_tree_unserialize(ts_tree_select(tree, "b", TRUE))
    Output
      [[1]]
      [1] 1
      
      [[2]]
      [1] 2
      
      [[3]]
      [1] 3
      

# ts_tree_select NULL

    Code
      ts_tree_select(tree, NULL)
    Output
      # jsonc (1 line)
      1 | {"a": 0, "b": [1,2,3]}
    Code
      ts_tree_select(ts_tree_select(tree, "a"), NULL, refine = TRUE)
    Output
      # jsonc (1 line)
      1 | {"a": 0, "b": [1,2,3]}

---

    Code
      ts_tree_select(tree, "a", NULL)
    Output
      # jsonc (1 line, 0 selected elements)
      1 | {"a": 1, "b": [1,2,3]}

# ts_tree_select refine

    Code
      ts_tree_unserialize(ts_tree_select(ts_tree_select(tree, "b"), 1, refine = TRUE))
    Output
      [[1]]
      [1] 1
      

# ts_tree_select regex

    Code
      ts_tree_unserialize(ts_tree_select(tree, regex = "^a.*"))
    Output
      [[1]]
      [1] 1
      
      [[2]]
      [1] 3
      

# normalize_selectors

    Code
      normalize_selectors(NULL, list("a", 1L, TRUE, NULL, I(1), regex = "b"))
    Output
      [[1]]
      [1] "a"
      
      [[2]]
      [1] 1
      
      [[3]]
      [1] TRUE
      
      [[4]]
      NULL
      
      [[5]]
      $ids
      [1] 1
      
      attr(,"class")
      [1] "ts_tree_selector_ids" "ts_tree_selector"     "list"                
      
      [[6]]
      $pattern
      [1] "b"
      
      attr(,"class")
      [1] "ts_tree_selector_regex" "ts_tree_selector"       "list"                  
      

# ts_tree_select ids

    Code
      ts_tree_unserialize(ts_tree_select(tree, I(numbers)))
    Output
      [[1]]
      [1] 1
      
      [[2]]
      [1] 1
      
      [[3]]
      [1] 2
      
      [[4]]
      [1] 3
      

# ts_tree_select unknown selector

    Code
      ts_tree_select(tree, raw(2))
    Condition
      Error in `ts_tree_select1.default()`:
      ! Don't know how to select nodes from a `ts_tree` (JSONC) object using selector of class `raw`.

# ts_tree_select keys from non-object

    Code
      ts_tree_select(tree, "a", "b")
    Output
      # jsonc (1 line, 0 selected elements)
      1 | { "a": [1,2,3] }

---

    Code
      ts_tree_select(tree, "a", regex = "^b")
    Output
      # jsonc (1 line, 0 selected elements)
      1 | { "a": [1,2,3] }

# ts_tree_select zero index

    Code
      ts_tree_select(tree, "b", 0)
    Condition
      Error in `ts_tree_select1.ts_tree.integer()`:
      ! Zero indices are not allowed in ts selectors.

# ts_tree_select invalid logical selector

    Code
      ts_tree_select(tree, "b", c(TRUE, FALSE))
    Condition
      Error in `ts_tree_select1.ts_tree.logical()`:
      ! Invalid logical selector in `ts_tree_select()`: only scalar `TRUE` is supported.

# [[

    Code
      tree[["a"]]
    Output
      [[1]]
      [1] 1
      
    Code
      tree[[list("b", 2)]]
    Output
      [[1]]
      [1] FALSE
      

---

    Code
      tree[[]]
    Output
      [[1]]
      [[1]]$a
      [1] 1
      
      [[1]]$b
      [[1]]$b[[1]]
      [1] TRUE
      
      [[1]]$b[[2]]
      [1] FALSE
      
      
      

# TS query

    Code
      ts_tree_select(tree, query = "(number) @num")
    Output
      # jsonc (16 lines, 6 selected elements)
         1 | {
         2 |     "a": {
         3 |         "b": [
      >  4 |             1,
      >  5 |             2,
      >  6 |             3
         7 |         ]
         8 |     },
         9 |     "c": {
        10 |         "b": [
      > 11 |             4,
      > 12 |             5,
      > 13 |             6
        14 |         ]
        15 |     }
        16 | }
    Code
      ts_tree_unserialize(ts_tree_select(tree, query = "(number) @num"))
    Output
      [[1]]
      [1] 1
      
      [[2]]
      [1] 2
      
      [[3]]
      [1] 3
      
      [[4]]
      [1] 4
      
      [[5]]
      [1] 5
      
      [[6]]
      [1] 6
      

---

    Code
      ts_tree_select(tree, query = "(null) @foo")
    Output
      # jsonc (16 lines, 0 selected elements)
       1 | {
       2 |     "a": {
       3 |         "b": [
       4 |             1,
       5 |             2,
       6 |             3
       7 |         ]
       8 |     },
       9 |     "c": {
      10 |         "b": [
      i 6 more lines
      i Use `print(n = ...)` to see more lines

---

    Code
      ts_tree_select(tree, query = list("(null) @foo", "bar"))
    Condition
      Error in `select_query()`:
      ! Invalid capture names in `select_query()`: bar.

---

    Code
      tree <- ts_tree_format(tsjsonc::ts_parse_jsonc(
        "{\"a\": 1, \"b\": 2, \"c\": 3, \"d\": 4 }"))
      ts_tree_sexpr(tree)
    Output
      [1] "(document (object (pair key: (string (string_content)) value: (number)) (pair key: (string (string_content)) value: (number)) (pair key: (string (string_content)) value: (number)) (pair key: (string (string_content)) value: (number))))"
    Code
      ts_tree_select(tree, query = list(
        "((pair (string (string_content) @key) (number) @num)\n           (#not-eq? @key \"c\") )",
        "num"))
    Output
      # jsonc (6 lines, 3 selected elements)
        1 | {
      > 2 |     "a": 1,
      > 3 |     "b": 2,
        4 |     "c": 3,
      > 5 |     "d": 4
        6 | }

# ts_tree_select<-

    Code
      ts_tree_select(tree, "a") <- 2
      tree
    Output
      # jsonc (1 line)
      1 | {"a": 2, "b": [1,2,3]}
    Code
      ts_tree_select(tree, "b", 2) <- 99
      tree
    Output
      # jsonc (1 line)
      1 | {"a": 2, "b": [1,99,3]}

# ts_tree_delete

    Code
      ts_tree_select(tree, "a") <- ts_tree_deleted()
      tree
    Output
      # jsonc (1 line)
      1 | {"b": [1,2,3]}
    Code
      tree[[list("b", -1L)]] <- ts_tree_deleted()
      tree
    Output
      # jsonc (1 line)
      1 | {"b": [1,2]}

# ts_tree_select<- can insert

    Code
      ts_tree_select(tree, "x") <- 42
      tree
    Output
      # jsonc (9 lines)
      1 | {
      2 |     "a": 1,
      3 |     "b": [
      4 |         1,
      5 |         2,
      6 |         3
      7 |     ],
      8 |     "x": 42
      9 | }
    Code
      tree[[list("y", "z")]] <- TRUE
      print(tree, n = 100)
    Output
      # jsonc (12 lines)
       1 | {
       2 |     "a": 1,
       3 |     "b": [
       4 |         1,
       5 |         2,
       6 |         3
       7 |     ],
       8 |     "x": 42,
       9 |     "y": {
      10 |         "z": true
      11 |     }
      12 | }

