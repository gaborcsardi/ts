# Unserialize selected elements of a tree-sitter tree

Unserialize the selected elements of a `ts_tree` object, i.e. convert
them to R objects.

### Available tree-sitter parsers

This is the manual page of the `ts_tree_unserialize()` S3 generic
function. Methods in parser packages may override this generic. For the
ones that do see the links to their manual pages in the table.

|                                                                                     |             |                  |                                                                                                                                    |
|-------------------------------------------------------------------------------------|-------------|------------------|------------------------------------------------------------------------------------------------------------------------------------|
| **Package**                                                                         | **Version** | **Title**        | **Method**                                                                                                                         |
| **[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)** | 0.0.0.9000  | Edit JSON Files. | [`ts_tree_unserialize(<ts_tree_tsjsonc>)`](https://gaborcsardi.github.io/tsjsonc/reference/ts_tree_unserialize.ts_tree_jsonc.html) |
| **[tstoml](https://gaborcsardi.github.io/tstoml/reference/tstoml-package.html)**    | 0.0.0.9000  | Edit TOML files. |                                                                                                                                    |

## Usage

``` r
ts_tree_unserialize(tree)
```

## Arguments

- tree:

  A `ts_tree` object.

## Details

If no elements are selected in the tree, then the whole document is
unserialized.

JSONC

 

    tree <- ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")

 

    ts_tree_unserialize(tree)

    #> [[1]]
    #> [[1]]$a
    #> [1] TRUE
    #>
    #> [[1]]$b
    #> [[1]]$b[[1]]
    #> [1] 1
    #>
    #> [[1]]$b[[2]]
    #> [1] 2
    #>
    #> [[1]]$b[[3]]
    #> [1] 3
    #>
    #>
    #>

If the tree has an empty selection, then an empty list is returned.

JSONC

 

    tree <- ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")

 

    tree |> ts_tree_select("nope") |> ts_tree_unserialize()

    #> list()

### The `[[` operator

The `[[` operator works similarly to the combination of
[`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md)
and `ts_tree_unserialize()`, but it might be more readable.

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

For the details on how the selected elements are mapped to R objects,
see the documentation of the methods in the parser packages. The methods
in the installed parser packages are linked below.

## See also

Method in installed package: `ts_tree_unserialize(<ts_tree_tsjsonc>)`.

Other `ts_tree` generics:
[`[[.ts_tree()`](https://gaborcsardi.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
[`format.ts_tree()`](https://gaborcsardi.github.io/ts/reference/format.ts_tree.md),
[`print.ts_tree()`](https://gaborcsardi.github.io/ts/reference/print.ts_tree.md),
[`select-set`](https://gaborcsardi.github.io/ts/reference/select-set.md),
[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_delete()`](https://gaborcsardi.github.io/ts/reference/ts_tree_delete.md),
[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md),
[`ts_tree_format()`](https://gaborcsardi.github.io/ts/reference/ts_tree_format.md),
[`ts_tree_insert()`](https://gaborcsardi.github.io/ts/reference/ts_tree_insert.md),
[`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md),
[`ts_tree_query()`](https://gaborcsardi.github.io/ts/reference/ts_tree_query.md),
[`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md),
[`ts_tree_sexpr()`](https://gaborcsardi.github.io/ts/reference/ts_tree_sexpr.md),
[`ts_tree_update()`](https://gaborcsardi.github.io/ts/reference/ts_tree_update.md),
[`ts_tree_write()`](https://gaborcsardi.github.io/ts/reference/ts_tree_write.md)

Other serialization functions:
[`[[.ts_tree()`](https://gaborcsardi.github.io/ts/reference/double-bracket-ts-tree.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{"a": 13, "b": [1, 2, 3], "c": "x"}')

tree
#> # jsonc (1 line)
#> 1 | {"a": 13, "b": [1, 2, 3], "c": "x"}

tree |> ts_tree_select(c("b", "c")) |> ts_tree_unserialize()
#> [[1]]
#> [[1]][[1]]
#> [1] 1
#> 
#> [[1]][[2]]
#> [1] 2
#> 
#> [[1]][[3]]
#> [1] 3
#> 
#> 
#> [[2]]
#> [1] "x"
#> 

tree |> ts_tree_select("b") |> ts_tree_unserialize()
#> [[1]]
#> [[1]][[1]]
#> [1] 1
#> 
#> [[1]][[2]]
#> [1] 2
#> 
#> [[1]][[3]]
#> [1] 3
#> 
#> 
```
