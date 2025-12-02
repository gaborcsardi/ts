# Select parts of a tree-sitter tree

TODO: include links to methods here dynamically?

## Usage

``` r
ts_tree_select(tree, ..., refine = FALSE)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

- ...:

  Selection expressions, see details.

- refine:

  Logical, whether to refine the current selection or start a new
  selection.

## Value

A `ts_tree` object with the selected parts.
