# ts_tree_select unknown selector

    Code
      tree %>% ts_tree_select(raw(2))
    Error <error>
      Don't know how to select nodes from a `ts_tree` (JSONC) object using selector of class `raw`.

# ts_tree_select zero index

    Code
      tree %>% ts_tree_select("b", 0)
    Error <error>
      Zero indices are not allowed in ts selectors.

# ts_tree_select invalid logical selector

    Code
      tree %>% ts_tree_select("b", c(TRUE, FALSE))
    Error <error>
      Invalid logical selector in `ts_tree_select()`: only scalar `TRUE` is supported.

# TS query

    Code
      tree %>% ts_tree_select(query = list("(null) @foo", "bar"))
    Error <error>
      Invalid capture names in `select_query()`: bar.

