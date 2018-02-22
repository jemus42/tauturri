context("test-recently-added.R")

test_that("get_recently_added works", {
  count <- 5
  res <- get_recently_added(count = count)
  expect_is(res, "tbl")
  expect_length(res, 18)
  expect_equal(nrow(res), count)
  expect_named(res, c(
    "library_name", "thumb", "media_index", "title", "grandparent_thumb",
    "year", "sort_title", "added_at", "section_id", "child_count",
    "parent_rating_key", "parent_title", "grandparent_title", "media_type",
    "parent_media_index", "grandparent_rating_key", "rating_key", "parent_thumb"
  ))

  expect_error(get_recently_added("", ""))
})
