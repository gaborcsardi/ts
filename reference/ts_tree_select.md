# Select parts of a tree-sitter tree

`ts:::doc_insert("ts::ts_tree_select_description")`

### Installed ts parsers

This is the manual path of the `ts_tree_select()` S3 generic function.
See the S3 methods in the installed ts parser packages (if any):

`ts:::format_rd_parser_list(ts:::ts_list_parsers(), "ts_tree_select")`

## Usage

``` r
ts_tree_select(tree, ..., refine = FALSE)
```

## Arguments

- tree:

  `ts:::doc_insert("ts_tree_select_param_tree")`

- ...:

  `ts:::doc_insert("ts_tree_select_param_dots")`

- refine:

  `ts:::doc_insert("ts_tree_select_param_refine")`

## Value

`ts:::doc_insert("ts::ts_tree_select_return")`

## Details

`ts:::doc_insert("ts::ts_tree_select_details")` `ts:::doc_extra()`

## Examples

``` r
json <- ts_tree_new(
  tsjsonc::ts_language_jsonc(),
  text = '{ "a": 1, "b": 2, "c": { "d": 3, "e": 4 } }'
)

json |> ts_tree_select("c", "d")
#> # jsonc (1 line, 1 selected element)
#> > 1 | { "a": 1, "b": 2, "c": { "d": 3, "e": 4 } }
```
