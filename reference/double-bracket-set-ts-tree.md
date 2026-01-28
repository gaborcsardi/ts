# Edit parts of a tree-sitter tree

The `[[<-` operator works similarly to the combination of
[`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md)
and
[`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md),
(and also to the replacement function
[`ts_tree_select<-()`](https://r-lib.github.io/ts/reference/select-set.md)),
but it might be more readable.

## Usage

``` r
# S3 method for class 'ts_tree'
x[[i]] <- value
```

## Arguments

- x:

  A `ts_tree` object.

- i:

  A list with selection expressions, see
  [`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md)
  for details.

- value:

  An R expression to serialize or
  [`ts_tree_deleted()`](https://r-lib.github.io/ts/reference/select-set.md).

## Value

The modified `ts_tree` object.

## Details

The following two expressions are equivalent:

 

    tree <- ts_tree_select(tree, <selectors>) |> ts_tree_update(value)

and

 

    tree[[list(<selectors>)]] <- value

## See also

Other ts_tree generics:
[`[[.ts_tree()`](https://r-lib.github.io/ts/reference/double-bracket-ts-tree.md),
[`format.ts_tree()`](https://r-lib.github.io/ts/reference/format.ts_tree.md),
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
tree <- tsjsonc::ts_parse_jsonc('{"a": 13, "b": [1, 2, 3], "c": "x"}')

tree
#> # jsonc (1 line)
#> 1 | {"a": 13, "b": [1, 2, 3], "c": "x"}

tree[[list("a")]] <- 42
tree[[list("b", -1)]] <- ts_tree_deleted()

tree
#> # jsonc (1 line)
#> 1 | {"a": 42, "b": [1, 2], "c": "x"}
```
