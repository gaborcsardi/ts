# Format tree-sitter trees

Format a `ts_tree` object for printing.

## Usage

``` r
# S3 method for class 'ts_tree'
format(x, n = 10, ...)
```

## Arguments

- x:

  `ts_tree` object.

- n:

  Number of lines, or number of selections to print.

- ...:

  Currently ignored.

## Value

Character vector of lines to print.

## Details

This is the engine of
[`print.ts_tree()`](https://r-lib.github.io/ts/reference/print.ts_tree.md),
possibly useful to obtain a printed representation without doing the
actual printing.

If there are selected nodes in the tree, those will be highlighted in
the output. See
[`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md)
to select nodes in a tree.

## See also

Other ts_tree generics:
[`[[.ts_tree()`](https://r-lib.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
[`print.ts_tree()`](https://r-lib.github.io/ts/reference/print.ts_tree.md),
[`select-set`](https://r-lib.github.io/ts/reference/select-set.md),
[`ts_tree_ast()`](https://r-lib.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_delete()`](https://r-lib.github.io/ts/reference/ts_tree_delete.md),
[`ts_tree_dom()`](https://r-lib.github.io/ts/reference/ts_tree_dom.md),
[`ts_tree_format()`](https://r-lib.github.io/ts/reference/ts_tree_format.md),
[`ts_tree_insert()`](https://r-lib.github.io/ts/reference/ts_tree_insert.md),
[`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md),
[`ts_tree_query()`](https://r-lib.github.io/ts/reference/ts_tree_query.md),
[`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md),
[`ts_tree_sexpr()`](https://r-lib.github.io/ts/reference/ts_tree_sexpr.md),
[`ts_tree_unserialize()`](https://r-lib.github.io/ts/reference/ts_tree_unserialize.md),
[`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md),
[`ts_tree_write()`](https://r-lib.github.io/ts/reference/ts_tree_write.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
json <- tsjsonc::ts_parse_jsonc(
  '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": 100 } }'
)
format(json)
#> [1] "\033[90m# jsonc (1 line)\033[39m"                                                                           
#> [2] "\033[90m1\033[39m\033[90m | \033[39m{ \"a\": 1, \"b\": [10, 20, 30], \"c\": { \"c1\": true, \"c2\": 100 } }"
```
