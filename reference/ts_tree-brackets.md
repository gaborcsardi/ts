# Convert ts_tree object to a data frame

Create a data frame for the syntax tree of a JSON document, by indexing
a ts_tree object with single brackets. This is occasionally useful for
exploration and debugging.

## Usage

``` r
# S3 method for class 'ts_tree'
x[i, j, drop = FALSE]
```

## Arguments

- x:

  A `ts_tree` object.

- i, j:

  Incides, passed to the regular data.frame indexing method, see
  [`'Extract'`](https://rdrr.io/r/base/Extract.html).

- drop:

  Passed to the regular data.frame indexing method, see
  [`'Extract'`](https://rdrr.io/r/base/Extract.html).

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
  [`ts_tree_dom()`](https://r-lib.github.io/ts/reference/ts_tree_dom.md).
  Nodes that are not part of the DOM tree have `NA_character_` here.

- `dom_children`: list of integer vectors, the ids of the children in
  the DOM tree. See
  [`ts_tree_dom()`](https://r-lib.github.io/ts/reference/ts_tree_dom.md).

- `dom_parent`: integer, the parent of the node in the DOM tree. See
  [`ts_tree_dom()`](https://r-lib.github.io/ts/reference/ts_tree_dom.md).
  Nodes that are not part of the DOM tree and the document node have
  have `NA_integer_` here.

Other, undocumented columns may also be present, these are considered
internal and may change without notice.

## Details

A tree-sitter tree object has at least four classes:

- `ts_tree_<parser_name>`, e.g. `ts_tree_tsjsonc`,

- `ts_tree`,

- `tbl`, from the pillar package, for better printing when converted to
  a data frame, and

- `data.frame`, since it is a data frame internally.

The `ts_tree` class has custom
[`format()`](https://rdrr.io/r/base/format.html) and
[`print()`](https://rdrr.io/r/base/print.html) methods, that show (part
of) the underlying document, and also the selected elements, if any.

It is sometimes useful to treat a `tree` `ts_tree` object as a data
frame, and drop the `ts_tree` classes. This can be done by indexing with
single brackets, e.g. `tree[]`. This returns a data frame with one row
per token, and various columns with information about the tokens. See
details in the 'Value' section or this page.

## See also

Other ts_tree exploration:
[`ts_tree_ast()`](https://r-lib.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_dom()`](https://r-lib.github.io/ts/reference/ts_tree_dom.md),
[`ts_tree_query()`](https://r-lib.github.io/ts/reference/ts_tree_query.md),
[`ts_tree_sexpr()`](https://r-lib.github.io/ts/reference/ts_tree_sexpr.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')

tree
#> # jsonc (1 line)
#> 1 | {"foo": 42, "bar": [1, 2, 3]}

tree[]
#> # A data frame: 26 × 20
#>       id parent field_name type     code  start_byte end_byte start_row
#>    <int>  <int> <chr>      <chr>    <chr>      <int>    <int>     <int>
#>  1     1     NA NA         "docume…  NA            0       29         0
#>  2     2      1 NA         "object"  NA            0       29         0
#>  3     3      2 NA         "{"      "{"            0        1         0
#>  4     4      2 NA         "pair"    NA            1       10         0
#>  5     5      4 key        "string"  NA            1        6         0
#>  6     6      5 NA         "\""     "\""           1        2         0
#>  7     7      5 NA         "string… "foo"          2        5         0
#>  8     8      5 NA         "\""     "\""           5        6         0
#>  9     9      4 NA         ":"      ":"            6        7         0
#> 10    10      4 value      "number" "42"           8       10         0
#> # ℹ 16 more rows
#> # ℹ 12 more variables: start_column <int>, end_row <int>,
#> #   end_column <int>, is_missing <lgl>, has_error <lgl>,
#> #   expected <list>, children <I<list>>, tws <chr>,
#> #   dom_children <list>, dom_parent <int>, dom_name <chr>,
#> #   dom_type <chr>
```
