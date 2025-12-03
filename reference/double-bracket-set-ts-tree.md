# Edit parts of a tree-sitter tree

TODO

## Usage

``` r
# S3 method for class 'ts_tree'
x[[i]] <- value
```

## Arguments

- x:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

- i:

  A list with selection expressions, see details.

- value:

  An R expression to serialize or
  [`ts_tree_deleted()`](https://gaborcsardi.github.io/ts/reference/select-set.md).

## Value

The modified `ts_tree` object.
