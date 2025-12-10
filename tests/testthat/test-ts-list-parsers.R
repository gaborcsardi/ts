test_that("ts_list_parsers", {
  withr::local_options(width = 500)
  loadNamespace("tsjsonc")
  loadNamespace("tstoml")
  expect_snapshot(
    {
      unique(ts_list_parsers()[, 1:3])
    },
  )

  expect_snapshot(
    {
      writeLines(format_rd_parser_list(ts_list_parsers()))
    },
    transform = function(x) {
      gsub("[(][.0-9]+[)]", "(x.y.z)", x)
    }
  )

  expect_snapshot({
    format_rd_parser_list(ts_list_parsers()[integer(), ])
  })
})
