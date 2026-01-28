# get_ranges

    Code
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = txt, ranges = 1:10)
    Condition
      Error:
      ! Invalid ranges, must be a data frame of 6 integer columns
    Code
      ranges2 <- data.frame(a = 0:1, b = 0:1, c = 0:1, d = 0:1, e = 1, f = 0:1)
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = txt, ranges = ranges2)
    Condition
      Error:
      ! Invalid ranges, must be a data frame of 6 integer columns
    Code
      ranges3 <- ranges
      ranges3$start_byte[1] <- 100L
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = txt, ranges = ranges3)
    Condition
      Error:
      ! Invalid ranges for tree-sitter parser

# parse

    Code
      ts_tree_new(structure("jsonc", class = c("ts_language_jsonc", "ts_language")),
      text = "{\"a\": ")
    Condition
      Error:
      ! ts `language` must be an external pointer

