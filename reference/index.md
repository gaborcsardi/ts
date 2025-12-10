# Package index

## About ts

- See [about](https://gaborcsardi.github.io/ts/reference/about.md) for
  an overview of ts.
- If you want to edit a document start at
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md)
  and
  [`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md).
- For more see the sections below.

- [`ts_list_parsers()`](https://gaborcsardi.github.io/ts/reference/ts_list_parsers.md)
  : List installed tree-sitter parsers

## Create tree-sitter trees

- [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md)
  : Create tree-sitter tree from file or string

## Selection

- [`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md)
  : Select parts of a tree-sitter tree

## Editing

- [`ts_tree_delete()`](https://gaborcsardi.github.io/ts/reference/ts_tree_delete.md)
  : TODO
- [`ts_tree_format()`](https://gaborcsardi.github.io/ts/reference/ts_tree_format.md)
  : Format a tree sitter tree for printing
- [`ts_tree_insert()`](https://gaborcsardi.github.io/ts/reference/ts_tree_insert.md)
  : Insert a new element into a tree sitter tree
- [`ts_tree_update()`](https://gaborcsardi.github.io/ts/reference/ts_tree_update.md)
  : TODO

## Manipulation

Another way to edit a tree-sitter tree is “in place”, using the
`ts_tre_select<-()` replacement function or the `[[<-` replacement
operator.

- [`` `ts_tree_select<-`() ``](https://gaborcsardi.github.io/ts/reference/select-set.md)
  : TODO
- [`` `[[<-`( ``*`<ts_tree>`*`)`](https://gaborcsardi.github.io/ts/reference/double-bracket-set-ts-tree.md)
  : Edit parts of a tree-sitter tree

## Formatting and printing

- [`print(`*`<ts_tree>`*`)`](https://gaborcsardi.github.io/ts/reference/print.ts_tree.md)
  : Print a tree-sitter tree
- [`format(`*`<ts_tree>`*`)`](https://gaborcsardi.github.io/ts/reference/format.ts_tree.md)
  : Format tree-sitter trees

## Unserialize

- [`` `[[`( ``*`<ts_tree>`*`)`](https://gaborcsardi.github.io/ts/reference/double-bracket-ts-tree.md)
  : Unserialize selected parts of a tree-sitter tree
- [`ts_tree_unserialize()`](https://gaborcsardi.github.io/ts/reference/ts_tree_unserialize.md)
  : TODO
- [`ts_tree_write()`](https://gaborcsardi.github.io/ts/reference/ts_tree_write.md)
  : Write a tree-sitter tree to a file

## Exploring

- [`` `[`( ``*`<ts_tree>`*`)`](https://gaborcsardi.github.io/ts/reference/ts_tree-brackets.md)
  : Convert ts_tree object to a data frame
- [`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md)
  : Show the annotated syntax tree of a tree-sitter tree
- [`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md)
  : Print the document object model (DOM) of a tree-sitter tree
- [`ts_tree_query()`](https://gaborcsardi.github.io/ts/reference/ts_tree_query.md)
  : Run tree-sitter queries on a file or string
- [`ts_tree_sexpr()`](https://gaborcsardi.github.io/ts/reference/ts_tree_sexpr.md)
  : Show the syntax tree structure of a file or string

## Functions for ts\* packages

- [`ts_collapse()`](https://gaborcsardi.github.io/ts/reference/internal.md)
  [`ts_cnd()`](https://gaborcsardi.github.io/ts/reference/internal.md)
  [`ts_caller_arg()`](https://gaborcsardi.github.io/ts/reference/internal.md)
  [`as_ts_caller_arg()`](https://gaborcsardi.github.io/ts/reference/internal.md)
  [`as.character(`*`<ts_caller_arg>`*`)`](https://gaborcsardi.github.io/ts/reference/internal.md)
  [`ts_caller_env()`](https://gaborcsardi.github.io/ts/reference/internal.md)
  [`ts_check_named_arg()`](https://gaborcsardi.github.io/ts/reference/internal.md)
  [`ts_parse_error_cnd()`](https://gaborcsardi.github.io/ts/reference/internal.md)
  : Utility functions for ts language implementations
- [`ts_tree_mark_selection1()`](https://gaborcsardi.github.io/ts/reference/ts_tree_mark_selection1.md)
  : TODO
- [`ts_tree_select1()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select1.md)
  : TODO
- [`ts_tree_selection()`](https://gaborcsardi.github.io/ts/reference/ts_tree_selection.md)
  [`ts_tree_selected_nodes()`](https://gaborcsardi.github.io/ts/reference/ts_tree_selection.md)
  : Helper functions for tree-sitter tree selections
