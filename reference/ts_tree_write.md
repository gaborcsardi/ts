# Write a tree-sitter tree to a file

Writes the text content of a ts `ts_tree` object to a file or
connection.

## Usage

``` r
ts_tree_write(tree, file = NULL)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

- file:

  Character string, connection, or `NULL`. The file or connection to
  write to. By default it writes to the same file that was used in
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md),
  if `tree` was read from a file.

## Examples

``` r
# TODO
```
