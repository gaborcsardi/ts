# Select parts of a tree-sitter tree

This function is the heart of ts. To edit a tree-sitter tree, you first
need to select the parts you want to delete or update.

### Installed ts parsers

- [tsjsonc](https://rdrr.io/pkg/tsjsonc/man/tsjsonc-package.html)
  (0.0.0.9000) (loaded): Edit JSON Files.

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

### All elements: `TRUE`

Selects all child nodes of the current nodes.

*JSONC example*

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json |> ts_tree_select(c("b", "c"), TRUE)

    #> # jsonc (1 line, 5 selected elements)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

### Specific keys: character vector

Selects child nodes with the given names from nodes with named children.
If a node has no named children, it selects nothing from that node.

*JSONC example*

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json |> ts_tree_select(c("a", "c"), c("c1"))

    #> # jsonc (1 line, 1 selected element)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

### By position: integer vector

Selects child nodes by position. Positive indices count from the start,
negative indices count from the end. Zero indices are not allowed.

*JSONC*

For JSONC positional indices can be used both for arrays and objects.
For other nodes nothing is selected.

*JSONC example*

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json |> ts_tree_select(c("b", "c"), -1)

    #> # jsonc (1 line, 2 selected elements)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

### Matching keys: regular expression

A character scalar named `regex` can be used to select child nodes whose
names match the given regular expression, from nodes with named
children. If a node has no named children, it selects nothing from that
node.

*JSONC example*

    json <- tsjsonc::ts_parse_jsonc(
     '{ "apple": 1, "almond": 2, "banana": 3, "cherry": 4 }'
    )
    json |> ts_tree_select(regex = "^a")

    #> # jsonc (1 line, 2 selected elements)
    #> > 1 | { "apple": 1, "almond": 2, "banana": 3, "cherry": 4 }

### Tree sitter query matches

A character scalar named `query` can be used to select nodes matching a
tree-sitter query. See
[`ts_tree_query()`](https://gaborcsardi.github.io/ts/reference/ts_tree_query.md)
for details on tree-sitter queries.

*JSONC*

TODO: details of the JSONC grammar.

*JSONC example*

This example selects all numbers in the JSON document.

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": 100 } }'
    )
    json |> ts_tree_select(query = "(number) @number")

    #> # jsonc (1 line, 5 selected elements)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": 100 } }

### Explicit node ids

You can use `I(c(...))` to select nodes by their ids directly. This is
for advanced use cases only.

*JSONC example*

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    ts_tree_dom(json)
    json |> ts_tree_select(I(18))

    #> document (1)
    #> └─object (2)
    #>   ├─number (10) # a
    #>   ├─array (18) # b
    #>   │ ├─number (20)
    #>   │ ├─number (22)
    #>   │ └─number (24)
    #>   └─object (33) # c
    #>     ├─true (41) # c1
    #>     └─null (49) # c2
    #> # jsonc (1 line, 1 selected element)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

## Examples

``` r
# see more examples above
json <- ts_tree_new(
  tsjsonc::ts_language_jsonc(),
  text = '{ "a": 1, "b": 2, "c": { "d": 3, "e": 4 } }'
)
# Select all key-value pairs
json |> ts_tree_select("c", "d")
#> # jsonc (1 line, 1 selected element)
#> > 1 | { "a": 1, "b": 2, "c": { "d": 3, "e": 4 } }
```
