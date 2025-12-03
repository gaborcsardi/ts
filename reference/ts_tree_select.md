# Select parts of a tree-sitter tree

This function is the heart of ts. To edit a tree-sitter tree, you first
need to select the parts you want to delete or update.

## Usage

``` r
ts_tree_select(tree, ..., refine = FALSE)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

- ...:

  Selection expressions, see details.

- refine:

  Logical, whether to refine the current selection or start a new
  selection.

## Value

A `ts_tree` object with the selected parts.

## Details

A selection starts from the root of the DOM tree, the document node (see
[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md)),
unless `refine = TRUE` is set, in which case it starts from the current
selection.

A list of selection expressions is applied in order. Each selection
expression selects nodes from the currently selected nodes.

See the various types of selection expressions below.

### `TRUE`

Selects all child nodes of the current nodes.

### Character vector

Selects child nodes with the given names from nodes with named children.
If a node has no named children, it selects nothing from that node.

### Integer vector

Selects child nodes by position. Positive indices count from the start,
negative indices count from the end. Zero indices are not allowed.

### Regular expression

A character scalar named `regex` can be used to select child nodes whose
names match the given regular expression, from nodes with named
children. If a node has no named children, it selects nothing from that
node.

### Tree sitter query

A character scalar named `query` can be used to select nodes matching a
tree-sitter query. See
[`ts_tree_query()`](https://gaborcsardi.github.io/ts/reference/ts_tree_query.md)
for details on tree-sitter queries.

### Nodes ids

You can use `I(c(...))` to select nodes by their ids directly. This is
for advanced use cases only.
