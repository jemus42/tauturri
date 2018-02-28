#' Make an API GET-request
#'
#' @param url Server URL.
#' @param apikey API key.
#' @param cmd API command,
#' see [the API docs](https://github.com/JonnyWong16/plexpy/blob/master/API.md). Defaults to
#' printing server information via the `get_servers_info` method.
#' @param ... Optional (named) parameters.
#' @return The API result, usually a `list`.
#' @export
#' @importFrom httr parse_url
#' @importFrom httr GET
#' @importFrom httr stop_for_status
#' @importFrom httr content
#'
#' @examples
#' \dontrun{
#' api_request("http://example.com/plexpy", "asdf", "get_servers_info")
#' }
api_request <- function(url = NULL, apikey = NULL, cmd = "get_servers_info", ...) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }

  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  request_url <- httr::parse_url(paste0(url, "/api/v2"))
  request_url$query <- list(apikey = apikey, cmd = cmd, ...)
  result <- httr::GET(request_url)

  httr::stop_for_status(result)
  httr::content(result)$response
}

#' Arnold
#'
#' @inheritParams api_request
#'
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#arnold>
#' @return A `character` of length `1`.
#' @export
#' @examples
#' \dontrun{
#' arnold()
#' }
arnold <- function(url = NULL, apikey = NULL) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(
    url, apikey, cmd = "arnold"
  )
  if (result$result == "error") {
    stop("Error in 'arnold': ", result$message)
  }

  result$data
}
