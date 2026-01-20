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
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

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
