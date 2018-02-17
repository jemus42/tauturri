context("test-get_library.R")

test_that("get_library_names returns results", {
  res <- get_library_names()
  expect_is(res, "data.frame")
  expect_length(res, 2)
  expect_error(get_library_names(url = "323hhg"))
  expect_error(get_library_names(url = "", apikey = ""))
})

test_that("get_library_media_info works", {
  data <- get_library_media_info(section_id = 2, length = 10)

  expect_is(data, "list")
  expect_is(data$totals, "list")
  expect_is(data$items, "tbl")
  expect_equal(nrow(data$items), 10)

  expect_error(get_library_media_info())
  expect_error(get_library_media_info("", ""))
})

test_that("get_library_watch_time_stats works", {
  res <- get_library_watch_time_stats(section_id = 2)
  expect_is(res, "tbl")
  expect_length(res, 3)
  expect_named(res, c("query_days", "total_time", "total_plays"))
  expect_error(get_library_watch_time_stats("", ""))
})
