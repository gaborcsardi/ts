# Unserialize parts of a tree-sitter tree

The `[[` operator works similarly to the combination of
[`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md)
and
[`ts_tree_unserialize()`](https://r-lib.github.io/ts/reference/ts_tree_unserialize.md),
but it might be more readable.

## Usage

``` r
# S3 method for class 'ts_tree'
x[[i, ...]]
```

## Arguments

- x:

  A `ts_tree` object.

- i:

  Selection expressions in a list, see details in
  [`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md).

- ...:

  Additional arguments, passed to
  [`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md).

## Value

List of R objects, with one entry for each selected element.

## Details

The following two expressions are equivalent:

 

    ts_tree_select(tree, <selectors>) |> ts_tree_unserialize()

and

 

    tree[[list(<selectors>)]]

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json |> ts_tree_select("b", 1)

    #> # jsonc (1 line, 1 selected element)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    json[[list("b", 1)]]

    #> [[1]]
    #> [1] 10
    #>

 

    toml <- tstoml::ts_parse_toml(
      '[table]\na = 1\nb = [10, 20, 30]\nc = { c1 = true, c2 = [] }\n'
    )
    toml |> ts_tree_select("table", "b", 1)

    #> # toml (4 lines, 1 selected element)
    #>   1 | [table]
    #>   2 | a = 1
    #> > 3 | b = [10, 20, 30]
    #>   4 | c = { c1 = true, c2 = [] }

 

    toml[[list("table", "b", 1)]]

    #> [[1]]
    #> [1] 10
    #>

### The `[[<-` replacement operator

The `[[<-` operator works similarly to the combination of
[`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md)
and
[`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md),
(and also to the replacement function
[`ts_tree_select<-()`](https://r-lib.github.io/ts/reference/select-set.md)),
but it might be more readable.

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

 

    json[[list("b", 1)]] <- 100
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

 

    toml[[list("table", "b", 1)]] <- 100
    toml

    #> # toml (4 lines)
    #> 1 | [table]
    #> 2 | a = 1
    #> 3 | b = [100.0, 20, 30]
    #> 4 | c = { c1 = true, c2 = [] }

## See also

Other ts_tree generics: `[[<-.ts_tree()`,
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

Other serialization functions:
[`ts_tree_unserialize()`](https://r-lib.github.io/ts/reference/ts_tree_unserialize.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{"a": 13, "b": [1, 2, 3], "c": "x"}')

tree
#> # jsonc (1 line)
#> 1 | {"a": 13, "b": [1, 2, 3], "c": "x"}

tree[[list("a")]]
#> [[1]]
#> [1] 13
#> 

# Last two elements of "b"
tree[[list("b", -(1:2))]]
#> [[1]]
#> [1] 2
#> 
#> [[2]]
#> [1] 3
#> 
```
