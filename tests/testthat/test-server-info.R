context("test-server-info.R")

test_that("get_servers_info works", {
  res <- get_servers_info()
  expect_is(res, "tbl")
  expect_equal(nrow(res), 1)
  expect_named(res, c("port", "host", "version", "name", "machine_identifier"))
  expect_error(get_servers_info("", ""))
})

test_that("get_server_identity works", {
  res <- get_server_identity()
  expect_is(res, "tbl")
  expect_equal(nrow(res), 1)
  expect_named(res, c("version", "machine_identifier"))
  expect_error(get_server_identity("", ""))
})

test_that("get_server_list works", {
  res <- get_server_list()
  expect_is(res, "tbl")
  expect_named(res, c(
    "httpsRequired", "is_cloud", "ip", "local", "clientIdentifier",
    "port", "value", "label"
  ))
  expect_error(get_server_list("", ""))
})
