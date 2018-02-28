#' Check for PMS Updates
#'
#' @inheritParams api_request
#'
#' @return A `list` containing update information
#' @export
#'
#' @examples
#' \dontrun{
#' get_pms_update()
#' }
get_pms_update <- function(url = NULL, apikey = NULL) {
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
    url, apikey, cmd = "get_pms_update"
  )
  if (result$result != "success") {
    stop("Error in 'get_pms_update': ", result$message)
  }

  result$data$release_date <- as.POSIXct(result$data$release_date, origin = "1970-01-01")
  result$data
}
