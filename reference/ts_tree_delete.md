# Delete selected elements from a tree-sitter tree

Use
[`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md)
to select the elements to be deleted, and then call `ts_tree_delete()`
to remove them from the tree.

### Available tree-sitter parsers

This is the manual page of the `ts_tree_delete()` S3 generic function.
Methods in parser packages may override this generic. For the ones that
do see the links to their manual pages in the table.

|                                                                                     |             |                  |                                                                                                                          |
|-------------------------------------------------------------------------------------|-------------|------------------|--------------------------------------------------------------------------------------------------------------------------|
| **Package**                                                                         | **Version** | **Title**        | **Method**                                                                                                               |
| **[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)** | 0.0.0.9000  | Edit JSON Files. | [`ts_tree_delete(<ts_tree_tsjsonc>)`](https://gaborcsardi.github.io/tsjsonc/reference/ts_tree_delete.ts_tree_jsonc.html) |
| **[tstoml](https://gaborcsardi.github.io/tstoml/reference/tstoml-package.html)**    | 0.0.0.9000  | Edit TOML files. | [`ts_tree_delete(<ts_tree_tstoml>)`](https://gaborcsardi.github.io/tstoml/reference/ts_tree_delete.ts_tree_toml.html)    |

## Usage

``` r
ts_tree_delete(tree, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- ...:

  Extra arguments for methods.

## Value

The modified `ts_tree` object with the selected elements removed.

## Details

The formatting of the rest of the document is left as is.

JSONC

 

    jsonc <- tsjsonc::ts_parse_jsonc(
      "{ \"a\": true, \"b\": [1, 2, 3] }"
    ) |>
      ts::ts_tree_format()
    jsonc

    #> # jsonc (8 lines)
    #> 1 | {
    #> 2 |     "a": true,
    #> 3 |     "b": [
    #> 4 |         1,
    #> 5 |         2,
    #> 6 |         3
    #> 7 |     ]
    #> 8 | }

 

    jsonc |> ts_tree_select("a") |> ts_tree_delete()

    #> # jsonc (7 lines)
    #> 1 | {
    #> 2 |     "b": [
    #> 3 |         1,
    #> 4 |         2,
    #> 5 |         3
    #> 6 |     ]
    #> 7 | }

If the tree does not have a selection, the tree corresponding to the
empty document is returned, i.e. the whole content is deleted.

JSONC

 

    jsonc <- tsjsonc::ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")
    jsonc |> ts_tree_delete()

    #> # jsonc (0 lines)

If the tree has a selection, but it is the empty selection, then the
tree is returned unchanged.

JSONC

 

    jsonc <- tsjsonc::ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")
    jsonc |> ts_tree_select("c") |> ts_tree_delete()

    #> # jsonc (1 line)
    #> 1 | { "a": true, "b": [1, 2, 3] }

For parsers that support comments, deleting elements that include
comments typically delete the comments as well. Other comments are kept
as is. See details in the manual of the specific parser.

JSONC

 

    jsonc <- tsjsonc::ts_parse_jsonc(
      "// top comment\n{ \"a\": // comment\n  true,\n \"b\": [1, 2, 3] }"
    ) |> ts::ts_tree_format()
    jsonc

    #> # jsonc (11 lines)
    #>  1 | // top comment
    #>  2 | {
    #>  3 |     "a":
    #>  4 |         // comment
    #>  5 |         true,
    #>  6 |     "b": [
    #>  7 |         1,
    #>  8 |         2,
    #>  9 |         3
    #> 10 |     ]
    #> ℹ 1 more line
    #> ℹ Use `print(n = ...)` to see more lines

 

    jsonc |> ts_tree_select("a") |> ts_tree_delete()

    #> # jsonc (8 lines)
    #> 1 | // top comment
    #> 2 | {
    #> 3 |     "b": [
    #> 4 |         1,
    #> 5 |         2,
    #> 6 |         3
    #> 7 |     ]
    #> 8 | }

## See also

Methods in installed packages: `ts_tree_delete(<ts_tree_tsjsonc>)` and
`ts_tree_delete(<ts_tree_tstoml>)`.

Other `ts_tree` generics:
[`[[.ts_tree()`](https://gaborcsardi.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
[`format.ts_tree()`](https://gaborcsardi.github.io/ts/reference/format.ts_tree.md),
[`print.ts_tree()`](https://gaborcsardi.github.io/ts/reference/print.ts_tree.md),
[`select-set`](https://gaborcsardi.github.io/ts/reference/select-set.md),
[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md),
[`ts_tree_format()`](https://gaborcsardi.github.io/ts/reference/ts_tree_format.md),
[`ts_tree_insert()`](https://gaborcsardi.github.io/ts/reference/ts_tree_insert.md),
[`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md),
[`ts_tree_query()`](https://gaborcsardi.github.io/ts/reference/ts_tree_query.md),
[`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md),
[`ts_tree_sexpr()`](https://gaborcsardi.github.io/ts/reference/ts_tree_sexpr.md),
[`ts_tree_unserialize()`](https://gaborcsardi.github.io/ts/reference/ts_tree_unserialize.md),
[`ts_tree_update()`](https://gaborcsardi.github.io/ts/reference/ts_tree_update.md),
[`ts_tree_write()`](https://gaborcsardi.github.io/ts/reference/ts_tree_write.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc(
  "{ \"a\": //comment\ntrue, \"b\": [1, 2, 3] }"
)

tree
#> # jsonc (2 lines)
#> 1 | { "a": //comment
#> 2 | true, "b": [1, 2, 3] }

tree |> ts_tree_select("a")
#> # jsonc (2 lines, 1 selected element)
#> > 1 | { "a": //comment
#>   2 | true, "b": [1, 2, 3] }

tree |> ts_tree_select("a") |> ts_tree_delete()
#> # jsonc (1 line)
#> 1 | { "b": [1, 2, 3] }
# Create a parse tree with tstoml --------------------------------------
tree <- tstoml::ts_parse_toml(r"(
  [servers]
  alpha = { ip = "127.0.0.1", dc = "eqdc10" }
  beta = { ip = "127.0.0.2", dc = "eqdc20" }
)")

tree
#> # toml (4 lines)
#> 1 | 
#> 2 |   [servers]
#> 3 |   alpha = { ip = "127.0.0.1", dc = "eqdc10" }
#> 4 |   beta = { ip = "127.0.0.2", dc = "eqdc20" }

tree |> ts_tree_select("servers", TRUE, "dc")
#> # toml (4 lines, 2 selected elements)
#>   1 | 
#>   2 |   [servers]
#> > 3 |   alpha = { ip = "127.0.0.1", dc = "eqdc10" }
#> > 4 |   beta = { ip = "127.0.0.2", dc = "eqdc20" }
tree |> ts_tree_select("servers", TRUE, "dc") |> ts_tree_delete()
#> # toml (3 lines)
#> 1 | [servers]
#> 2 |   alpha = { ip = "127.0.0.1" }
#> 3 |   beta = { ip = "127.0.0.2" }
```
