# ts_list_parsers

    Code
      unique(ts_list_parsers()[, 1:3])
    Output
      # A data frame: 2 x 3
        package version    title          
      * <chr>   <chr>      <chr>          
      1 tsjsonc 0.0.0.9000 Edit JSON Files
      2 tstoml  0.0.0.9000 Edit TOML files

---

    Code
      writeLines(format_rd_parser_list(ts_list_parsers()))
    Output
      \itemize{
      \item \strong{\link[tsjsonc:tsjsonc-package]{tsjsonc}} 0.0.0.9000 (loaded): Edit JSON Files.
      \item \strong{\link[tstoml:tstoml-package]{tstoml}} 0.0.0.9000 (loaded): Edit TOML files.
      }
      

---

    Code
      format_rd_parser_list(ts_list_parsers()[integer(), ])
    Output
      [1] "No tree-sitter parsers are installed."

