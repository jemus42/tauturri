#' Get User Names and IDs
#'
#' @inheritParams api_request
#' @param add_pseudonym Set to `TRUE` if you want to pseudonymize your user's names.
#' @return A `tbl`
#' @export
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_names>
#' @examples
#' \dontrun{
#' get_user_names()
#' }
get_user_names <- function(url = NULL, apikey = NULL, add_pseudonym = FALSE) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_user_names")

  if (result$result != "success") {
    warning("Error in 'get_user_names': ", result$result)
    return(tibble())
  }

  result         <- map_df(result$data, flatten)
  result$user_id <- as.character(result$user_id)

  if (add_pseudonym) {
    words <- sample(tauturri::words, nrow(result))
    result$pseudonym <- words
  }

  result
}

#' Get a Single User's Player Stats
#'
#' @inheritParams api_request
#' @param user_id The numeric `user_id`. Can be retrieved via [get_user_names].
#'
#' @return A `tbl`
#' @export
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_player_stats>
#' @examples
#' \dontrun{
#' get_user_player_stats(user_id = 1352909)
#' }
get_user_player_stats <- function(url = NULL, apikey = NULL, user_id) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_user_player_stats", user_id = user_id)

  if (result$result != "success") {
    warning("Error in 'get_user_player_stats': ", result$result)
    return(tibble())
  }

  result         <- map_df(result$data, as_tibble)
  result$user_id <- as.character(user_id)
  result         <- result[c("user_id", names(result)[names(result) != "user_id"])]

  result
}

#' Get a Single User's Player Stats
#'
#' @inheritParams api_request
#' @inheritParams get_user_player_stats
#'
#' @return A `tbl`
#' @export
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_watch_time_stats>
#' @examples
#' \dontrun{
#' get_user_watch_time_stats(user_id = 1352909)
#' }
get_user_watch_time_stats <- function(url = NULL, apikey = NULL, user_id) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_user_watch_time_stats", user_id = user_id)

  if (result$result != "success") {
    warning("Error in 'get_user_watch_time_stats': ", result$result)
    return(tibble())
  }

  result         <- map_df(result$data, as_tibble)
  result$user_id <- as.character(user_id)
  result         <- result[c("user_id", names(result)[names(result) != "user_id"])]

  result
}
