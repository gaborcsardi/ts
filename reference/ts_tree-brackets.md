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

  ts_tree object.

- i, j:

  indices.

- drop:

  Ignored.

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

Other, undocumented columns may also be present, these are considered
internal and may change without notice.

A data frame with columns: TODO.

## See also

TODO

## Examples

``` r
# TODO
```
