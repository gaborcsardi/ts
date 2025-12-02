# Unserialize selected parts of a tree-sitter tree

TODO

## Usage

``` r
# S3 method for class 'ts_tree'
x[[i, ...]]
```

## Arguments

- x:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

- i:

  Selection expressions, see details in
  [`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md).

- ...:

  Passed to
  [`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md).
