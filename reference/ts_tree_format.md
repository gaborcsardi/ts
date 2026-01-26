# Format the selected elements of a tree sitter tree for printing

(Re)format the selected elements of the document represented by a
tree-sitter tree, if the tree-sitter parser supports formatting.

### Available tree-sitter parsers

This is the manual page of the `ts_tree_format()` S3 generic function.
Methods in parser packages may override this generic. For the ones that
do see the links to their manual pages in the table.

|                                                                                     |             |                  |                                                                                                                          |
|-------------------------------------------------------------------------------------|-------------|------------------|--------------------------------------------------------------------------------------------------------------------------|
| **Package**                                                                         | **Version** | **Title**        | **Method**                                                                                                               |
| **[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)** | 0.0.0.9000  | Edit JSON Files. | [`ts_tree_format(<ts_tree_tsjsonc>)`](https://gaborcsardi.github.io/tsjsonc/reference/ts_tree_format.ts_tree_jsonc.html) |
| **[tstoml](https://gaborcsardi.github.io/tstoml/reference/tstoml-package.html)**    | 0.0.0.9000  | Edit TOML files. | [`ts_tree_format(<ts_tree_tstoml>)`](https://gaborcsardi.github.io/tstoml/reference/ts_tree_format.ts_tree_toml.html)    |

## Usage

``` r
ts_tree_format(tree, options, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- options:

  A list of options for the formatting.

  See details in the manual of the specific parser.

- ...:

  Extra arguments for methods.

## Value

The `ts_tree` object of the reformatted document.

## Details

If `tree` does not have a selection, then the whole document is
formatted.

JSONC

TOML

 

    jsonc <- tsjsonc::ts_parse_jsonc("{ \"a\": [1,2,3] }")
    jsonc |> ts_tree_format()

    #> # jsonc (7 lines)
    #> 1 | {
    #> 2 |     "a": [
    #> 3 |         1,
    #> 4 |         2,
    #> 5 |         3
    #> 6 |     ]
    #> 7 | }

 

    toml <- tstoml::ts_parse_toml("a = [1,2,3]")
    toml |> ts_tree_format()

    #> # toml (1 line)
    #> 1 | a = [ 1, 2, 3 ]

If `tree` has an empty selection, then it is returned unchanged.

JSONC

TOML

 

    jsonc <- tsjsonc::ts_parse_jsonc("{ \"a\": [1,2,3] }")
    jsonc |> ts_tree_select("c") |> ts_tree_format()

    #> # jsonc (1 line)
    #> 1 | { "a": [1,2,3] }

 

    toml <- tstoml::ts_parse_toml("a = [1,2,3]")
    toml |> ts_tree_select("c") |> ts_tree_format()

    #> # toml (1 line)
    #> 1 | a = [1,2,3]

Some parsers support options to customize the formatting. See details in
the manual of the specific parser.

JSONC

 

    jsonc <- tsjsonc::ts_parse_jsonc("{ \"a\": [1,2,3] }") |>
      ts_tree_format()

 

    jsonc |> ts_tree_select(TRUE) |>
      ts_tree_format(options = list(format = "oneline"))

    #> # jsonc (3 lines)
    #> 1 | {
    #> 2 |     "a": [ 1, 2, 3 ]
    #> 3 | }

## See also

Methods in installed packages: `ts_tree_format(<ts_tree_tsjsonc>)` and
`ts_tree_format(<ts_tree_tstoml>)`.

Other `ts_tree` generics:
[`[[.ts_tree()`](https://gaborcsardi.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
[`format.ts_tree()`](https://gaborcsardi.github.io/ts/reference/format.ts_tree.md),
[`print.ts_tree()`](https://gaborcsardi.github.io/ts/reference/print.ts_tree.md),
[`select-set`](https://gaborcsardi.github.io/ts/reference/select-set.md),
[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_delete()`](https://gaborcsardi.github.io/ts/reference/ts_tree_delete.md),
[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md),
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
tree <- tsjsonc::ts_parse_jsonc('{ "a":true, "b": [1,2,3] }')
tree
#> # jsonc (1 line)
#> 1 | { "a":true, "b": [1,2,3] }

# Format whole document
tree |> ts_tree_format()
#> # jsonc (8 lines)
#> 1 | {
#> 2 |     "a": true,
#> 3 |     "b": [
#> 4 |         1,
#> 5 |         2,
#> 6 |         3
#> 7 |     ]
#> 8 | }

# Format each top element under the document node in one line
tree |> ts_tree_format() |>
  ts_tree_select(TRUE) |>
  ts_tree_format(options = list(format = "oneline"))
#> # jsonc (4 lines)
#> 1 | {
#> 2 |     "a": true,
#> 3 |     "b": [ 1, 2, 3 ]
#> 4 | }

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

tree |> ts_tree_format()
#> # toml (3 lines)
#> 1 | [servers]
#> 2 | alpha = { ip = "127.0.0.1", dc = "eqdc10" }
#> 3 | beta = { ip = "127.0.0.2", dc = "eqdc20" }
```
