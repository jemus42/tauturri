context("test-get_user.R")

test_that("get_user_names works", {
  res <- get_user_names()
  expect_is(res, "tbl")
  expect_named(res, c("friendly_name", "user_id"))

  res <- get_user_names(add_pseudonym = TRUE)
  expect_is(res, "tbl")
  expect_named(res, c("friendly_name", "user_id", "pseudonym"))

  expect_error(get_user_names("", ""))
})

test_that("get_user_player_stats works", {
  res <- get_user_player_stats(user_id = 1352909)
  expect_is(res, "tbl")
  expect_named(res, c("user_id", "platform_name", "platform", "player_name", "total_plays",
                      "result_id"))

  expect_error(get_user_player_stats())
  expect_error(get_user_player_stats(url = "", apikey = "", user_id = 1352909))
})

test_that("get_user_watch_time_stats works", {
  res <- get_user_watch_time_stats(user_id = 1352909)
  expect_is(res, "tbl")
  expect_length(res, 4)
  expect_equal(nrow(res), 4)
  expect_named(res, c("user_id", "query_days", "total_time", "total_plays"))

  expect_error(get_user_watch_time_stats(url = "", apikey = "", user_id = 1352909))
  expect_error(get_user_watch_time_stats())
})
