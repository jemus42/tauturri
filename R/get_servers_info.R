#' Get Server Information
#'
#' @inheritParams api_request
#'
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_servers_info>
#' @return A `data.frame` with 5 columns minimum.
#' @export
#'
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
  data.frame(result$data, stringsAsFactors = FALSE)
}
