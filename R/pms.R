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

  result <- api_request(
    url = url, apikey = apikey,
    cmd = "get_pms_update"
  )
  if (result$result != "success") {
    stop("Error in 'get_pms_update': ", result$message)
  }

  result$data$release_date <- as.POSIXct(result$data$release_date, origin = "1970-01-01")
  result$data
}
