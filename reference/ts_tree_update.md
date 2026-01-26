# Replace selected elements with a new element in a tree-sitter tree

Replace all selected elements with a new element.

## Usage

``` r
ts_tree_update(tree, new, options, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- new:

  The new element to replace the selected elements with.

  The type of `new` depends on the parser and the method that implements
  the insertion. See details in the manual of the specific parser.

- options:

  A list of options for the update.

  See details in the manual of the specific parser.

- ...:

  Extra arguments for methods.

## Value

The modified `ts_tree` object with the selected elements replaced by the
new element.

## Details

If the tree does not have a selection, the new element replaces the
whole document.

JSONC

 

    tree <- tsjsonc::ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")
    tree |> ts_tree_update(as.list(4:6))

    #> # jsonc (5 lines)
    #> 1 | [
    #> 2 |   4,
    #> 3 |   5,
    #> 4 |   6
    #> 5 | ]

If the tree has an empty selection, the new element is inserted at the
position of where the selected elements would be.

JSONC

TOML

 

    tree <- tsjsonc::ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")
    tree |> ts_tree_select("new") |> ts_tree_update(as.list(4:6))

    #> # jsonc (13 lines)
    #>  1 | {
    #>  2 |     "a": true,
    #>  3 |     "b": [
    #>  4 |         1,
    #>  5 |         2,
    #>  6 |         3
    #>  7 |     ],
    #>  8 |     "new": [
    #>  9 |         4,
    #> 10 |         5,
    #> ℹ 3 more lines
    #> ℹ Use `print(n = ...)` to see more lines

 

    tree <- tstoml::ts_parse_toml("a = true\nb = [1, 2, 3]")
    tree |> ts_tree_select("new") |> ts_tree_update(as.list(4:6))

    #> # toml (3 lines)
    #> 1 | a = true
    #> 2 | b = [1, 2, 3]
    #> 3 | new = [ 4, 5, 6 ]

## See also

Methods in installed packages: `ts_tree_update(<ts_tree_tsjsonc>)` and
`ts_tree_update(<ts_tree_tstoml>)`.

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
[`ts_tree_unserialize()`](https://gaborcsardi.github.io/ts/reference/ts_tree_unserialize.md),
[`ts_tree_write()`](https://gaborcsardi.github.io/ts/reference/ts_tree_write.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc(r"(
  {
    "name": "example",
    "version": "1.0.0",
    "dependencies": {
      "tsjsonc": "^0.1.0"
    }
  }
)")

tree |> ts_tree_select("version") |> ts_tree_update("2.0.0")
#> # jsonc (8 lines)
#> 1 | 
#> 2 |   {
#> 3 |     "name": "example",
#> 4 |     "version": "2.0.0",
#> 5 |     "dependencies": {
#> 6 |       "tsjsonc": "^0.1.0"
#> 7 |     }
#> 8 |   }
# Create a parse tree with tstoml --------------------------------------
tree <- tstoml::ts_parse_toml(r"(
  [package]
  name = "example"
  version = "1.0.0"
  depdendencies = { tstoml = "0.1.0" }
)")

tree |> ts_tree_select("package", "version") |> ts_tree_update("2.0.0")
#> # toml (4 lines)
#> 1 | [package]
#> 2 |   name = "example"
#> 3 |   version = "2.0.0"
#> 4 |   depdendencies = { tstoml = "0.1.0" }
```
