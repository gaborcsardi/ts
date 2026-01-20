# Select nodes from a tree-sitter tree (internal)

This function is for packages implementing new parsers based on the ts
package. It is very unlikely that you will need to call this function
directly.

## Usage

``` r
# S3 method for class 'ts_tree.ts_tree_selector_default'
ts_tree_select1(tree, node, slt)

# S3 method for class 'ts_tree.NULL'
ts_tree_select1(tree, node, slt)

# S3 method for class 'ts_tree.ts_tree_selector_ids'
ts_tree_select1(tree, node, slt)

# S3 method for class 'ts_tree.ts_tree_selector_tsquery'
ts_tree_select1(tree, node, slt)

# S3 method for class 'ts_tree.character'
ts_tree_select1(tree, node, slt)

# S3 method for class 'ts_tree.integer'
ts_tree_select1(tree, node, slt)

# S3 method for class 'ts_tree.numeric'
ts_tree_select1(tree, node, slt)

# S3 method for class 'ts_tree.ts_tree_selector_regex'
ts_tree_select1(tree, node, slt)

# S3 method for class 'ts_tree.logical'
ts_tree_select1(tree, node, slt)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

- node:

  Integer scalar, the node id to select from.

- slt:

  A selector object, see details in
  [`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md).

## Details

A parser package may implement methods for this generic to change the
behavior of
[`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md)
for a certain selector type, or even add new selector types.

Each new method should be named as

    ts_tree_select.<ts_tree_class>.<selector_class>

The ts package implement deault methods for the selector types described
in the
[`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md)
manual page.

### `ts_tree_selector_default` selector

Method: `ts_tree_select1.ts_tree.ts_tree_selector_default`

This method is used to select the default element(s), when there is no
selected element. E.g. when starting a new selection from the root of
the DOM tree.

The default implementation returns the ids of all children of the
document root in the AST, except comments. If there are no such
children, it returns the id of the document root of the AST itself
(always id 1).

### `NULL` selector

Method: `ts_tree_select1.ts_tree.NULL`

This method is used for the `NULL` selector, that is supposed to clear
the selection. You probably do not need to override this method. The
default implementation returns an empty integer vector.

### `ts_tree_selector_ids` selector

Method: `ts_tree_select1.ts_tree.ts_tree_selector_ids`

This method is used to select nodes by their ids directly. You probably
do not need to override this method. The default implementation returns
the ids stored in the selector.

#### Note

This behaviour may change in the future to select only nodes in the
subtree of the current node.

### `ts_tree_selector_tsquery` selector

Method: `ts_tree_select1.ts_tree.ts_tree_selector_tsquery`

This method is used to select nodes matching a tree-sitter query. You
probably do not need to override this method. The default implementation
returns the ids stored in the selector.

#### Note

This behaviour may change in the future to select only nodes in the
subtree of the current node.

### `character` (character vector) selector

Method: `ts_tree_select1.ts_tree.character`

This method is used when the selector is a character vector. The default
implementation selects DOM children of `node` whose names are in the
character vector. If not all children o `node` are named, it returns an
empty integer vector. (E.g. in a JSONC document it returns an empty
integer vector when nodes is an array.)

### `integer` (integer vector) selector

Method: `ts_tree_select1.ts_tree.integer`

This method is used when the selector is an integer vector. The default
implementation selects DOM children of `node` by position. Positive
indices count from the start, negative indices count from the end. Zero
indices are not allowed and an error is raised if any are used.

### `numeric` (numeric, double vector) selector

Method: `ts_tree_select1.ts_tree.numeric`

This method is used when the selector is a numeric (double) vector. It
currrently coerces the numeric vector to integer and calls the integer
method.

### `ts_tree_selector_regex` (regular expression) selector

Method: `ts_tree_select1.ts_tree.ts_tree_selector_regex`

This method is used when the selector is a regular expression. The
default implementation selects DOM children of `node` whose names match
the regular expression. If not all children o `node` are named, it
returns an empty integer vector. (E.g. in a JSONC document it returns an
empty integer vector when nodes is an array.)

### `logical` (logical vector) selector

Method: `ts_tree_select1.ts_tree.logical`

This method is used when the selector is a logical vector. The default
implementation only supports scalar `TRUE`, which selects all DOM
children of `node`. Other values raise an error.
