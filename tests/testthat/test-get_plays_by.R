context("test-get_plays_by.R")

test_that("get_plays_by_date", {
  res <- get_plays_by_date()
  expect_is(res, "data.frame")
  expect_length(res, 4)
  expect_named(res, c("date", "tv", "movies", "music"))
})
