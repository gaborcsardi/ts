# get_ranges

    Code
      txt
    Output
      [1] "[xx1,x2,xx3]x"
    Code
      tree <- ts_tree_new(tsjsonc::ts_language_jsonc(), text = txt, ranges = ranges)
      tree
    Output
      # jsonc (1 line)
      1 | [xx1,x2,xx3]x
    Code
      ts_tree_ast(tree)
    Output
      document (1)      1|
      \-array (2)        |
        +-[ (3)          |[
        +-number (4)     |   1
        +-, (5)          |    ,
        +-number (6)     |      2
        +-, (7)          |       ,
        +-number (8)     |          3
        \-] (9)          |           ]

# new_lookahead_sym

    Code
      tree <- ts_tree_new(tsjsonc::ts_language_jsonc(), text = "[{\"a\": }]",
      fail_on_parse_error = FALSE)
      tree[]
    Output
      # A data frame: 14 x 20
            id parent field_name type             code  start_byte end_byte start_row
         <int>  <int> <chr>      <chr>            <chr>      <int>    <int>     <int>
       1     1     NA <NA>       "document"       <NA>           0        9         0
       2     2      1 <NA>       "array"          <NA>           0        9         0
       3     3      2 <NA>       "["              "["            0        1         0
       4     4      2 <NA>       "object"         <NA>           1        8         0
       5     5      4 <NA>       "{"              "{"            1        2         0
       6     6      4 <NA>       "pair"           <NA>           2        6         0
       7     7      6 key        "string"         <NA>           2        5         0
       8     8      7 <NA>       "\""             "\""           2        3         0
       9     9      7 <NA>       "string_content" "a"            3        4         0
      10    10      7 <NA>       "\""             "\""           4        5         0
      11    11      6 <NA>       ":"              ":"            5        6         0
      12    12      6 value      "number"         ""             6        6         0
      13    13      4 <NA>       "}"              "}"            7        8         0
      14    14      2 <NA>       "]"              "]"            8        9         0
      # i 12 more variables: start_column <int>, end_row <int>, end_column <int>,
      #   is_missing <lgl>, has_error <lgl>, expected <list>, children <I<list>>,
      #   tws <chr>, dom_children <list>, dom_parent <int>, dom_name <chr>,
      #   dom_type <chr>
    Code
      tree$is_missing
    Output
       [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
      [13] FALSE FALSE
    Code
      exp <- tree$expected[[which(tree$is_missing)]]
      do.call(rbind, exp)
    Output
            symbol name      type
       [1,] 65535  "ERROR"   0   
       [2,] 14     "comment" 0   
       [3,] 1      "{"       1   
       [4,] 5      "["       1   
       [5,] 7      """       1   
       [6,] 16     "_value"  2   
       [7,] 17     "object"  0   
       [8,] 19     "array"   0   
       [9,] 20     "string"  0   
      [10,] 10     "number"  0   
      [11,] 11     "true"    0   
      [12,] 12     "false"   0   
      [13,] 13     "null"    0   

# check_predicate_eq

    Code
      ts_tree_query(tree, "((pair key: (string (string_content) @key)) (#eq? @key \"a\"))")
    Output
      $patterns
      # A data frame: 1 x 4
           id name  pattern                                                            match_count
        <int> <chr> <chr>                                                                    <int>
      1     1 <NA>  "((pair key: (string (string_content) @key)) (#eq? @key \"a\"))\n"           1
      
      $captures
      # A data frame: 1 x 2
           id name 
        <int> <chr>
      1     1 key  
      
      $matched_captures
      # A data frame: 1 x 12
           id pattern match type           start_byte end_byte start_row start_column end_row end_column name  code 
        <int>   <int> <int> <chr>               <int>    <int>     <int>        <int>   <int>      <int> <chr> <chr>
      1     1       1     1 string_content          2        3         0            2       0          3 key   a    
      

---

    Code
      ts_tree_query(tree, "((pair key: (string (string_content) @key)) (#not-eq? @key \"a\"))")
    Output
      $patterns
      # A data frame: 1 x 4
           id name  pattern                                                                match_count
        <int> <chr> <chr>                                                                        <int>
      1     1 <NA>  "((pair key: (string (string_content) @key)) (#not-eq? @key \"a\"))\n"           1
      
      $captures
      # A data frame: 1 x 2
           id name 
        <int> <chr>
      1     1 key  
      
      $matched_captures
      # A data frame: 1 x 12
           id pattern match type           start_byte end_byte start_row start_column end_row end_column name  code 
        <int>   <int> <int> <chr>               <int>    <int>     <int>        <int>   <int>      <int> <chr> <chr>
      1     1       1     1 string_content         10       11         0           10       0         11 key   b    
      

---

    Code
      ts_tree_query(tree, "((pair key: (string (string_content) @key)\n        value: (string (string_content) @value)) @pair\n        (#eq? @key @value))")
    Output
      $patterns
      # A data frame: 1 x 4
           id name  pattern                                                                                                                             match_count
        <int> <chr> <chr>                                                                                                                                     <int>
      1     1 <NA>  "((pair key: (string (string_content) @key)\n        value: (string (string_content) @value)) @pair\n        (#eq? @key @value))\n"           1
      
      $captures
      # A data frame: 3 x 2
           id name 
        <int> <chr>
      1     1 key  
      2     2 value
      3     3 pair 
      
      $matched_captures
      # A data frame: 3 x 12
           id pattern match type           start_byte end_byte start_row start_column end_row end_column name  code          
        <int>   <int> <int> <chr>               <int>    <int>     <int>        <int>   <int>      <int> <chr> <chr>         
      1     3       1     1 pair                    1        9         0            1       0          9 pair  "\"a\": \"a\""
      2     1       1     1 string_content          2        3         0            2       0          3 key   "a"           
      3     2       1     1 string_content          7        8         0            7       0          8 value "a"           
      

---

    Code
      ts_tree_query(tree, "((pair key: (string (string_content) @key)\n        value: (string (string_content) @value))\n        (#not-eq? @key @value))")
    Output
      $patterns
      # A data frame: 1 x 4
           id name  pattern                                                                                                                           match_count
        <int> <chr> <chr>                                                                                                                                   <int>
      1     1 <NA>  "((pair key: (string (string_content) @key)\n        value: (string (string_content) @value))\n        (#not-eq? @key @value))\n"           1
      
      $captures
      # A data frame: 2 x 2
           id name 
        <int> <chr>
      1     1 key  
      2     2 value
      
      $matched_captures
      # A data frame: 2 x 12
           id pattern match type           start_byte end_byte start_row start_column end_row end_column name  code 
        <int>   <int> <int> <chr>               <int>    <int>     <int>        <int>   <int>      <int> <chr> <chr>
      1     1       1     1 string_content         12       13         0           12       0         13 key   b    
      2     2       1     1 string_content         17       18         0           17       0         18 value x    
      

# r_grepl

    Code
      ts_tree_query(tree, "((pair key: (string (string_content) @key))\n        (#match? @key \"^a\"))")
    Output
      $patterns
      # A data frame: 1 x 4
           id name  pattern                                                                         match_count
        <int> <chr> <chr>                                                                                 <int>
      1     1 <NA>  "((pair key: (string (string_content) @key))\n        (#match? @key \"^a\"))\n"           1
      
      $captures
      # A data frame: 1 x 2
           id name 
        <int> <chr>
      1     1 key  
      
      $matched_captures
      # A data frame: 1 x 12
           id pattern match type           start_byte end_byte start_row start_column end_row end_column name  code 
        <int>   <int> <int> <chr>               <int>    <int>     <int>        <int>   <int>      <int> <chr> <chr>
      1     1       1     1 string_content          2        3         0            2       0          3 key   a    
      

