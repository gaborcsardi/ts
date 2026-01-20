# Helper function to decide which AST nodes to highlight for a selection (internal)

This function are for packages implementing new parsers based on the ts
package. It is very unlikely that you will need to call this function
directly.

## Usage

``` r
ts_tree_mark_selection1(tree, node)

# S3 method for class 'ts_tree'
ts_tree_mark_selection1(tree, node)
```

## Arguments

- tree:

  Tree-sitter tree.

- node:

  Node id, integer scalar.

## Value

Integer vector of node ids to highlight.

## Details

In parsers where AST nodes do not correspond one-to-one to DOM nodes it
is useful to highlight multiple AST nodes for a single selected DOM
node. This generic function can be overridden in such parsers to return
multiple AST node ids for a single selected (DOM) node id.

The default implementation simply returns the input node id.
