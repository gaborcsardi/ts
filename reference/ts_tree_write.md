# Write a tree-sitter tree to a file

Writes the document of a ts `ts_tree` object to a file or connection.

## Usage

``` r
ts_tree_write(tree, file = NULL)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md).

- file:

  Character string, connection, or `NULL`. The file or connection to
  write to. By default it writes to the same file that was used in
  [`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md),
  if `tree` was read from a file.

## Value

Invisibly returns `NULL`.

## Details

If `tree` was created from a file, then `ts_tree_write()` by default
writes it back to the same file. Otherwise, the `file` argument must be
specified.

JSONC

TOML

Format a JSONC file:

 

    tree <- tsjsonc::ts_read_jsonc("config.json")
    tree |> ts_tree_format() |> ts_tree_write()

Format a TOML file:

 

    tree <- tstoml::ts_parse_toml("config.toml")
    tree |> ts_tree_format() |> ts_tree_write()

To write to a connection, pass a connection object to the `file`
argument. If the connection is opened in binary mode, the raw bytes are
written using [`base::writeBin()`](https://rdrr.io/r/base/readBin.html).
Otherwise, the raw bytes are converted to characters using the system
encoding before writing using
[`base::rawToChar()`](https://rdrr.io/r/base/rawConversion.html).

Use `file = stdout()` to write to the standard output, i.e. to the
console in an interactive R session.

## See also

Other ts_tree generics:
[`[[.ts_tree()`](https://r-lib.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
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
[`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')

# Format and write to file
tree |> ts_tree_format() |> ts_tree_write("example.json")
```
