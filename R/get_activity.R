#' Get Current Server Activity
#'
#' @inheritParams api_request
#'
#' @return A `list` with bandwidth + stream info and a session `data.frame`.
#' @export
#' @importFrom purrr map
#' @importFrom purrr discard
#' @examples
#' \dontrun{
#' get_activity()
#' }
get_activity <- function(url = NULL, apikey = NULL) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_activity")

  if (result$result != "success") {
    warning("Error in 'get_activity': ", result$result)
    return(data.frame())
  }

  info      <- result$data[names(result$data) != "sessions"]
  bandwidth <- map(info[grepl(pattern = "bandwidth", names(info))], as.numeric)
  streams   <- map(info[grepl(pattern = "stream", names(info))], as.numeric)

  sessions <- result$data$sessions

  if (!identical(sessions, list())) {

    sessions <- sessions %>%
      map(discard, is.list) %>%
      map(discard, is.null) %>%
      as.data.frame(stringsAsFactors = FALSE)

  }

  # Return things compactly
  list(streams = streams,
       bandwidth = bandwidth,
       sessions = sessions)
}
