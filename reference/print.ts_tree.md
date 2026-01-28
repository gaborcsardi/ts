# Print a tree-sitter tree

Print a `ts_tree` object to the screen.

## Usage

``` r
# S3 method for class 'ts_tree'
print(x, n = 10, ...)
```

## Arguments

- x:

  `ts_tree` object to print.

- n:

  Number of lines, or number of selections to print.

- ...:

  Not used currently.

## Value

Invisibly returns the original `ts_tree` object.

## Details

Calls
[`format.ts_tree()`](https://r-lib.github.io/ts/reference/format.ts_tree.md)
to format the ts_tree object, writes the formatted object to the
standard output, and returns the original object invisibly.

## See also

Other ts_tree generics:
[`[[.ts_tree()`](https://r-lib.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
[`format.ts_tree()`](https://r-lib.github.io/ts/reference/format.ts_tree.md),
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
print(json)
#> # jsonc (1 line)
#> 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": 100 } }
```
