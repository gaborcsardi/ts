# [

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [true, false]}")
      tree
    Output
      # jsonc (1 line)
      1 | {"a": 1, "b": [true, false]}
    Code
      tree[]
    Output
      # A data frame: 24 x 20
            id parent field_name type             code  start_byte end_byte start_row
         <int>  <int> <chr>      <chr>            <chr>      <int>    <int>     <int>
       1     1     NA <NA>       "document"       <NA>           0       28         0
       2     2      1 <NA>       "object"         <NA>           0       28         0
       3     3      2 <NA>       "{"              "{"            0        1         0
       4     4      2 <NA>       "pair"           <NA>           1        7         0
       5     5      4 key        "string"         <NA>           1        4         0
       6     6      5 <NA>       "\""             "\""           1        2         0
       7     7      5 <NA>       "string_content" "a"            2        3         0
       8     8      5 <NA>       "\""             "\""           3        4         0
       9     9      4 <NA>       ":"              ":"            4        5         0
      10    10      4 value      "number"         "1"            6        7         0
      # i 14 more rows
      # i 12 more variables: start_column <int>, end_row <int>, end_column <int>,
      #   is_missing <lgl>, has_error <lgl>, expected <list>, children <I<list>>,
      #   tws <chr>, dom_children <list>, dom_parent <int>, dom_name <chr>,
      #   dom_type <chr>

