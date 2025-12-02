# Print the document object model (DOM) of a tree-sitter tree

`ts_tree_dom()` prints the document object model (DOM) tree of a ts_tree
object. This tree only includes semantic elements. E.g. for a JSON(C)
document it includes objects, arrays and various value types, but not
the syntax elements like brackets, commas or colons.

## Usage

``` r
ts_tree_dom(tree)
```

## Arguments

- tree:

  A `ts_tree` object.

## Value

Character vector, the formatted annotated syntax tree, line by line. It
has class [cli_tree](https://cli.r-lib.org/reference/tree.html), from
the cli package. It may contain ANSI escape sequences for coloring and
hyperlinks.

## Details

### The ts and ts\* packages:

Language implementations may override the default
[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md)
method, to provide language-specific features. Make sure you read the
correct documentation for the language you are using.

### The syntax tree and the DOM tree

See
[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md)
for the complete tree-sitter syntax tree that includes all nodes,
including syntax elements like brackets and commas.

## Examples

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

[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md)
to show the annotated syntax tree of a ts_tree object.

Other ts_tree functions:
[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md)

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
