#' Check for Tautulli Updates
#'
#' @inheritParams api_request
#'
#' @return Invisibly `TRUE` when an update is available, `FALSE` when no update is available.
#' @export
#' @source <https://github.com/Tautulli/Tautulli/blob/beta/API.md#update_check>
#' @examples
#' \dontrun{
#' update_check()
#' }
update_check <- function(url = NULL, apikey = NULL) {
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
    cmd = "update_check"
  )
  if (result$result == "error") {
    stop("Error in 'update_check': ", result$message)
  }

  message(result$message)

  if (result$message == "Tautulli is up to date") {
    invisible(FALSE)
  } else {
    invisible(TRUE)
  }
}

#' Apply Tautulli Updates
#'
#' @inheritParams api_request
#'
#' @return Invisibly `TRUE` when the update is applied, `FALSE` when there is an issue.
#' @export
#' @source <https://github.com/Tautulli/Tautulli/blob/beta/API.md#update>
#' @examples
#' \dontrun{
#' update_tautulli()
#' }
update_tautulli <- function(url = NULL, apikey = NULL) {
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
    cmd = "update"
  )
  if (result$result == "error") {
    stop("Error in 'update_tautulli': ", result$message)
  }

  message(result$message)

  if (result$message == "Updating Tautulli") {
    invisible(TRUE)
  } else {
    invisible(FALSE)
  }
}
