# Insert a new element into a tree-sitter tree

Insert a new element into each selected element.

### Available tree-sitter parsers

This is the manual page of the `ts_tree_insert()` S3 generic function.
Methods in parser packages may override this generic. For the ones that
do see the links to their manual pages in the table.

|                                                                                     |             |                  |                                                                                                                          |
|-------------------------------------------------------------------------------------|-------------|------------------|--------------------------------------------------------------------------------------------------------------------------|
| **Package**                                                                         | **Version** | **Title**        | **Method**                                                                                                               |
| **[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)** | 0.0.0.9000  | Edit JSON Files. | [`ts_tree_insert(<ts_tree_tsjsonc>)`](https://gaborcsardi.github.io/tsjsonc/reference/ts_tree_insert.ts_tree_jsonc.html) |
| **[tstoml](https://gaborcsardi.github.io/tstoml/reference/tstoml-package.html)**    | 0.0.0.9000  | Edit TOML files. |                                                                                                                          |

## Usage

``` r
ts_tree_insert(tree, new, key, at, options, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- new:

  The new element to insert.

  The type of `new` depends on the parser and the method that implements
  the insertion. See details in the manual of the specific parser.

- key:

  The key of the new element, if inserting into a keyed element.

  For example a JSON(C) object or a TOML table are keyed elements.

- at:

  The position to insert the new element at.

  The interpretation of this argument depends on the method that
  implements the insertion. Typically the followings are supported:

  - `0` inserts at the beginning.

  - `Inf` inserts at the end.

  - A positive integer `n` inserts *after* the `n`-th element.

  - A character scalar inserts *after* the element with the given key,
    in keyed elements.

  See the details in the manual of the specific parser.

- options:

  A list of options for the insertion.

  See details in the manual of the specific parser.

- ...:

  Extra arguments for methods.

## Details

It is not always possible to insert a new element into a selected
element. For example in a JSONC document you can only insert a new
element into an array or an object, but not into scalar elements. If the
insertion is not possible, an error is raised.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")
    json |> ts_tree_select("a") |> ts_tree_insert("foo")

    #>   Cannot insert into a 'true' JSON element. Can only insert into 'array' and 'ob
    #> ject' elements and empty JSON documents.

 

    toml <- tstoml::ts_parse_toml("a = true\nb = [1, 2, 3]")
    toml |> ts_tree_select("a") |> ts_tree_insert("foo")

    #> Error in FUN(X[[i]], ...) : Cannot insert into a `value` TOML element.

If `tree` does not have a selection, the new element is inserted into at
the top level.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")
    json |> ts_tree_insert(key = "c", new = "foo")

    #> # jsonc (9 lines)
    #> 1 | {
    #> 2 |     "a": true,
    #> 3 |     "b": [
    #> 4 |         1,
    #> 5 |         2,
    #> 6 |         3
    #> 7 |     ],
    #> 8 |     "c": "foo"
    #> 9 | }

 

    toml <- tstoml::ts_parse_toml("a = true\nb = [1, 2, 3]")
    toml |> ts_tree_insert(key = "c", new = "foo")

    #> # toml (3 lines)
    #> 1 | a = true
    #> 2 | b = [1, 2, 3]
    #> 3 | c = "foo"

If `tree` has an empty selection, then it is returned unchanged, i.e. no
new element is inserted.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")
    json |> ts_tree_select("nonexistent") |> ts_tree_insert("foo")

    #> # jsonc (1 line, 0 selected elements)
    #> 1 | { "a": true, "b": [1, 2, 3] }

 

    toml <- tstoml::ts_parse_toml("a = true\nb = [1, 2, 3]")
    toml |> ts_tree_select("nonexistent") |> ts_tree_insert("foo")

    #> # toml (2 lines, 0 selected elements)
    #> 1 | a = true
    #> 2 | b = [1, 2, 3]

## See also

Method in installed package: `ts_tree_insert(<ts_tree_tsjsonc>)`.

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
tree <- tsjsonc::ts_parse_jsonc('{ "a": true, "b": [1, 2, 3] }')

tree |> ts_tree_select("b") |> ts_tree_insert(4, at = Inf)
#> # jsonc (6 lines)
#> 1 | { "a": true, "b": [
#> 2 |     1,
#> 3 |     2,
#> 4 |     3,
#> 5 |     4
#> 6 | ] }

# Create a parse tree with tstoml --------------------------------------
tree <- tstoml::ts_parse_toml(r"(
  [servers]
  alpha = { ip = "127.0.0.1", dc = "eqdc10" }
  beta = { ip = "127.0.0.2", dc = "eqdc20" }
)")

tree |>
  ts_tree_select("servers", TRUE) |>
  ts_tree_insert(key = "active", TRUE)
#> # toml (3 lines)
#> 1 | [servers]
#> 2 |   alpha = { ip = "127.0.0.1", dc = "eqdc10", active = true }
#> 3 |   beta = { ip = "127.0.0.2", dc = "eqdc20", active = true }
```
