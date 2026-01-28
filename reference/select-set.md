# Edit parts of a tree-sitter tree

The `ts_tree_select<-()` replacement function works similarly to the
combination of
[`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md)
and
[`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md),
but it might be more readable.

## Usage

``` r
ts_tree_select(tree, ...) <- value
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md).

- ...:

  Selection expressions, see
  [`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md).

- value:

  An R expression to serialize or `ts_tree_deleted()`.

## Value

A `ts_tree` object with the selected parts updated.

`ts_tree_deleted()` returns a marker object to be used at the right hand
side of the `ts_tree_select<-` or the double bracket replacement
functions, see examples below.

## Details

The following two expressions are equivalent:

 

    tree <- ts_tree_select(tree, <selectors>) |> ts_tree_update(value)

and

 

    ts_tree_select(tree, <selectors>) <- value

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json

    #> # jsonc (1 line)
    #> 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    json |> ts_tree_select("b", 1)

    #> # jsonc (1 line, 1 selected element)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    ts_tree_select(json, "b", 1) <- 100
    json

    #> # jsonc (1 line)
    #> 1 | { "a": 1, "b": [100, 20, 30], "c": { "c1": true, "c2": null } }

 

    toml <- tstoml::ts_parse_toml(
      '[table]\na = 1\nb = [10, 20, 30]\nc = { c1 = true, c2 = [] }\n'
    )
    toml

    #> # toml (4 lines)
    #> 1 | [table]
    #> 2 | a = 1
    #> 3 | b = [10, 20, 30]
    #> 4 | c = { c1 = true, c2 = [] }

 

    toml |> ts_tree_select("table", "b", 1)

    #> # toml (4 lines, 1 selected element)
    #>   1 | [table]
    #>   2 | a = 1
    #> > 3 | b = [10, 20, 30]
    #>   4 | c = { c1 = true, c2 = [] }

 

    ts_tree_select(toml, "table", "b", 1) <- 100
    toml

    #> # toml (4 lines)
    #> 1 | [table]
    #> 2 | a = 1
    #> 3 | b = [100.0, 20, 30]
    #> 4 | c = { c1 = true, c2 = [] }

`ts_tree_deleted()` is a special marker to delete elements from a
ts_tree object with `ts_tree_select<-` or the double bracket operator.

## See also

Other ts_tree generics:
[`[[.ts_tree()`](https://r-lib.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
[`format.ts_tree()`](https://r-lib.github.io/ts/reference/format.ts_tree.md),
[`print.ts_tree()`](https://r-lib.github.io/ts/reference/print.ts_tree.md),
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

ts_tree_select(tree, "a") <- 42
ts_tree_select(tree, "b", -1) <- ts_tree_deleted()

tree
#> # jsonc (1 line)
#> 1 | {"a": 42, "b": [1, 2], "c": "x"}
```
