# Insert a new element into a tree sitter tree

TODO

## Usage

``` r
ts_tree_insert(tree, new, key, at, options, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- new:

  The new element to insert.

- key:

  The key of the new element, if inserting into a keyed element.

- at:

  The position to insert the new element at. The interpretation of this
  argument depends on the method that implements the insertion.

- options:

  A list of options for the insertion, see methods.

- ...:

  Extra arguments for methods.
