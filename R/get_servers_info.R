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
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

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
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

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
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_server_list")
  map_df(result$data, as_tibble)
}
