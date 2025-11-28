# format.ts_tree

    Code
      tree <- ts_tree_format(tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}"))
      print(tree)
    Output
      # jsonc (8 lines)
      1 | {
      2 |     "a": 1,
      3 |     "b": [
      4 |         1,
      5 |         2,
      6 |         3
      7 |     ]
      8 | }
    Code
      print(tree, n = 1)
    Output
      # jsonc (8 lines)
      1 | {
      i 7 more lines
      i Use `print(n = ...)` to see more lines
    Code
      print(tree, n = 2)
    Output
      # jsonc (8 lines)
      1 | {
      2 |     "a": 1,
      i 6 more lines
      i Use `print(n = ...)` to see more lines

---

    Code
      tree <- ts_tree_format(tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}"))
      print(ts_tree_select(tree, "a"))
    Output
      # jsonc (8 lines, 1 selected element)
        1   | {
      > 2   |     "a": 1,
        3   |     "b": [
        4   |         1,
        5   |         2,
        ...   
    Code
      print(ts_tree_select(tree, "b", TRUE))
    Output
      # jsonc (8 lines, 3 selected elements)
        1 | {
        2 |     "a": 1,
        3 |     "b": [
      > 4 |         1,
      > 5 |         2,
      > 6 |         3
        7 |     ]
        8 | }

---

    Code
      tree <- ts_tree_format(tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}"))
      print(ts_tree_select(tree, "c"))
    Output
      # jsonc (8 lines, 0 selected elements)
      1 | {
      2 |     "a": 1,
      3 |     "b": [
      4 |         1,
      5 |         2,
      6 |         3
      7 |     ]
      8 | }

---

    Code
      tree <- ts_tree_format(tsjsonc::ts_parse_jsonc(
        "{\"a\": 1, \"b\": [1,2,3], \"c\": {\"d\":4}}"))
      print(ts_tree_select(tree, c("b", "c")))
    Output
      # jsonc (11 lines, 2 selected elements)
         1 | {
         2 |     "a": 1,
      >  3 |     "b": [
      >  4 |         1,
      >  5 |         2,
      >  6 |         3
      >  7 |     ],
      >  8 |     "c": {
      >  9 |         "d": 4
      > 10 |     }
        11 | }

---

    Code
      tree <- ts_tree_format(tsjsonc::ts_parse_jsonc("[1,2,3,4,5,6,7]"))
      print(ts_tree_select(tree, 1:5), n = 3)
    Output
      # jsonc (9 lines, 5 selected elements)
        1   | [
      > 2   |     1,
      > 3   |     2,
      > 4   |     3,
        5   |     4,
        6   |     5,
        7   |     6,
        ...   
      i 2 more selected elements
      i Use `print(n = ...)` to see more selected elements

