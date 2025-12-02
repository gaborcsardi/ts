# TODO

TODO

## Usage

``` r
ts_tree_select(tree, ...) <- value
```

## Arguments

- tree, x:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

- ...:

  Selection expressions, see details.

- value:

  An R expression to serialize or `ts_tree_deleted()`.

## Value

The modified `ts_tree` object.

`ts_tree_deleted()` returns a marker object to be used at the right hand
side of the `ts_tree_select<-` or the double bracket replacement
functions, see examples below.

## Details

`ts_tree_deleted()` is a special marker to delete elements from a
tree-sitter ts_tree object with `ts_tree_select<-` or the double bracket
operator.

## Examples

``` r
# TODO
# TODO
```
