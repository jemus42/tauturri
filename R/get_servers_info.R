#' Get Server Information
#'
#' @inheritParams api_request
#'
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_servers_info>
#' @return A `tbl` with 5 columns minimum.
#' @export
#' @importFrom tibble as_tibble
#' @importFrom purrr map_df
#' @family Server Information
#' @examples
#' \dontrun{
#' get_servers_info()
#' }
get_servers_info <- function(url = NULL, apikey = NULL) {

  result <- api_request(url, apikey, cmd = "get_servers_info")
  map_df(result$data, as_tibble)
}

#' Get Server Identity
#'
#' @inheritParams api_request
#'
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_servers_identity>
#' @return A `tbl` with 2 columns.
#' @export
#' @importFrom tibble as_tibble
#' @family Server Information
#' @examples
#' \dontrun{
#' get_server_identity()
#' }
get_server_identity <- function(url = NULL, apikey = NULL) {

  result <- api_request(url, apikey, cmd = "get_server_identity")
  as_tibble(result$data)
}


#' Get Server List
#'
#' @inheritParams api_request
#'
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_list>
#' @return A `tbl` with 8 columns minimum with one row per server.
#' @export
#' @importFrom tibble as_tibble
#' @importFrom purrr map_df
#' @family Server Information
#' @examples
#' \dontrun{
#' get_server_list()
#' }
get_server_list <- function(url = NULL, apikey = NULL) {

  result <- api_request(url, apikey, cmd = "get_server_list")
  map_df(result$data, as_tibble)
}

#' Get Server Friendly Name
#'
#' @inheritParams api_request
#'
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_friendly_name>
#' @return A `tbl` with 8 columns minimum with one row per server.
#' @export
#' @family Server Information
#' @examples
#' \dontrun{
#' get_server_friendly_name()
#' }
get_server_friendly_name <- function(url = NULL, apikey = NULL) {

  result <- api_request(url, apikey, cmd = "get_server_friendly_name")
  result$data
}

#' Get Server ID
#'
#' @inheritParams api_request
#' @param hostname THe hostname
#' @param port The server port, default is `32400`
#' @param ssl,remote Optional, 0 for no, 1 for yes
#'
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_id>
#' @return A `tbl` with 8 columns minimum with one row per server.
#' @export
#' @family Server Information
#' @examples
#' \dontrun{
#' get_server_id()
#' }
get_server_id <- function(url = NULL, apikey = NULL, hostname, port = 32400,
                          remote = 0, ssl = 0) {

  result <- api_request(
    url, apikey,
    cmd = "get_server_id",
    hostname = hostname, port = port,
    remote = remote, ssl = ssl
  )
  if (result$result == "error") {
    stop("Error in 'get_server_id': ", result$message)
  }

  result$data
}
