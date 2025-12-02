# Show the annotated syntax tree of a tree-sitter tree

`ts_tree_ast()` prints the annotated syntax tree of a ts_tree object.
This syntax tree contains all tree-sitter nodes, and it shows the source
code associated with each node, along with line numbers.

## Usage

``` r
ts_tree_ast(tree)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

## Value

Character vector, the formatted annotated syntax tree, line by line. It
has class [cli_tree](https://cli.r-lib.org/reference/tree.html), from
the cli package. It may contain ANSI escape sequences for coloring and
hyperlinks.

## Details

### The ts and ts\* packages:

Language implementations may override the default `ts_tree_ast()`
method, to provide language-specific features. Make sure you read the
correct documentation for the language you are using.

### The syntax tree and the DOM tree

This syntax tree contains all nodes of the tree-sitter parse tree,
including both named and unnamed nodes and comments. E.g. for a JSON(C)
document it includes the pairs, brackets, braces, commas, colons, double
quotes and string escape sequences as separate nodes.

See
[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md)
for a tree that shows the semantic structure of the parsed document.

## Example output

    tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')
    ts_tree_ast(tree)
    #> document (1)                   1|
    #> \-object (2)                    |
    #>   +-{ (3)                       |{
    #>   +-pair (4)                    |
    #>   | +-string (5)                |
    #>   | | +-" (6)                   | "
    #>   | | +-string_content (7)      |  foo
    #>   | | \-" (8)                   |     "
    #>   | +-: (9)                     |      :
    #>   | \-number (10)               |        42
    #>   +-, (11)                      |          ,
    #>   +-pair (12)                   |
    #>   | +-string (13)               |
    #>   | | +-" (14)                  |            "
    #>   | | +-string_content (15)     |             bar
    #>   | | \-" (16)                  |                "
    #>   | +-: (17)                    |                 :
    #>   | \-array (18)                |
    #>   |   +-[ (19)                  |                   [
    #>   |   +-number (20)             |                    1
    #>   |   +-, (21)                  |                     ,
    #>   |   +-number (22)             |                       2
    #>   |   +-, (23)                  |                        ,
    #>   |   +-number (24)             |                          3
    #>   |   \-] (25)                  |                           ]
    #>   \-} (26)                      |                            }

    ts_tree_dom(tree)
    #> document (1)
    #> \-object (2)
    #>   +-number (10) # foo
    #>   \-array (18) # bar
    #>     +-number (20)
    #>     +-number (22)
    #>     \-number (24)

## See also

[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md)
to show the document object model (DOM) of a ts_tree object.

Other ts_tree functions:
[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md)

## Examples

``` r
# see the output above
tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')
tree
#> # jsonc (1 line)
#> 1 | {"foo": 42, "bar": [1, 2, 3]}
ts_tree_ast(tree)
#> document (1)                   1|
#> └─object (2)                    |
#>   ├─{ (3)                       |{
#>   ├─pair (4)                    |
#>   │ ├─string (5)                |
#>   │ │ ├─" (6)                   | "
#>   │ │ ├─string_content (7)      |  foo
#>   │ │ └─" (8)                   |     "
#>   │ ├─: (9)                     |      :
#>   │ └─number (10)               |        42
#>   ├─, (11)                      |          ,
#>   ├─pair (12)                   |
#>   │ ├─string (13)               |
#>   │ │ ├─" (14)                  |            "
#>   │ │ ├─string_content (15)     |             bar
#>   │ │ └─" (16)                  |                "
#>   │ ├─: (17)                    |                 :
#>   │ └─array (18)                |
#>   │   ├─[ (19)                  |                   [
#>   │   ├─number (20)             |                    1
#>   │   ├─, (21)                  |                     ,
#>   │   ├─number (22)             |                       2
#>   │   ├─, (23)                  |                        ,
#>   │   ├─number (24)             |                          3
#>   │   └─] (25)                  |                           ]
#>   └─} (26)                      |                            }
ts_tree_dom(tree)
#> document (1)
#> └─object (2)
#>   ├─number (10) # foo
#>   └─array (18) # bar
#>     ├─number (20)
#>     ├─number (22)
#>     └─number (24)
```
