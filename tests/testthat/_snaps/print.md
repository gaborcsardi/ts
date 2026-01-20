# format.ts_tree

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}") %>%
        ts_tree_format()
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
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}") %>%
        ts_tree_format()
      tree %>% ts_tree_select("a") %>% print()
    Output
      # jsonc (8 lines, 1 selected element)
        1   | {
      > 2   |     "a": 1,
        3   |     "b": [
        4   |         1,
        5   |         2,
        ...   
    Code
      tree %>% ts_tree_select("b", TRUE) %>% print()
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
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}") %>%
        ts_tree_format()
      tree %>% ts_tree_select("c") %>% print()
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
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3], \"c\": {\"d\":4}}") %>%
        ts_tree_format()
      tree %>% ts_tree_select(c("b", "c")) %>% print()
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
      tree <- tsjsonc::ts_parse_jsonc("[1,2,3,4,5,6,7]") %>% ts_tree_format()
      tree %>% ts_tree_select(1:5) %>% print(n = 3)
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

# end_column == 0

    Code
      tree <- tstoml::ts_parse_toml(tstoml::toml_example_text())
      tree %>% ts_tree_select("owner")
    Output
      # toml (23 lines, 1 selected element)
         2  | 
         3  | title = "TOML Example"
         4  | 
      >  5  | [owner]
      >  6  | name = "Tom Preston-Werner"
      >  7  | dob = 1979-05-27T07:32:00-08:00
      >  8  | 
         9  | [database]
        10  | enabled = true
        11  | ports = [ 8000, 8001, 8002 ]
        ...   

