# Helper functions for tree-sitter tree selections (internal)

These functions are for packages implementing new parsers based on the
ts package. It is very unlikely that you will need to call these
functions directly.

## Usage

``` r
ts_tree_selection(tree, default = TRUE)

ts_tree_selected_nodes(tree, default = TRUE)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md).

- default:

  Logical, whether to return the default selection if there is no
  explicit selection, or `NULL`.

## Value

`ts_tree_selection()` returns a list of selection records.

`ts_tree_selected_nodes()` returns the ids of the currently selected
nodes.

## Details

`ts_tree_selection()` returns the current selection, as a list of
selectors.

`ts_tree_selected_nodes()` returns the ids of the currently selected
nodes.

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{"a": 13, "b": [1, 2, 3], "c": "x"}')
tree <- ts_tree_select(tree, "b", -1)
ts_tree_selection(tree)
#> [[1]]
#> [[1]]$selector
#> list()
#> attr(,"class")
#> [1] "ts_tree_selector_default" "ts_tree_selector"        
#> [3] "list"                    
#> 
#> [[1]]$nodes
#> [1] 2
#> 
#> 
#> [[2]]
#> [[2]]$selector
#> [1] "b"
#> 
#> [[2]]$nodes
#> [1] 18
#> 
#> 
#> [[3]]
#> [[3]]$selector
#> [1] -1
#> 
#> [[3]]$nodes
#> [1] 24
#> 
#> 
```
