test_that("ts_tree_write", {
  tmp <- file.path(tempfile(), "test.jsonc")
  on.exit(unlink(dirname(tmp), recursive = TRUE), add = TRUE)
  dir.create(dirname(tmp), showWarnings = FALSE, recursive = TRUE)
  writeLines('{"a": 1, "b": [true, false]}', con = tmp)

  expect_snapshot({
    tree <- tsjsonc::ts_read_jsonc(tmp)
    tree |> ts_tree_select("b", 2) |> ts_tree_delete() |> ts_tree_write()
    tsjsonc::ts_read_jsonc(tmp)
  })

  # error if no file
  expect_snapshot(error = TRUE, {
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [true, false]}')
    tree |> ts_tree_write()
  })

  # append \n if needed
  expect_snapshot({
    tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [true, false]}')
    tree |> ts_tree_write(file = tmp)
    readChar(tmp, nchars = 1000)
  })

  # write to connection
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [true, false]}')
  con <- textConnection(NULL, "w")
  on.exit(close(con), add = TRUE)
  tree |> ts_tree_write(con)
  expect_snapshot({
    textConnectionValue(con)
  })

  # write to binary connection
  tree <- tsjsonc::ts_parse_jsonc('{"a": 1, "b": [true, false]}')
  con2 <- rawConnection(raw(0), "wb")
  on.exit(close(con2), add = TRUE)
  tree |> ts_tree_write(con2)
  expect_snapshot({
    rawToChar(rawConnectionValue(con2))
  })
})
