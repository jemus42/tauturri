context("test-api-interaction.R")

test_that("API-requests work", {
 res <- api_request()
 expect_is(res$result, "character")
 expect_equal(res$result, "success")
 expect_is(res$data, "list")

 expect_error(api_request(url = "google.com"))
 expect_error(api_request(url = "", apikey = ""))
 expect_error(api_request(url = "http://example.com/hello"))

 res <- api_request(cmd = "poopybutthole")
 expect_equal(res$result, "error")
})

test_that("get_servers_info works", {
  res <- get_servers_info()
  expect_is(res, "data.frame")
  expect_named(res, c("port", "host", "version", "name", "machine_identifier"))
  expect_error(get_servers_info("", ""))
})
