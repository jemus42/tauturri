context("test-get_library.R")

test_that("get_library_names returns results", {
  res <- get_library_names()
  expect_is(res, "data.frame")
  expect_length(res, 2)
  expect_error(get_library_names(url = "323hhg"))
})
