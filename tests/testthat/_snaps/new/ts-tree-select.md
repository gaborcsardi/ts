# ts_tree_select unknown selector

    Code
      tree %>% ts_tree_select(raw(2))
    Condition
      Error in `ts_tree_select1.default()`:
      ! Don't know how to select nodes from a `ts_tree` (JSONC) object using selector of class `raw`.

# ts_tree_select zero index

    Code
      tree %>% ts_tree_select("b", 0)
    Condition
      Error in `ts_tree_select1.ts_tree.integer()`:
      ! Zero indices are not allowed in ts selectors.

# ts_tree_select invalid logical selector

    Code
      tree %>% ts_tree_select("b", c(TRUE, FALSE))
    Condition
      Error in `ts_tree_select1.ts_tree.logical()`:
      ! Invalid logical selector in `ts_tree_select()`: only scalar `TRUE` is supported.

# TS query

    Code
      tree %>% ts_tree_select(query = list("(null) @foo", "bar"))
    Condition
      Error in `select_query()`:
      ! Invalid capture names in `select_query()`: bar.

