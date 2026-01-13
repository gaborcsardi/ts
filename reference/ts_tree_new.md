# Create tree-sitter tree from file or string

This is the main function to create a tree-sitter parse tree, using a ts
parser implemented in another package. The result is a `ts_tree` object.
A `ts_tree` object may be queried, edited, formatted, written to file,
etc. using `ts_tree` methods.

### Installed ts parsers

- **[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)**
  0.0.0.9000 (loaded): Edit JSON Files.

- **[tstoml](https://gaborcsardi.github.io/tstoml/reference/tstoml-package.html)**
  0.0.0.9000 (loaded): Edit TOML files.

## Usage

``` r
ts_tree_new(
  language,
  file = NULL,
  text = NULL,
  ranges = NULL,
  fail_on_parse_error = TRUE,
  ...
)
```

## Arguments

- language:

  Language of the file or string, a `ts_language` object,e.g. the return
  value of
  [`tsjsonc::ts_language_jsonc()`](https://gaborcsardi.github.io/tsjsonc/reference/ts_language_jsonc.html).

- file:

  Path of a file to parse. Use either `file` or `text`, but not both.

- text:

  String to parse. Use either `file` or `text`, but not both.

- ranges:

  Can be used to parse part(s) of the input. It must be a data frame
  with integer columns `start_row`, `start_col`, `end_row`, `end_col`,
  `start_byte`, `end_byte`, in this order.

- fail_on_parse_error:

  Logical, whether to error if there are parse errors in the document.
  Default is `TRUE`.

- ...:

  Additional arguments for methods.

## Value

A `ts_tree` object representing the parse tree of the input. You can use
the single bracket `` `[` `` operator to convert it to a data frame.

## Details

A package that implements a tree-sitter parser provides a function that
creates a `ts_language` object for that parser. E.g.
[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)
has
[`tsjsonc::ts_language_jsonc()`](https://gaborcsardi.github.io/tsjsonc/reference/ts_language_jsonc.html).
You need to use the returned `ts_language` object as the `language`
argument of `ts_tree_new()`.

JSONC

TOML

 

    jsonc <- ts::ts_tree_new(
      tsjsonc::ts_language_jsonc(),
      text = "{ \"a\": true, // comment\n \"b\": [1, 2, 3], }"
    )
    jsonc

    #> # jsonc (2 lines)
    #> 1 | { "a": true, // comment
    #> 2 |  "b": [1, 2, 3], }

 

    toml <- ts::ts_tree_new(
      tstoml::ts_language_toml(),
      text = "[table]\nkey = \"value\""
    )
    toml

    #> # toml (2 lines)
    #> 1 | [table]
    #> 2 | key = "value"

## See also

The tree-sitter parser packages typically include shortcuts to create
parse trees from strings and file, e.g.
[`tsjsonc::ts_parse_jsonc()`](https://gaborcsardi.github.io/tsjsonc/reference/ts_parse_jsonc.html)
and
[`tsjsonc::ts_read_jsonc()`](https://gaborcsardi.github.io/tsjsonc/reference/ts_parse_jsonc.html).

## Examples

``` r
# JSONC example, needs the tsjsonc package -----------------------------
json <- ts_tree_new(
  tsjsonc::ts_language_jsonc(),
  text = '{ "a": 1, "b": 2 }'
)

json
#> # jsonc (1 line)
#> 1 | { "a": 1, "b": 2 }

json |> ts_tree_format()
#> # jsonc (4 lines)
#> 1 | {
#> 2 |     "a": 1,
#> 3 |     "b": 2
#> 4 | }

# TOML example, needs the tstoml package -------------------------------
toml <- ts_tree_new(
  tstoml::ts_language_toml(),
  text = '[section]\nkey = "value"\nnumber = 42\n'
)

toml
#> # toml (3 lines)
#> 1 | [section]
#> 2 | key = "value"
#> 3 | number = 42

toml |> ts_tree_format()
#> # toml (3 lines)
#> 1 | [section]
#> 2 | key = "value"
#> 3 | number = 42
```
