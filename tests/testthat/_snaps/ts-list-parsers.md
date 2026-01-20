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
      \subsection{Installed tree-sitter parsers}{
      \tabular{llcl}{
      \strong{Package} \tab \strong{Version} \tab \strong{Loaded} \tab \strong{Title} \cr
      \link[tsjsonc:tsjsonc-package]{ tsjsonc} \tab 0.0.0.9000 \tab yes \tab  Edit JSON Files.\cr
      \link[tstoml:tstoml-package]{ tstoml} \tab 0.0.0.9000 \tab yes \tab  Edit TOML files.
      }
      }
      

---

    Code
      format_rd_parser_list(ts_list_parsers()[integer(), ])
    Output
      [1] "No tree-sitter parser packages are installed.\nAvailable tree-sitter parser packages:\n\\itemize{\n\\item \\strong{\\href{https://github.com/gaborcsardi/tsjsonc}{tsjsonc}}: Edit JSON Files\\if{text}{ (https://github.com/gaborcsardi/tsjsonc)}.\n\\item \\strong{\\href{https://github.com/gaborcsardi/tstoml}{tstoml}}: Edit TOML Files\\if{text}{ (https://github.com/gaborcsardi/tstoml)}.\n}\n"

