context("test-get_activity.R")

test_that("get_activity works", {
  res <- get_activity()

  expect_is(res, "list")
})
