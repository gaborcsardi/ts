# Select elements of a tree-sitter tree

This function is the heart of ts. To edit a tree-sitter tree, you first
need to select the parts you want to delete or update.

### Available tree-sitter parsers

This is the manual page of the `ts_tree_select()` S3 generic function.
Methods in parser packages may override this generic. For the ones that
do see the links to their manual pages in the table.

|                                                                                     |             |                  |                                                                                                                          |
|-------------------------------------------------------------------------------------|-------------|------------------|--------------------------------------------------------------------------------------------------------------------------|
| **Package**                                                                         | **Version** | **Title**        | **Method**                                                                                                               |
| **[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)** | 0.0.0.9000  | Edit JSON Files. | [`ts_tree_select(<ts_tree_tsjsonc>)`](https://gaborcsardi.github.io/tsjsonc/reference/ts_tree_select.ts_tree_jsonc.html) |
| **[tstoml](https://gaborcsardi.github.io/tstoml/reference/tstoml-package.html)**    | 0.0.0.9000  | Edit TOML files. | [`ts_tree_select(<ts_tree_tstoml>)`](https://gaborcsardi.github.io/tstoml/reference/ts_tree_select.ts_tree_toml.html)    |

## Usage

``` r
ts_tree_select(tree, ..., refine = FALSE)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md).

- ...:

  Selection expressions, see details.

- refine:

  Logical, whether to refine the current selection or start a new
  selection.

## Value

A `ts_tree` object with the selected parts.

## Details

The selection process is iterative. Selection expressions (selectors)
are applied one by one, and each selector selects nodes from the
currently selected nodes. For each selector, it is applied individually
to each currently selected node, and the results are concatenated.

The selection process starts from the root of the DOM tree, the document
node (see
[`ts_tree_dom()`](https://r-lib.github.io/ts/reference/ts_tree_dom.md)),
unless `refine = TRUE` is set, in which case it starts from the current
selection.

See the various types of selection expressions below.

### Selectors

#### All elements: `TRUE`

Selects all child nodes of the current nodes.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json |> ts_tree_select(c("b", "c"), TRUE)

    #> # jsonc (1 line, 5 selected elements)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    toml <- tstoml::ts_parse_toml('
      a = 1
      b = [10, 20, 30]
      [c]
      c1 = true
      c2 = []
    ')
    toml |> ts_tree_select(c("b", "c"), TRUE)

    #> # toml (6 lines, 5 selected elements)
    #>   1 | 
    #>   2 |   a = 1
    #> > 3 |   b = [10, 20, 30]
    #>   4 |   [c]
    #> > 5 |   c1 = true
    #> > 6 |   c2 = []

#### Specific keys: character vector

Selects child nodes with the given names from nodes with named children.
If a node has no named children, it selects nothing from that node.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json |> ts_tree_select(c("a", "c"), c("c1"))

    #> # jsonc (1 line, 1 selected element)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    toml <- tstoml::ts_parse_toml('
      a = 1
      b = [10, 20, 30]
      [c]
      c1 = true
      c2 = []
    ')
    toml |> ts_tree_select(c("a", "c"), "c1")

    #> # toml (6 lines, 1 selected element)
    #>   2 |   a = 1
    #>   3 |   b = [10, 20, 30]
    #>   4 |   [c]
    #> > 5 |   c1 = true
    #>   6 |   c2 = []

#### By position: integer vector

Selects child nodes by position. Positive indices count from the start,
negative indices count from the end. Zero indices are not allowed.

JSONC

TOML

For JSONC positional indices can be used both for arrays and objects.
For other nodes nothing is selected.

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json |> ts_tree_select(c("b", "c"), -1)

    #> # jsonc (1 line, 2 selected elements)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    toml <- tstoml::ts_parse_toml('
      a = 1
      b = [10, 20, 30]
      [c]
      c1 = true
      c2 = []
    ')
    toml |> ts_tree_select(c("b", "c"), -1)

    #> # toml (6 lines, 2 selected elements)
    #>   1 | 
    #>   2 |   a = 1
    #> > 3 |   b = [10, 20, 30]
    #>   4 |   [c]
    #>   5 |   c1 = true
    #> > 6 |   c2 = []

#### Matching keys: regular expression

A character scalar named `regex` can be used to select child nodes whose
names match the given regular expression, from nodes with named
children. If a node has no named children, it selects nothing from that
node.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
     '{ "apple": 1, "almond": 2, "banana": 3, "cherry": 4 }'
    )
    json |> ts_tree_select(regex = "^a")

    #> # jsonc (1 line, 2 selected elements)
    #> > 1 | { "apple": 1, "almond": 2, "banana": 3, "cherry": 4 }

 

    toml <- tstoml::ts_parse_toml(
     'apple = 1\nalmond = 2\nbanana = 3\ncherry = 4\n'
    )
    toml |> ts_tree_select(regex = "^a")

    #> # toml (4 lines, 2 selected elements)
    #> > 1 | apple = 1
    #> > 2 | almond = 2
    #>   3 | banana = 3
    #>   4 | cherry = 4

#### Tree sitter query matches

A character scalar named `query` can be used to select nodes matching a
tree-sitter query. See
[`ts_tree_query()`](https://r-lib.github.io/ts/reference/ts_tree_query.md)
for details on tree-sitter queries.

Instead of a character scalar this can also be a two-element list, where
the first element is the query string and the second element is a
character vector of capture names to select. In this case only nodes
matching the given capture names will be selected.

JSONC

TOML

See
[`ts_language_jsonc()`](https://gaborcsardi.github.io/tsjsonc/reference/ts_language_jsonc.html)
for details on the JSONC grammar.

This example selects all numbers in the JSON document.

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": 100 } }'
    )
    json |> ts_tree_select(query = "(number) @number")

    #> # jsonc (1 line, 5 selected elements)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": 100 } }

See
[`tstoml::ts_language_toml()`](https://gaborcsardi.github.io/tstoml/reference/ts_language_toml.html)
for details on the TOML grammar.

This example selects all integers in the TOML document.

 

    toml <- tstoml::ts_parse_toml(
      'a = 1\nb = [10, 20, 30]\nc = { c1 = true, c2 = 100 }\n'
    )
    toml |> ts_tree_select(query = "(integer) @integer")

    #> # toml (3 lines, 5 selected elements)
    #> > 1 | a = 1
    #> > 2 | b = [10, 20, 30]
    #> > 3 | c = { c1 = true, c2 = 100 }

#### Explicit node ids

You can use `I(c(...))` to select nodes by their ids directly. This is
for advanced use cases only.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    ts_tree_dom(json)

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

 

    json |> ts_tree_select(I(18))

    #> # jsonc (1 line, 1 selected element)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    toml <- tstoml::ts_parse_toml(
      'a = 1\nb = [10, 20, 30]\nc = { c1 = true, c2 = [] }\n'
    )
    ts_tree_dom(toml)

    #> document (1)
    #> ├─value (5) # a
    #> ├─array (9) # b
    #> │ ├─value (11)
    #> │ ├─value (13)
    #> │ └─value (15)
    #> └─inline_table (20) # c
    #>   ├─value (25) # c1
    #>   └─array (30) # c2

 

    toml |> ts_tree_select(I(9))

    #> # toml (3 lines, 1 selected element)
    #>   1 | a = 1
    #> > 2 | b = [10, 20, 30]
    #>   3 | c = { c1 = true, c2 = [] }

### Refining selections

If the `refine` argument of `ts_tree_select()` is `TRUE`, then the
selection starts from the already selected elements (all of them
simultanously), instead of starting from the document element.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json <- json |> ts_tree_select(c("b", "c"))

 

    json |> ts_tree_select(1:2)

    #> # jsonc (1 line, 2 selected elements)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    json |> ts_tree_select(1:2, refine = TRUE)

    #> # jsonc (1 line, 4 selected elements)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    toml <- tstoml::ts_parse_toml(
      '[table]\na = 1\nb = [10, 20, 30]\nc = { c1 = true, c2 = [] }\n'
    )
    toml <- toml |> ts_tree_select("table", "b")

 

    # selects the first two elements in the document node, ie. "table"
    toml |> ts_tree_select(1:2)

    #> # toml (4 lines, 1 selected element)
    #> > 1 | [table]
    #> > 2 | a = 1
    #> > 3 | b = [10, 20, 30]
    #> > 4 | c = { c1 = true, c2 = [] }

 

    # selects the first two elements inside "table" and "b"
    toml |> ts_tree_select(1:2, refine = TRUE)

    #> # toml (4 lines, 2 selected elements)
    #>   1 | [table]
    #>   2 | a = 1
    #> > 3 | b = [10, 20, 30]
    #>   4 | c = { c1 = true, c2 = [] }

### The `ts_tree_select<-()` replacement function

The
[`ts_tree_select<-()`](https://r-lib.github.io/ts/reference/select-set.md)
replacement function works similarly to the combination of
`ts_tree_select()` and
[`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md),
but it might be more readable.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json

    #> # jsonc (1 line)
    #> 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    json |> ts_tree_select("b", 1)

    #> # jsonc (1 line, 1 selected element)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    ts_tree_select(json, "b", 1) <- 100
    json

    #> # jsonc (1 line)
    #> 1 | { "a": 1, "b": [100, 20, 30], "c": { "c1": true, "c2": null } }

 

    toml <- tstoml::ts_parse_toml(
      '[table]\na = 1\nb = [10, 20, 30]\nc = { c1 = true, c2 = [] }\n'
    )
    toml

    #> # toml (4 lines)
    #> 1 | [table]
    #> 2 | a = 1
    #> 3 | b = [10, 20, 30]
    #> 4 | c = { c1 = true, c2 = [] }

 

    toml |> ts_tree_select("table", "b", 1)

    #> # toml (4 lines, 1 selected element)
    #>   1 | [table]
    #>   2 | a = 1
    #> > 3 | b = [10, 20, 30]
    #>   4 | c = { c1 = true, c2 = [] }

 

    ts_tree_select(toml, "table", "b", 1) <- 100
    toml

    #> # toml (4 lines)
    #> 1 | [table]
    #> 2 | a = 1
    #> 3 | b = [100.0, 20, 30]
    #> 4 | c = { c1 = true, c2 = [] }

### The `[[` and `[[<-` operators

The `[[` operator works similarly to the combination of
`ts_tree_select()` and
[`ts_tree_unserialize()`](https://r-lib.github.io/ts/reference/ts_tree_unserialize.md),
but it might be more readable.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json |> ts_tree_select("b", 1)

    #> # jsonc (1 line, 1 selected element)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    json[[list("b", 1)]]

    #> [[1]]
    #> [1] 10
    #>

 

    toml <- tstoml::ts_parse_toml(
      '[table]\na = 1\nb = [10, 20, 30]\nc = { c1 = true, c2 = [] }\n'
    )
    toml |> ts_tree_select("table", "b", 1)

    #> # toml (4 lines, 1 selected element)
    #>   1 | [table]
    #>   2 | a = 1
    #> > 3 | b = [10, 20, 30]
    #>   4 | c = { c1 = true, c2 = [] }

 

    toml[[list("table", "b", 1)]]

    #> [[1]]
    #> [1] 10
    #>

The `[[<-` operator works similarly to the combination of
`ts_tree_select()` and
[`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md),
(and also to the replacement function
[`ts_tree_select<-()`](https://r-lib.github.io/ts/reference/select-set.md)),
but it might be more readable.

JSONC

TOML

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
    )
    json

    #> # jsonc (1 line)
    #> 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    json |> ts_tree_select("b", 1)

    #> # jsonc (1 line, 1 selected element)
    #> > 1 | { "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }

 

    json[[list("b", 1)]] <- 100
    json

    #> # jsonc (1 line)
    #> 1 | { "a": 1, "b": [100, 20, 30], "c": { "c1": true, "c2": null } }

 

    toml <- tstoml::ts_parse_toml(
      '[table]\na = 1\nb = [10, 20, 30]\nc = { c1 = true, c2 = [] }\n'
    )
    toml

    #> # toml (4 lines)
    #> 1 | [table]
    #> 2 | a = 1
    #> 3 | b = [10, 20, 30]
    #> 4 | c = { c1 = true, c2 = [] }

 

    toml |> ts_tree_select("table", "b", 1)

    #> # toml (4 lines, 1 selected element)
    #>   1 | [table]
    #>   2 | a = 1
    #> > 3 | b = [10, 20, 30]
    #>   4 | c = { c1 = true, c2 = [] }

 

    toml[[list("table", "b", 1)]] <- 100
    toml

    #> # toml (4 lines)
    #> 1 | [table]
    #> 2 | a = 1
    #> 3 | b = [100.0, 20, 30]
    #> 4 | c = { c1 = true, c2 = [] }

## See also

Methods in installed packages: `ts_tree_select(<ts_tree_tsjsonc>)` and
`ts_tree_select(<ts_tree_tstoml>)`.

Other ts_tree generics:
[`[[.ts_tree()`](https://r-lib.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
[`format.ts_tree()`](https://r-lib.github.io/ts/reference/format.ts_tree.md),
[`print.ts_tree()`](https://r-lib.github.io/ts/reference/print.ts_tree.md),
[`select-set`](https://r-lib.github.io/ts/reference/select-set.md),
[`ts_tree_ast()`](https://r-lib.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_delete()`](https://r-lib.github.io/ts/reference/ts_tree_delete.md),
[`ts_tree_dom()`](https://r-lib.github.io/ts/reference/ts_tree_dom.md),
[`ts_tree_format()`](https://r-lib.github.io/ts/reference/ts_tree_format.md),
[`ts_tree_insert()`](https://r-lib.github.io/ts/reference/ts_tree_insert.md),
[`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md),
[`ts_tree_query()`](https://r-lib.github.io/ts/reference/ts_tree_query.md),
[`ts_tree_sexpr()`](https://r-lib.github.io/ts/reference/ts_tree_sexpr.md),
[`ts_tree_unserialize()`](https://r-lib.github.io/ts/reference/ts_tree_unserialize.md),
[`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md),
[`ts_tree_write()`](https://r-lib.github.io/ts/reference/ts_tree_write.md)

## Examples

``` r
# ----------------------------------------------------------------------
# Create a JSONC tree, needs the tsjsonc package
json <- ts_tree_new(
  tsjsonc::ts_language_jsonc(),
  text = '{ "a": 1, "b": 2, "c": { "d": 3, "e": 4 } }'
)

json |> ts_tree_select("c", "d")
#> # jsonc (1 line, 1 selected element)
#> > 1 | { "a": 1, "b": 2, "c": { "d": 3, "e": 4 } }

# ----------------------------------------------------------------------
# Create a TOML tree, needs the tstoml package
toml <- ts_tree_new(
  tstoml::ts_language_toml(),
  text = tstoml::toml_example_text()
)

toml |> ts_tree_select("servers", TRUE, "ip")
#> # toml (23 lines, 2 selected elements)
#>   ...   
#>   15  | [servers]
#>   16  | 
#>   17  | [servers.alpha]
#> > 18  | ip = "10.0.0.1"
#>   19  | role = "frontend"
#>   20  | 
#>   21  | [servers.beta]
#> > 22  | ip = "10.0.0.2"
#>   23  | role = "backend"
```
