#' Search for Media Items
#'
#' @inheritParams api_request
#' @param query The query string to search for
#' @param limit The maximum number of items to return per media type, default is `10`
#'
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#search>
#' @return A `list` with each type of media
#' @export
#' @note I would have named the function `search`, but you know, `base::search`.
#'
#' @examples
#' \dontrun{
#' search_server(query = "game of Thrones", limit = 1)
#' }
search_server <- function(url = NULL, apikey = NULL, query, limit = 10) {
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
    url, apikey,
    cmd = "search", query = query, limit = limit
  )
  if (result$result != "success") {
    stop("Error in 'search': ", result$message)
  }

  result$data$results_list
}
