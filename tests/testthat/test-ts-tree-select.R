test_that("ts_tree_select", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 0, "b": [1,2,3]}')
  expect_snapshot({
    tree |> ts_tree_select("a") |> ts_tree_unserialize()
    tree |> ts_tree_select("b", 2) |> ts_tree_unserialize()
    tree |> ts_tree_select("b", -1L) |> ts_tree_unserialize()
    tree |> ts_tree_select("b", c(1L, 3L)) |> ts_tree_unserialize()
    tree |> ts_tree_select("b", TRUE) |> ts_tree_unserialize()
  })
})

test_that("ts_tree_select NULL", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 0, "b": [1,2,3]}')
  expect_snapshot({
    tree |> ts_tree_select(NULL)
    tree |> ts_tree_select("a") |> ts_tree_select(NULL, refine = TRUE)
  })
})

test_that("ts_tree_select refine", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 0, "b": [1,2,3]}')
  expect_snapshot({
    tree |>
      ts_tree_select("b") |>
      ts_tree_select(1, refine = TRUE) |>
      ts_tree_unserialize()
  })
})

test_that("ts_tree_select regex", {
  tree <- tsjsonc::ts_parse_jsonc('{"apple": 1, "banana": 2, "apricot": 3}')
  expect_snapshot({
    tree |> ts_tree_select(regex = "^a.*") |> ts_tree_unserialize()
  })
})

test_that("normalize_selectors", {
  expect_snapshot({
    normalize_selectors(NULL, list("a", 1L, TRUE, NULL, I(1), regex = "b"))
  })
})

test_that("ts_tree_select ids", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}') |> ts_tree_format()
  numbers <- which(tree$type == "number")
  expect_snapshot({
    tree |> ts_tree_select(I(numbers)) |> ts_tree_unserialize()
  })
})

test_that("ts_tree_select unknown selector", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
  expect_snapshot(error = TRUE, {
    tree |> ts_tree_select(raw(2))
  })
})

test_that("ts_tree_select NULL", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
  expect_snapshot({
    tree |> ts_tree_select("a", NULL)
  })
})

test_that("ts_tree_select keys from non-object", {
  tree <- tsjsonc::ts_parse_jsonc('{ "a": [1,2,3] }')
  expect_snapshot({
    tree |> ts_tree_select("a", "b")
  })
  expect_snapshot({
    tree |> ts_tree_select("a", regex = "^b")
  })
})

test_that("ts_tree_select zero index", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
  expect_snapshot(error = TRUE, {
    tree |> ts_tree_select("b", 0)
  })
})

test_that("ts_tree_select invalid logical selector", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
  expect_snapshot(error = TRUE, {
    tree |> ts_tree_select("b", c(TRUE, FALSE))
  })
})

test_that("[[", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [true, false]}')
  expect_snapshot({
    tree[["a"]]
    tree[[list("b", 2)]]
  })
  expect_snapshot({
    tree[[]]
  })
})


test_that("TS query", {
  tree <- tsjsonc::ts_parse_jsonc(
    '{"a": {"b": [1,2,3]}, "c": {"b": [4,5,6]}}'
  ) |>
    ts_tree_format()
  expect_snapshot({
    tree |> ts_tree_select(query = "(number) @num")
    tree |> ts_tree_select(query = "(number) @num") |> ts_tree_unserialize()
  })

  expect_snapshot({
    tree |> ts_tree_select(query = "(null) @foo")
  })

  # invalid capture name
  expect_snapshot(error = TRUE, {
    tree |> ts_tree_select(query = list("(null) @foo", "bar"))
  })

  # query with a captures parameter
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": 2, "c": 3, "d": 4 }') |>
      ts_tree_format()
    ts_tree_sexpr(tree)
    tree |>
      ts_tree_select(
        query = list(
          "((pair (string (string_content) @key) (number) @num)
           (#not-eq? @key \"c\") )",
          "num"
        )
      )
  })
})

test_that("ts_tree_select<-", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
  expect_snapshot({
    ts_tree_select(tree, "a") <- 2
    tree
    ts_tree_select(tree, "b", 2) <- 99
    tree
  })
})

test_that("ts_tree_delete", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
  expect_snapshot({
    ts_tree_select(tree, "a") <- ts_tree_deleted()
    tree
    tree[[list("b", -1L)]] <- ts_tree_deleted()
    tree
  })
})

test_that("ts_tree_select<- can insert", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [1,2,3]}')
  expect_snapshot({
    ts_tree_select(tree, "x") <- 42
    tree
    tree[[list("y", "z")]] <- TRUE
    tree |> print(n = 100)
  })
})

test_that("minimize_selection", {
  tree <- tsjsonc::ts_parse_jsonc('{"a": null, "b": [1,2,3]}')
  arr <- which(tree$type == "array")
  num <- which(tree$type == "number")
  expect_equal(
    minimize_selection(tree, c(arr, num)),
    arr
  )
})
