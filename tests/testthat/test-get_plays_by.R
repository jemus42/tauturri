context("test-get_plays_by.R")

test_that("get_plays_by_date", {
  res <- get_plays_by_date()
  expect_is(res, "tbl")
  expect_length(res, 4)
  expect_named(res, c("date", "TV", "Movies", "Music"))
  expect_error(get_plays_by_date(url = "", apikey = ""))

})

test_that("get_plays_by_top_10_users works", {
  res <- get_plays_by_top_10_users()
  expect_is(res, "tbl")
  expect_length(res, 4)
  expect_named(res, c("user", "TV", "Movies", "Music"))
  expect_error(get_plays_by_top_10_users(url = "", apikey = ""))
})
