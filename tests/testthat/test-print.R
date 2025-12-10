test_that("format.ts_tree", {
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}') |>
      ts_tree_format()
    print(tree)
    print(tree, n = 1)
    print(tree, n = 2)
  })

  # selections
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}') |>
      ts_tree_format()
    tree |> ts_tree_select("a") |> print()
    tree |> ts_tree_select("b", TRUE) |> print()
  })

  # empty selection
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}') |>
      ts_tree_format()
    tree |> ts_tree_select("c") |> print()
  })

  # multiple selected rows
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3], "c": {"d":4}}') |>
      ts_tree_format()
    tree |> ts_tree_select(c("b", "c")) |> print()
  })

  # print limited number of selected elements
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('[1,2,3,4,5,6,7]') |>
      ts_tree_format()
    tree |> ts_tree_select(1:5) |> print(n = 3)
  })
})

test_that("end_column == 0", {
  expect_snapshot({
    tree <- tstoml::ts_parse_toml(tstoml::toml_example_text())
    tree |> ts_tree_select("owner")
  })
})
