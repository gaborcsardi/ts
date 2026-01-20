# Run tree-sitter queries on tree-sitter trees

Use [tree-sitter's query
language](https://tree-sitter.github.io/tree-sitter/) to find nodes in a
tree-sitter tree.

### Available tree-sitter parsers

This is the manual page of the `ts_tree_query()` S3 generic function.
Methods in parser packages may override this generic. For the ones that
do see the links to their manual pages in the table.

|                                                                                     |             |                  |                                                                                                                        |
|-------------------------------------------------------------------------------------|-------------|------------------|------------------------------------------------------------------------------------------------------------------------|
| **Package**                                                                         | **Version** | **Title**        | **Method**                                                                                                             |
| **[tsjsonc](https://gaborcsardi.github.io/tsjsonc/reference/tsjsonc-package.html)** | 0.0.0.9000  | Edit JSON Files. | [`ts_tree_query(<ts_tree_tsjsonc>)`](https://gaborcsardi.github.io/tsjsonc/reference/ts_tree_query.ts_tree_jsonc.html) |
| **[tstoml](https://gaborcsardi.github.io/tstoml/reference/tstoml-package.html)**    | 0.0.0.9000  | Edit TOML files. |                                                                                                                        |

## Usage

``` r
ts_tree_query(tree, query)
```

## Arguments

- tree:

  A `ts_tree` object.

- query:

  Character string, the tree-sitter query to run.

## Value

A list with entries `patterns` and `matched_captures`.

`patterns` contains information about all patterns in the queries and it
is a data frame with columns: `id`, `name`, `pattern`, `match_count`.

`matched_captures` contains information about all matches, and it has
columns `id`, `pattern`, `match`, `start_byte`, `end_byte`, `start_row`,
`start_column`, `end_row`, `end_column`, `name`, `code`.

The `pattern` column of `matched_captured` refers to the `id` column of
`patterns`.

## Details

You probably need to know some details about the specific tree-sitter
parser you are using, to write effective queries. See the documentation
of the parser package you are using for details about the node types and
the query language support. See links below.

JSONC

 

    json <- tsjsonc::ts_parse_jsonc(
      '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": 100 } }'
    )
    json |> ts_tree_query("(number) @number")

    #> $patterns
    #> # A data frame: 1 × 4
    #>      id name  pattern              match_count
    #>   <int> <chr> <chr>                      <int>
    #> 1     1 NA    "(number) @number\n"           5
    #>
    #> $captures
    #> # A data frame: 1 × 2
    #>      id name
    #>   <int> <chr>
    #> 1     1 number
    #>
    #> $matched_captures
    #> # A data frame: 5 × 12
    #>      id pattern match type  start_byte end_byte start_row start_column
    #>   <int>   <int> <int> <chr>      <int>    <int>     <int>        <int>
    #> 1     1       1     1 numb…          7        8         0            7
    #> 2     1       1     2 numb…         16       18         0           16
    #> 3     1       1     3 numb…         20       22         0           20
    #> 4     1       1     4 numb…         24       26         0           24
    #> 5     1       1     5 numb…         54       57         0           54
    #> # ℹ 4 more variables: end_row <int>, end_column <int>, name <chr>,
    #> #   code <chr>
    #>

## See also

[`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md)
to select the nodes matching a query.

Method in installed package: `ts_tree_query(<ts_tree_tsjsonc>)`.

Other `ts_tree` exploration:
[`ts_tree-brackets`](https://gaborcsardi.github.io/ts/reference/ts_tree-brackets.md),
[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md),
[`ts_tree_sexpr()`](https://gaborcsardi.github.io/ts/reference/ts_tree_sexpr.md)

Other `ts_tree` generics:
[`[[.ts_tree()`](https://gaborcsardi.github.io/ts/reference/double-bracket-ts-tree.md),
`[[<-.ts_tree()`,
[`format.ts_tree()`](https://gaborcsardi.github.io/ts/reference/format.ts_tree.md),
[`print.ts_tree()`](https://gaborcsardi.github.io/ts/reference/print.ts_tree.md),
[`select-set`](https://gaborcsardi.github.io/ts/reference/select-set.md),
[`ts_tree_ast()`](https://gaborcsardi.github.io/ts/reference/ts_tree_ast.md),
[`ts_tree_delete()`](https://gaborcsardi.github.io/ts/reference/ts_tree_delete.md),
[`ts_tree_dom()`](https://gaborcsardi.github.io/ts/reference/ts_tree_dom.md),
[`ts_tree_format()`](https://gaborcsardi.github.io/ts/reference/ts_tree_format.md),
[`ts_tree_insert()`](https://gaborcsardi.github.io/ts/reference/ts_tree_insert.md),
[`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md),
[`ts_tree_select()`](https://gaborcsardi.github.io/ts/reference/ts_tree_select.md),
[`ts_tree_sexpr()`](https://gaborcsardi.github.io/ts/reference/ts_tree_sexpr.md),
[`ts_tree_unserialize()`](https://gaborcsardi.github.io/ts/reference/ts_tree_unserialize.md),
[`ts_tree_update()`](https://gaborcsardi.github.io/ts/reference/ts_tree_update.md),
[`ts_tree_write()`](https://gaborcsardi.github.io/ts/reference/ts_tree_write.md)

## Examples

``` r
# Select all numbers in a JSONC document ------------------------------------
json <- tsjsonc::ts_parse_jsonc(
  '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": 100 } }'
)
json |> ts_tree_query("(number) @number")
#> $patterns
#> # A data frame: 1 × 4
#>      id name  pattern              match_count
#>   <int> <chr> <chr>                      <int>
#> 1     1 NA    "(number) @number\n"           5
#> 
#> $captures
#> # A data frame: 1 × 2
#>      id name  
#>   <int> <chr> 
#> 1     1 number
#> 
#> $matched_captures
#> # A data frame: 5 × 12
#>      id pattern match type   start_byte end_byte start_row start_column
#>   <int>   <int> <int> <chr>       <int>    <int>     <int>        <int>
#> 1     1       1     1 number          7        8         0            7
#> 2     1       1     2 number         16       18         0           16
#> 3     1       1     3 number         20       22         0           20
#> 4     1       1     4 number         24       26         0           24
#> 5     1       1     5 number         54       57         0           54
#> # ℹ 4 more variables: end_row <int>, end_column <int>, name <chr>,
#> #   code <chr>
#> 
```
