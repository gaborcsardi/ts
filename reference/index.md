# Package index

## About ts

- See [‘About ts’](https://r-lib.github.io/ts/reference/about.md) for an
  overview of ts.
- If you want to edit a document start at
  [`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md)
  and
  [`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md).
- For more see the sections below.

- [`ts_list_parsers()`](https://r-lib.github.io/ts/reference/ts_list_parsers.md)
  : List installed tree-sitter parsers

## Create tree-sitter trees

- [`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md)
  : Create tree-sitter tree from file or string

## Selection

- [`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md)
  : Select elements of a tree-sitter tree

## Editing

- [`ts_tree_delete()`](https://r-lib.github.io/ts/reference/ts_tree_delete.md)
  : Delete selected elements from a tree-sitter tree
- [`ts_tree_format()`](https://r-lib.github.io/ts/reference/ts_tree_format.md)
  : Format the selected elements of a tree sitter tree for printing
- [`ts_tree_insert()`](https://r-lib.github.io/ts/reference/ts_tree_insert.md)
  : Insert a new element into a tree-sitter tree
- [`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md)
  : Replace selected elements with a new element in a tree-sitter tree

## Manipulation

Another way to edit a tree-sitter tree is “in place”, using the
`ts_tre_select<-()` replacement function or the `[[<-` replacement
operator.

- [`` `ts_tree_select<-`() ``](https://r-lib.github.io/ts/reference/select-set.md)
  : Edit parts of a tree-sitter tree
- [`` `[[<-`( ``*`<ts_tree>`*`)`](https://r-lib.github.io/ts/reference/double-bracket-set-ts-tree.md)
  : Edit parts of a tree-sitter tree

## Formatting and printing

- [`print(`*`<ts_tree>`*`)`](https://r-lib.github.io/ts/reference/print.ts_tree.md)
  : Print a tree-sitter tree
- [`format(`*`<ts_tree>`*`)`](https://r-lib.github.io/ts/reference/format.ts_tree.md)
  : Format tree-sitter trees

## Unserialize

- [`` `[[`( ``*`<ts_tree>`*`)`](https://r-lib.github.io/ts/reference/double-bracket-ts-tree.md)
  : Unserialize parts of a tree-sitter tree
- [`ts_tree_unserialize()`](https://r-lib.github.io/ts/reference/ts_tree_unserialize.md)
  : Unserialize selected elements of a tree-sitter tree
- [`ts_tree_write()`](https://r-lib.github.io/ts/reference/ts_tree_write.md)
  : Write a tree-sitter tree to a file

## Exploring

- [`` `[`( ``*`<ts_tree>`*`)`](https://r-lib.github.io/ts/reference/ts_tree-brackets.md)
  : Convert ts_tree object to a data frame
- [`ts_tree_ast()`](https://r-lib.github.io/ts/reference/ts_tree_ast.md)
  : Show the annotated syntax tree of a tree-sitter tree
- [`ts_tree_dom()`](https://r-lib.github.io/ts/reference/ts_tree_dom.md)
  : Print the document object model (DOM) of a tree-sitter tree
- [`ts_tree_query()`](https://r-lib.github.io/ts/reference/ts_tree_query.md)
  : Run tree-sitter queries on tree-sitter trees
- [`ts_tree_sexpr()`](https://r-lib.github.io/ts/reference/ts_tree_sexpr.md)
  : Show the syntax tree of a tree-sitter tree

## Functions for tree-sitter parser packages

These functions are intended to be used by packages that implement
tree-sitter parsers and use the `ts` package as a backend. It is
unlikely that you will need to use these functions directly.

- [`ts_collapse()`](https://r-lib.github.io/ts/reference/internal.md)
  [`ts_cnd()`](https://r-lib.github.io/ts/reference/internal.md)
  [`ts_caller_arg()`](https://r-lib.github.io/ts/reference/internal.md)
  [`as_ts_caller_arg()`](https://r-lib.github.io/ts/reference/internal.md)
  [`as.character(`*`<ts_caller_arg>`*`)`](https://r-lib.github.io/ts/reference/internal.md)
  [`ts_caller_env()`](https://r-lib.github.io/ts/reference/internal.md)
  [`ts_check_named_arg()`](https://r-lib.github.io/ts/reference/internal.md)
  [`ts_parse_error_cnd()`](https://r-lib.github.io/ts/reference/internal.md)
  : Utility functions for ts language implementations (internal)
- [`ts_tree_mark_selection1()`](https://r-lib.github.io/ts/reference/ts_tree_mark_selection1.md)
  : Helper function to decide which AST nodes to highlight for a
  selection (internal)
- [`ts_tree_select1()`](https://r-lib.github.io/ts/reference/ts_tree_select1.md)
  : Select nodes from a tree-sitter tree (internal)
- [`ts_tree_selection()`](https://r-lib.github.io/ts/reference/ts_tree_selection.md)
  [`ts_tree_selected_nodes()`](https://r-lib.github.io/ts/reference/ts_tree_selection.md)
  : Helper functions for tree-sitter tree selections (internal)
