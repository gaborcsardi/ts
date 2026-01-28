# Print the document object model (DOM) of a tree-sitter tree

`ts_tree_dom()` prints the document object model (DOM) tree of a ts_tree
object. This tree only includes semantic elements. E.g. for a JSON(C)
document it includes objects, arrays and various value types, but not
the syntax elements like brackets, commas or colons.

### Available tree-sitter parsers

This is the manual page of the `ts_tree_dom()` S3 generic function.
Methods in parser packages may override this generic. For the ones that
do see the links to their manual pages in the table.

|                                                                                     |             |                  |            |
|-------------------------------------------------------------------------------------|-------------|------------------|------------|
| **Package**                                                                         | **Version** | **Title**        | **Method** |
| **[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)** | 0.0.0.9000  | Edit JSON Files. |            |
| **[tstoml](https://gaborcsardi.github.io/tstoml/reference/tstoml-package.html)**    | 0.0.0.9000  | Edit TOML files. |            |

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

### The syntax tree and the DOM tree

See
[`ts_tree_ast()`](https://r-lib.github.io/ts/reference/ts_tree_ast.md)
for the complete tree-sitter syntax tree that includes all nodes,
including syntax elements like brackets and commas.

JSONC

TOML

 

    tree <- ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")

 

    ts_tree_ast(tree)

    #> document (1)                   1|
    #> └─object (2)                    |
    #>   ├─{ (3)                       |{
    #>   ├─pair (4)                    |
    #>   │ ├─string (5)                |
    #>   │ │ ├─" (6)                   |  "
    #>   │ │ ├─string_content (7)      |   a
    #>   │ │ └─" (8)                   |    "
    #>   │ ├─: (9)                     |     :
    #>   │ └─true (10)                 |       true
    #>   ├─, (11)                      |           ,
    #>   ├─pair (12)                   |
    #>   │ ├─string (13)               |
    #>   │ │ ├─" (14)                  |             "
    #>   │ │ ├─string_content (15)     |              b
    #>   │ │ └─" (16)                  |               "
    #>   │ ├─: (17)                    |                :
    #>   │ └─array (18)                |
    #>   │   ├─[ (19)                  |                  [
    #>   │   ├─number (20)             |                   1
    #>   │   ├─, (21)                  |                    ,
    #>   │   ├─number (22)             |                      2
    #>   │   ├─, (23)                  |                       ,
    #>   │   ├─number (24)             |                         3
    #>   │   └─] (25)                  |                          ]
    #>   └─} (26)                      |                            }

 

    ts_tree_dom(tree)

    #> document (1)
    #> └─object (2)
    #>   ├─true (10) # a
    #>   └─array (18) # b
    #>     ├─number (20)
    #>     ├─number (22)
    #>     └─number (24)

 

    tree <- ts_parse_toml("
      [package]
      name = 'tstoml'
      version = '0.1.0'"
    )

 

    ts_tree_ast(tree)

    #> document (1)                             1|
    #> └─table (2)                              2|
    #>   ├─[ (3)                                 |  [
    #>   ├─bare_key (4)                          |   package
    #>   ├─] (5)                                 |          ]
    #>   ├─pair (6)                             3|
    #>   │ ├─bare_key (7)                        |  name
    #>   │ ├─= (8)                               |       =
    #>   │ └─string (9)                          |
    #>   │   └─literal_string (10)               |
    #>   │     ├─' (11)                          |         '
    #>   │     ├─literal_string_content (12)     |          tstoml
    #>   │     └─' (13)                          |                '
    #>   └─pair (14)                            4|
    #>     ├─bare_key (15)                       |  version
    #>     ├─= (16)                              |          =
    #>     └─string (17)                         |
    #>       └─literal_string (18)               |
    #>         ├─' (19)                          |            '
    #>         ├─literal_string_content (20)     |             0.1.0
    #>         └─' (21)                          |                  '

 

    ts_tree_dom(tree)

    #> document (1)
    #> └─table (2) # package
    #>   ├─value (9) # name
    #>   └─value (17) # version

## See also

[`ts_tree_ast()`](https://r-lib.github.io/ts/reference/ts_tree_ast.md)
to show the annotated syntax tree of a ts_tree object.

Other ts_tree exploration:
[`ts_tree-brackets`](https://r-lib.github.io/ts/reference/ts_tree-brackets.md),
[`ts_tree_ast()`](https://r-lib.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_query()`](https://r-lib.github.io/ts/reference/ts_tree_query.md),
[`ts_tree_sexpr()`](https://r-lib.github.io/ts/reference/ts_tree_sexpr.md)

Other ts_tree generics:
[`[[.ts_tree()`](https://r-lib.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
[`format.ts_tree()`](https://r-lib.github.io/ts/reference/format.ts_tree.md),
[`print.ts_tree()`](https://r-lib.github.io/ts/reference/print.ts_tree.md),
[`select-set`](https://r-lib.github.io/ts/reference/select-set.md),
[`ts_tree_ast()`](https://r-lib.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_delete()`](https://r-lib.github.io/ts/reference/ts_tree_delete.md),
[`ts_tree_format()`](https://r-lib.github.io/ts/reference/ts_tree_format.md),
[`ts_tree_insert()`](https://r-lib.github.io/ts/reference/ts_tree_insert.md),
[`ts_tree_new()`](https://r-lib.github.io/ts/reference/ts_tree_new.md),
[`ts_tree_query()`](https://r-lib.github.io/ts/reference/ts_tree_query.md),
[`ts_tree_select()`](https://r-lib.github.io/ts/reference/ts_tree_select.md),
[`ts_tree_sexpr()`](https://r-lib.github.io/ts/reference/ts_tree_sexpr.md),
[`ts_tree_unserialize()`](https://r-lib.github.io/ts/reference/ts_tree_unserialize.md),
[`ts_tree_update()`](https://r-lib.github.io/ts/reference/ts_tree_update.md),
[`ts_tree_write()`](https://r-lib.github.io/ts/reference/ts_tree_write.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
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

# Create a parse tree with tstoml --------------------------------------
tree <- tstoml::ts_parse_toml(r"(
  title = "TOML Example"
  [owner]
  name = "Tom Preston-Werner"
  dob = 1979-05-27T07:32:00-08:00
)")

tree
#> # toml (5 lines)
#> 1 | 
#> 2 |   title = "TOML Example"
#> 3 |   [owner]
#> 4 |   name = "Tom Preston-Werner"
#> 5 |   dob = 1979-05-27T07:32:00-08:00

ts_tree_ast(tree)
#> document (1)                           1|
#> ├─pair (2)                             2|
#> │ ├─bare_key (3)                        |  title
#> │ ├─= (4)                               |        =
#> │ └─string (5)                          |
#> │   └─basic_string (6)                  |
#> │     ├─" (7)                           |          "
#> │     ├─basic_string_content (8)        |           TOML Example
#> │     └─" (9)                           |                       "
#> └─table (10)                           3|
#>   ├─[ (11)                              |  [
#>   ├─bare_key (12)                       |   owner
#>   ├─] (13)                              |        ]
#>   ├─pair (14)                          4|
#>   │ ├─bare_key (15)                     |  name
#>   │ ├─= (16)                            |       =
#>   │ └─string (17)                       |
#>   │   └─basic_string (18)               |
#>   │     ├─" (19)                        |         "
#>   │     ├─basic_string_content (20)     |          Tom Preston-Werner
#>   │     └─" (21)                        |                            "
#>   └─pair (22)                          5|
#>     ├─bare_key (23)                     |  dob
#>     ├─= (24)                            |      =
#>     └─offset_date_time (25)             |        1979-05-27T07:32:00-08:00

ts_tree_dom(tree)
#> document (1)
#> ├─value (5) # title
#> └─table (10) # owner
#>   ├─value (17) # name
#>   └─value (25) # dob
```
