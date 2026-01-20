# Show the syntax tree of a tree-sitter tree

Show the structure of a tree-sitter tree as an S-expression.

### Available tree-sitter parsers

This is the manual page of the `ts_tree_sexpr()` S3 generic function.
Methods in parser packages may override this generic. For the ones that
do see the links to their manual pages in the table.

|                                                                                     |             |                  |            |
|-------------------------------------------------------------------------------------|-------------|------------------|------------|
| **Package**                                                                         | **Version** | **Title**        | **Method** |
| **[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)** | 0.0.0.9000  | Edit JSON Files. |            |
| **[tstoml](https://gaborcsardi.github.io/tstoml/reference/tstoml-package.html)**    | 0.0.0.9000  | Edit TOML files. |            |

## Usage

``` r
ts_tree_sexpr(tree)
```

## Arguments

- tree:

  A `ts_tree` object.

## Value

A string representing the S-expression of the syntax tree.

## Details

This function returns a nested list representation of the syntax tree,
where each node is represented as a list with its type and children.

## See also

Other `ts_tree` exploration:
[`ts_tree-brackets`](https://gaborcsardi.github.io/ts/reference/ts_tree-brackets.md),
[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md),
[`ts_tree_query()`](https://gaborcsardi.github.io/ts/reference/ts_tree_query.md)

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
[`ts_tree_unserialize()`](https://gaborcsardi.github.io/ts/reference/ts_tree_unserialize.md),
[`ts_tree_update()`](https://gaborcsardi.github.io/ts/reference/ts_tree_update.md),
[`ts_tree_write()`](https://gaborcsardi.github.io/ts/reference/ts_tree_write.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc(
  "{ \"a\": //comment\ntrue, \"b\": [1, 2, 3] }"
)

ts_tree_sexpr(tree)
#> [1] "(document (object (pair key: (string (string_content)) (comment) value: (true)) (pair key: (string (string_content)) value: (array (number) (number) (number)))))"

# Create a parse tree with tstoml --------------------------------------
tree <- tstoml::ts_parse_toml(r"(
  [servers]
  alpha = { ip = "127.0.0.1", dc = "eqdc10" }
  beta = { ip = "127.0.0.2", dc = "eqdc20" }
)")

ts_tree_sexpr(tree)
#> [1] "(document (table (bare_key) (pair (bare_key) (inline_table (pair (bare_key) (string (basic_string (basic_string_content)))) (pair (bare_key) (string (basic_string (basic_string_content)))))) (pair (bare_key) (inline_table (pair (bare_key) (string (basic_string (basic_string_content)))) (pair (bare_key) (string (basic_string (basic_string_content))))))))"
```
