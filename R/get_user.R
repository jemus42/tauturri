#' Get Users
#'
#' @inheritParams api_request
#' @return A `tbl`
#' @export
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_users>
#' @examples
#' \dontrun{
#' get_users()
#' }
get_users <- function(url = NULL, apikey = NULL) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_users")

  if (result$result != "success") {
    warning("Error in 'get_users': ", result$result)
    return(tibble())
  }

  result               <- map_df(result$data, flatten)
  result$user_id       <- as.character(result$user_id)
  result$is_admin      <- ifelse(result$is_admin == 1, TRUE, FALSE)
  result$is_restricted <- ifelse(result$is_restricted == 1, TRUE, FALSE)
  result$is_home_user  <- ifelse(result$is_home_user == 1, TRUE, FALSE)
  result$is_allow_sync <- ifelse(result$is_allow_sync == 1, TRUE, FALSE)

  result
}

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

#' Get a Users Table
#' @inheritParams api_request
#' @param length Number of items to return, default is 50.
#'
#' @return A `tbl`
#' @export
#' @importFrom purrr map_if
#' @importFrom purrr map_df
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_users_table>
#' @examples
#' \dontrun{
#' get_users_table()
#' }
get_users_table <- function(url = NULL, apikey = NULL, length = 50) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_users_table", length = length)

  if (result$result != "success") {
    warning("Error in 'get_users_table': ", result$result)
    return(tibble())
  }

  result <- map_df(result$data$data, function(x) {
    x <- map_if(x, is.null, function(y) {return("")})
    x <- map_if(x, is.numeric, as.character)

    x$duration <- as.numeric(x$duration)
    x$year <- as.numeric(x$year)
    as_tibble(x)
  })

  result
}
