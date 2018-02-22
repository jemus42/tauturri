#' Make an API GET-request
#'
#' @param url Server URL.
#' @param apikey API key.
#' @param cmd API command,
#' see [the API docs](https://github.com/JonnyWong16/plexpy/blob/master/API.md). Defaults to
#' printing server information via the `get_servers_info` method.
#' @param ... Optional (named) parameters.
#' @import httr
#' @return The API result, usually a `list`.
#' @export
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

  request_url <- parse_url(paste0(url, "/api/v2"))
  request_url$query <- list(apikey = apikey, cmd = cmd, ...)
  result <- httr::GET(request_url)

  httr::stop_for_status(result)

  if (status_code(result) != 200) {
    list(
      result = "error",
      message = "Can't reach PlexPy"
    )
  } else {
    httr::content(result)$response
  }
}
