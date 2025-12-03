# Create tree-sitter tree from file or string

This is the main function to create a tree-sitter parse tree, using a
parser from another package. Then the parse tree may be queried, edited,
formatted, written to file, etc. using ts_tree methods.

See the list of installed and loaded packages that provide parsers for
ts below at "Details".

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

  Language of the file or string, a `ts_language` object, e.g.
  [`tsjsonc::ts_language_jsonc()`](https://rdrr.io/pkg/tsjsonc/man/ts_language_jsonc.html).

- file:

  Path of a file. Use either `file` or `text`, but not both.

- text:

  String. Use either `file` or `text`, but not both.

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

A data frame with one row per token, and columns:

- `id`: integer, the id of the token. The (root) document node has id 1.

- `parent`: integer, the id of the parent token. The root token has
  parent `NA`

- `field_name`: character, the field name of the token in its parent.

- `type`: character, the type of the token.

- `code`: character, the actual code of the token.

- `start_byte`, `end_byte`: integer, the byte positions of the token in
  the input.

- `start_row`, `start_column`, `end_row`, `end_column`: integer, the
  position of the token in the input.

- `is_missing`: logical, whether the token is a missing token added by
  the parser to recover from errors.

- `has_error`: logical, whether the token has a parse error.

- `children`: list of integer vectors, the ids of the children tokens.

- `dom_type`: character, the type of the node in the DOM tree. See
  [`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md).
  Nodes that are not part of the DOM tree have `NA_character_` here.

- `dom_children`: list of integer vectors, the ids of the children in
  the DOM tree. See
  [`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md).

- `dom_parent`: integer, the parent of the node in the DOM tree. See
  [`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md).
  Nodes that are not part of the DOM tree and the document node have
  have `NA_integer_` here.

## Details

A package that implements a tree-sitter parser provides a function that
creates a `ts_language` object for that parser. E.g.
[tsjsonc](https://rdrr.io/pkg/tsjsonc/man/tsjsonc-package.html) has
[`tsjsonc::ts_language_jsonc()`](https://rdrr.io/pkg/tsjsonc/man/ts_language_jsonc.html).
You need to use the returned `ts_language` object as the `language`
argument of this function.

### Installed parsers

- [tsjsonc](https://rdrr.io/pkg/tsjsonc/man/tsjsonc-package.html)
  (0.0.0.9000) (loaded): Edit JSON Files.

## Examples

``` r
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
```
