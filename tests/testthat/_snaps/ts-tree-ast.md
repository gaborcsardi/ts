# ts_tree_ast

    Code
      tree <- tsjsonc::ts_parse_jsonc("{\"a\": 1, \"b\": [1,2,3]}")
      ts_tree_ast(tree)
    Output
      document (1)                   1|
      \-object (2)                    |
        +-{ (3)                       |{
        +-pair (4)                    |
        | +-string (5)                |
        | | +-" (6)                   | "
        | | +-string_content (7)      |  a
        | | \-" (8)                   |   "
        | +-: (9)                     |    :
        | \-number (10)               |      1
        +-, (11)                      |       ,
        +-pair (12)                   |
        | +-string (13)               |
        | | +-" (14)                  |         "
        | | +-string_content (15)     |          b
        | | \-" (16)                  |           "
        | +-: (17)                    |            :
        | \-array (18)                |
        |   +-[ (19)                  |              [
        |   +-number (20)             |               1
        |   +-, (21)                  |                ,
        |   +-number (22)             |                 2
        |   +-, (23)                  |                  ,
        |   +-number (24)             |                   3
        |   \-] (25)                  |                    ]
        \-} (26)                      |                     }

# ts_tree_ast with hyperlinks

    Code
      writeLines("{\"a\": 1, \"b\": [1,2,3]}", con = tmp)
      tree <- tsjsonc::ts_read_jsonc(tmp)
      ts_tree_ast(tree)
    Output
      ]8;;file://<tempdir>/<tempfile>:1:1document]8;; (1)                   1|
      \-]8;;file://<tempdir>/<tempfile>:1:1object]8;; (2)                    |
        +-]8;;file://<tempdir>/<tempfile>:1:1{]8;; (3)                       |{
        +-]8;;file://<tempdir>/<tempfile>:1:2pair]8;; (4)                    |
        | +-]8;;file://<tempdir>/<tempfile>:1:2string]8;; (5)                |
        | | +-]8;;file://<tempdir>/<tempfile>:1:2"]8;; (6)                   | "
        | | +-]8;;file://<tempdir>/<tempfile>:1:3string_content]8;; (7)      |  a
        | | \-]8;;file://<tempdir>/<tempfile>:1:4"]8;; (8)                   |   "
        | +-]8;;file://<tempdir>/<tempfile>:1:5:]8;; (9)                     |    :
        | \-]8;;file://<tempdir>/<tempfile>:1:7number]8;; (10)               |      1
        +-]8;;file://<tempdir>/<tempfile>:1:8,]8;; (11)                      |       ,
        +-]8;;file://<tempdir>/<tempfile>:1:10pair]8;; (12)                   |
        | +-]8;;file://<tempdir>/<tempfile>:1:10string]8;; (13)               |
        | | +-]8;;file://<tempdir>/<tempfile>:1:10"]8;; (14)                  |         "
        | | +-]8;;file://<tempdir>/<tempfile>:1:11string_content]8;; (15)     |          b
        | | \-]8;;file://<tempdir>/<tempfile>:1:12"]8;; (16)                  |           "
        | +-]8;;file://<tempdir>/<tempfile>:1:13:]8;; (17)                    |            :
        | \-]8;;file://<tempdir>/<tempfile>:1:15array]8;; (18)                |
        |   +-]8;;file://<tempdir>/<tempfile>:1:15[]8;; (19)                  |              [
        |   +-]8;;file://<tempdir>/<tempfile>:1:16number]8;; (20)             |               1
        |   +-]8;;file://<tempdir>/<tempfile>:1:17,]8;; (21)                  |                ,
        |   +-]8;;file://<tempdir>/<tempfile>:1:18number]8;; (22)             |                 2
        |   +-]8;;file://<tempdir>/<tempfile>:1:19,]8;; (23)                  |                  ,
        |   +-]8;;file://<tempdir>/<tempfile>:1:20number]8;; (24)             |                   3
        |   \-]8;;file://<tempdir>/<tempfile>:1:21]]8;; (25)                  |                    ]
        \-]8;;file://<tempdir>/<tempfile>:1:22}]8;; (26)                      |                     }

