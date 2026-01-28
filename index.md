# ts

Common tree-sitter parsing tools for R.

ts is a common interface to
[tree-sitter](https://tree-sitter.github.io/tree-sitter/) parsers,
implemented in other R packages. It has a common API to

- query,
- edit,
- format, and
- unserialize

tree-sitter parse trees.

## Installation

You can install the development version of ts from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("r-lib/ts")
```

## Documentation

See at
[`https://r-lib.github.io/ts/`](https://r-lib.github.io/ts/reference/index.html)
and also in the installed package:
[`help(package = "ts")`](https://gaborcsardi.github.io/ts/reference).

## Parsers that use ts

- JSONC (JSON with comments and trailing commas):
  [tsjsonc](https://gaborcsardi.github.io/tsjsonc/).
- TOML: [tstoml](https://gaborcsardi.github.io/tstoml/).

## Quickstart

In this document I show examples with the `tsjsonc` package.

### Create a tree-sitter tree

Create a ts_tree (ts_tree_jsonc) object from a string:

``` r
txt <- r"(
// this is a comment
{
  "a": {
    "a1": [1, 2, 3],
    // comment
    "a2": "string"
  },
  "b": [
    {
      "b11": true,
      "b12": false
    },
    {
      "b21": false,
      "b22": false
    }
  ]
}
)"

json <- tsjsonc::ts_parse_jsonc(txt)
```

Pretty print a ts_tree object:

``` r
json
```

    #> # jsonc (19 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a1": [1, 2, 3],
    #>  6 |     // comment
    #>  7 |     "a2": "string"
    #>  8 |   },
    #>  9 |   "b": [
    #> 10 |     {
    #> ℹ 9 more lines
    #> ℹ Use `print(n = ...)` to see more lines

### Select nodes of a tree

Selecting nodes is the basis of editing and querying tree-sitter trees.

Select element by objects key:

``` r
ts_tree_select(json, "a")
```

    #> # jsonc (19 lines, 1 selected element)
    #>    1  | 
    #>    2  | // this is a comment
    #>    3  | {
    #> >  4  |   "a": {
    #> >  5  |     "a1": [1, 2, 3],
    #> >  6  |     // comment
    #> >  7  |     "a2": "string"
    #> >  8  |   },
    #>    9  |   "b": [
    #>   10  |     {
    #>   11  |       "b11": true,
    #>   ...

Select element inside element:

``` r
ts_tree_select(json, "a", "a1")
```

    #> # jsonc (19 lines, 1 selected element)
    #>   2   | // this is a comment
    #>   3   | {
    #>   4   |   "a": {
    #> > 5   |     "a1": [1, 2, 3],
    #>   6   |     // comment
    #>   7   |     "a2": "string"
    #>   8   |   },
    #>   ...

Select element(s) of an array:

``` r
ts_tree_select(json, "a", "a1", 1:2)
```

    #> # jsonc (19 lines, 2 selected elements)
    #>   2   | // this is a comment
    #>   3   | {
    #>   4   |   "a": {
    #> > 5   |     "a1": [1, 2, 3],
    #>   6   |     // comment
    #>   7   |     "a2": "string"
    #>   8   |   },
    #>   ...

Select multiple keys from an object:

``` r
ts_tree_select(json, "a", c("a1", "a2"))
```

    #> # jsonc (19 lines, 2 selected elements)
    #>    2  | // this is a comment
    #>    3  | {
    #>    4  |   "a": {
    #> >  5  |     "a1": [1, 2, 3],
    #>    6  |     // comment
    #> >  7  |     "a2": "string"
    #>    8  |   },
    #>    9  |   "b": [
    #>   10  |     {
    #>   ...

Select nodes that match a tree-sitter query:

``` r
json |> ts_tree_select(query = "((pair value: (false) @val))")
```

    #> # jsonc (19 lines, 3 selected elements)
    #>   ...
    #>    9  |   "b": [
    #>   10  |     {
    #>   11  |       "b11": true,
    #> > 12  |       "b12": false
    #>   13  |     },
    #>   14  |     {
    #> > 15  |       "b21": false,
    #> > 16  |       "b22": false
    #>   17  |     }
    #>   18  |   ]
    #>   19  | }

### Delete elements

Delete selected elements:

``` r
ts_tree_select(json, "a", "a1") |> ts_tree_delete()
```

    #> # jsonc (18 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     // comment
    #>  6 |     "a2": "string"
    #>  7 |   },
    #>  8 |   "b": [
    #>  9 |     {
    #> 10 |       "b11": true,
    #> ℹ 8 more lines
    #> ℹ Use `print(n = ...)` to see more lines

### Insert elements

Insert element into an array:

``` r
ts_tree_select(json, "a", "a1") |> ts_tree_insert(at = 2, "new")
```

    #> # jsonc (24 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a1": [
    #>  6 |         1,
    #>  7 |         2,
    #>  8 |         "new",
    #>  9 |         3
    #> 10 |     ],
    #> ℹ 14 more lines
    #> ℹ Use `print(n = ...)` to see more lines

Inserting into an array reformats the array.

Insert element into an object, at the specified key:

``` r
ts_tree_select(json, "a") |>
  ts_tree_insert(key = "a0", at = 0, list("new", "element"))
```

    #> # jsonc (27 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |       "a0": [
    #>  6 |           "new",
    #>  7 |           "element"
    #>  8 |       ],
    #>  9 |       "a1": [
    #> 10 |           1,
    #> ℹ 17 more lines
    #> ℹ Use `print(n = ...)` to see more lines

### Update elements

Update existing element:

``` r
ts_tree_select(json, "a", c("a1", "a2")) |> ts_tree_update("new value")
```

    #> # jsonc (19 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a1": "new value",
    #>  6 |     // comment
    #>  7 |     "a2": "new value"
    #>  8 |   },
    #>  9 |   "b": [
    #> 10 |     {
    #> ℹ 9 more lines
    #> ℹ Use `print(n = ...)` to see more lines

Inserts the element if some parents are missing:

``` r
json <- ts_parse_jsonc(text = "{ \"a\": { \"b\": true } }")
json
```

    #> Error in ts_parse_jsonc(text = "{ \"a\": { \"b\": true } }") :
    #>   could not find function "ts_parse_jsonc"
    #> # jsonc (19 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a1": [1, 2, 3],
    #>  6 |     // comment
    #>  7 |     "a2": "string"
    #>  8 |   },
    #>  9 |   "b": [
    #> 10 |     {
    #> ℹ 9 more lines
    #> ℹ Use `print(n = ...)` to see more lines

``` r
ts_tree_select(json, "a", "x", "y") |> ts_tree_update(list(1,2,3))
```

    #> # jsonc (30 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |       "a1": [
    #>  6 |           1,
    #>  7 |           2,
    #>  8 |           3
    #>  9 |       ],
    #> 10 |       // comment
    #> ℹ 20 more lines
    #> ℹ Use `print(n = ...)` to see more lines

### Write out a document

Use [`stdout()`](https://rdrr.io/r/base/showConnections.html) to write
it to the screen instread of a file:

``` r
json |> ts_tree_write(stdout())
```

    #>
    #> // this is a comment
    #> {
    #>   "a": {
    #>     "a1": [1, 2, 3],
    #>     // comment
    #>     "a2": "string"
    #>   },
    #>   "b": [
    #>     {
    #>       "b11": true,
    #>       "b12": false
    #>     },
    #>     {
    #>       "b21": false,
    #>       "b22": false
    #>     }
    #>   ]
    #> }

### Formatting

Format the whole document:

``` r
json |> ts_tree_format()
```

    #> # jsonc (23 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |     "a": {
    #>  5 |         "a1": [
    #>  6 |             1,
    #>  7 |             2,
    #>  8 |             3
    #>  9 |         ],
    #> 10 |         // comment
    #> ℹ 13 more lines
    #> ℹ Use `print(n = ...)` to see more lines

Format part of the document:

``` r
json |> ts_tree_select("a") |>
  ts_tree_format(options = list(format = "compact"))
```

    #> # jsonc (15 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {"a1":[1,2,3],"a2":"string"},
    #>  5 |   "b": [
    #>  6 |     {
    #>  7 |       "b11": true,
    #>  8 |       "b12": false
    #>  9 |     },
    #> 10 |     {
    #> ℹ 5 more lines
    #> ℹ Use `print(n = ...)` to see more lines

### Unserializing

Unserialize a whole document:

``` r
json |> ts_tree_unserialize()
```

    #> [[1]]
    #> [[1]]$a
    #> [[1]]$a$a1
    #> [[1]]$a$a1[[1]]
    #> [1] 1
    #>
    #> [[1]]$a$a1[[2]]
    #> [1] 2
    #>
    #> [[1]]$a$a1[[3]]
    #> [1] 3
    #>
    #>
    #> [[1]]$a$a2
    #> [1] "string"
    #>
    #>
    #> [[1]]$b
    #> [[1]]$b[[1]]
    #> [[1]]$b[[1]]$b11
    #> [1] TRUE
    #>
    #> [[1]]$b[[1]]$b12
    #> [1] FALSE
    #>
    #>
    #> [[1]]$b[[2]]
    #> [[1]]$b[[2]]$b21
    #> [1] FALSE
    #>
    #> [[1]]$b[[2]]$b22
    #> [1] FALSE
    #>
    #>
    #>
    #>

Note that
[`ts_tree_unserialize()`](https://r-lib.github.io/ts/reference/ts_tree_unserialize.md)
always returns a list, the first element of the list is the unserialized
document.

Unserialize part(s) of the document:

``` r
json |> ts_tree_select("b") |> ts_tree_unserialize()
```

    #> [[1]]
    #> [[1]][[1]]
    #> [[1]][[1]]$b11
    #> [1] TRUE
    #>
    #> [[1]][[1]]$b12
    #> [1] FALSE
    #>
    #>
    #> [[1]][[2]]
    #> [[1]][[2]]$b21
    #> [1] FALSE
    #>
    #> [[1]][[2]]$b22
    #> [1] FALSE
    #>
    #>
    #>

Again,
[`ts_tree_unserialize()`](https://r-lib.github.io/ts/reference/ts_tree_unserialize.md)
returns a list, with one element for each selected node.

### Exploring a tree-sitter tree

It is often useful to explore the structure of a (JSONC) tree-sitter
tree, to help writing the right selection or tree-sitter queries.

Print the annotated syntax tree:

``` r
ts_tree_ast(json)
```

    #> document (1)                          2|
    #> ├─comment (2)                          |// this is a comment
    #> └─object (3)                          3|
    #>   ├─{ (4)                              |{
    #>   ├─pair (5)                          4|
    #>   │ ├─string (6)                       |
    #>   │ │ ├─" (7)                          |  "
    #>   │ │ ├─string_content (8)             |   a
    #>   │ │ └─" (9)                          |    "
    #>   │ ├─: (10)                           |     :
    #>   │ └─object (11)                      |
    #>   │   ├─{ (12)                         |       {
    #>   │   ├─pair (13)                     5|
    #>   │   │ ├─string (14)                  |
    #>   │   │ │ ├─" (15)                     |    "
    #>   │   │ │ ├─string_content (16)        |     a1
    #>   │   │ │ └─" (17)                     |       "
    #>   │   │ ├─: (18)                       |        :
    #>   │   │ └─array (19)                   |
    #>   │   │   ├─[ (20)                     |          [
    #>   │   │   ├─number (21)                |           1
    #>   │   │   ├─, (22)                     |            ,
    #>   │   │   ├─number (23)                |              2
    #>   │   │   ├─, (24)                     |               ,
    #>   │   │   ├─number (25)                |                 3
    #>   │   │   └─] (26)                     |                  ]
    #>   │   ├─, (27)                         |                   ,
    #>   │   ├─comment (28)                  6|    // comment
    #>   │   ├─pair (29)                     7|
    #>   │   │ ├─string (30)                  |
    #>   │   │ │ ├─" (31)                     |    "
    #>   │   │ │ ├─string_content (32)        |     a2
    #>   │   │ │ └─" (33)                     |       "
    #>   │   │ ├─: (34)                       |        :
    #>   │   │ └─string (35)                  |
    #>   │   │   ├─" (36)                     |          "
    #>   │   │   ├─string_content (37)        |           string
    #>   │   │   └─" (38)                     |                 "
    #>   │   └─} (39)                        8|  }
    #>   ├─, (40)                             |   ,
    #>   ├─pair (41)                         9|
    #>   │ ├─string (42)                      |
    #>   │ │ ├─" (43)                         |  "
    #>   │ │ ├─string_content (44)            |   b
    #>   │ │ └─" (45)                         |    "
    #>   │ ├─: (46)                           |     :
    #>   │ └─array (47)                       |
    #>   │   ├─[ (48)                         |       [
    #>   │   ├─object (49)                  10|
    #>   │   │ ├─{ (50)                       |    {
    #>   │   │ ├─pair (51)                  11|
    #>   │   │ │ ├─string (52)                |
    #>   │   │ │ │ ├─" (53)                   |      "
    #>   │   │ │ │ ├─string_content (54)      |       b11
    #>   │   │ │ │ └─" (55)                   |          "
    #>   │   │ │ ├─: (56)                     |           :
    #>   │   │ │ └─true (57)                  |             true
    #>   │   │ ├─, (58)                       |                 ,
    #>   │   │ ├─pair (59)                  12|
    #>   │   │ │ ├─string (60)                |
    #>   │   │ │ │ ├─" (61)                   |      "
    #>   │   │ │ │ ├─string_content (62)      |       b12
    #>   │   │ │ │ └─" (63)                   |          "
    #>   │   │ │ ├─: (64)                     |           :
    #>   │   │ │ └─false (65)                 |             false
    #>   │   │ └─} (66)                     13|    }
    #>   │   ├─, (67)                         |     ,
    #>   │   ├─object (68)                  14|
    #>   │   │ ├─{ (69)                       |    {
    #>   │   │ ├─pair (70)                  15|
    #>   │   │ │ ├─string (71)                |
    #>   │   │ │ │ ├─" (72)                   |      "
    #>   │   │ │ │ ├─string_content (73)      |       b21
    #>   │   │ │ │ └─" (74)                   |          "
    #>   │   │ │ ├─: (75)                     |           :
    #>   │   │ │ └─false (76)                 |             false
    #>   │   │ ├─, (77)                       |                  ,
    #>   │   │ ├─pair (78)                  16|
    #>   │   │ │ ├─string (79)                |
    #>   │   │ │ │ ├─" (80)                   |      "
    #>   │   │ │ │ ├─string_content (81)      |       b22
    #>   │   │ │ │ └─" (82)                   |          "
    #>   │   │ │ ├─: (83)                     |           :
    #>   │   │ │ └─false (84)                 |             false
    #>   │   │ └─} (85)                     17|    }
    #>   │   └─] (86)                       18|  ]
    #>   └─} (87)                           19|}

Print the document object model:

``` r
ts_tree_dom(json)
```

    #> document (1)
    #> └─object (3)
    #>   ├─object (11) # a
    #>   │ ├─array (19) # a1
    #>   │ │ ├─number (21)
    #>   │ │ ├─number (23)
    #>   │ │ └─number (25)
    #>   │ └─string (35) # a2
    #>   └─array (47) # b
    #>     ├─object (49)
    #>     │ ├─true (57) # b11
    #>     │ └─false (65) # b12
    #>     └─object (68)
    #>       ├─false (76) # b21
    #>       └─false (84) # b22

Print the structural summary of a tree:

``` r
ts_tree_sexpr(json)
```

    #> [1] "(document (comment) (object (pair key: (string (string_content)) value: (ob
    #> ject (pair key: (string (string_content)) value: (array (number) (number) (numbe
    #> r))) (comment) (pair key: (string (string_content)) value: (string (string_conte
    #> nt))))) (pair key: (string (string_content)) value: (array (object (pair key: (s
    #> tring (string_content)) value: (true)) (pair key: (string (string_content)) valu
    #> e: (false))) (object (pair key: (string (string_content)) value: (false)) (pair
    #> key: (string (string_content)) value: (false)))))))"

# License

MIT © Posit Software, PBC
