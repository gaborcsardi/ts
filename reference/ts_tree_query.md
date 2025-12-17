# Run tree-sitter queries on a file or string

Run tree-sitter queries on a file or string

## Usage

``` r
ts_tree_query(tree, query)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

- query:

  Character string, the tree-sitter query to run.

## Value

A list with entries `patterns` and `matched_captures`. `patterns`
contains information about all patterns in the queries and it is a data
frame with columns: `id`, `name`, `pattern`, `match_count`.
`matched_captures` contains information about all matches, and it has
columns `id`, `pattern`, `match`, `start_byte`, `end_byte`, `start_row`,
`start_column`, `end_row`, `end_column`, `name`, `code`. The `pattern`
column of `matched_captured` refers to the `id` column of `patterns`.

## Details

See https://tree-sitter.github.io/tree-sitter/ on writing tree-sitter
queries.

`ts:::docs("ts_tree_query")`
