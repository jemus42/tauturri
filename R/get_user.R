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

  result <- map_df(result$data, function(x) {
    tibble(
      username = x$username,
      user_id = x$user_id,
      is_allow_sync = as.numeric(x$is_allow_sync) == 1,
      user_token = pluck(x,"user_token", .default = NA),
      is_admin = as.numeric(x$is_admin) == 1,
      is_restricted = as.numeric(x$is_restricted) == 1,
      is_home_user = as.numeric(x$is_home_user) == 1,
      email = pluck(x, "email", .default = NA),
      server_token = pluck(x, "server_token", .default = NA)
    )
  })

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

  result <- map_df(result$data, flatten)
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

  result <- map_df(result$data, as_tibble)
  result$user_id <- as.character(user_id)
  result <- result[c("user_id", names(result)[names(result) != "user_id"])]

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

  result <- map_df(result$data, as_tibble)
  result$user_id <- as.character(user_id)
  result <- result[c("user_id", names(result)[names(result) != "user_id"])]

  result
}

#' Get a Users Table
#' @inheritParams api_request
#' @param order_column "user_thumb", "friendly_name", "last_seen", "ip_address", "platform",
#' "player", "last_played", "plays", "duration"
#' @param order_dir "desc" (default) or "asc"
#' @param start Row to start from, default is 0
#' @param length Number of items to return, default is 50.
#' @param search A string to search for
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
get_users_table <- function(url = NULL, apikey = NULL, order_column = NULL,
                            order_dir = "desc", start = 0, length = 50, search = NULL) {
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
    cmd = "get_users_table",
    order_dir = order_dir, order_column = order_column,
    start = start, length = length, search = search
  )

  if (result$result != "success") {
    warning("Error in 'get_users_table': ", result$result)
    return(tibble())
  }

  result <- map_df(result$data$data, function(x) {
    x <- map_if(x, is.null, function(y) {
      return("")
    })
    x <- map_if(x, is.numeric, as.character)

    x$duration <- as.numeric(x$duration)
    x$year <- as.numeric(x$year)
    as_tibble(x)
  })

  result
}

#' Get User IPs
#' @inheritParams api_request
#' @inheritParams get_users_table
#' @param user_id The `user_id` of the user.
#'
#' @return A `tbl`
#' @export
#' @importFrom purrr map_df
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_ips>
#' @examples
#' \dontrun{
#' get_user_ips(user_id = 192023)
#' }
get_user_ips <- function(url = NULL, apikey = NULL, user_id, order_column = NULL,
                         order_dir = "desc", start = 0, length = 50, search = NULL) {
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
    cmd = "get_user_ips", user_id = user_id,
    order_dir = order_dir, order_column = order_column,
    start = start, length = length, search = search
  )

  if (result$result != "success") {
    warning("Error in 'get_user_ips': ", result$result)
    return(tibble())
  }

  result <- purrr::map_df(result$data$data, function(x) {
    x$media_index <- as.character(x$media_index)
    x$parent_media_index <- as.character(x$parent_media_index)
    as_tibble(x)
  })

  result
}

#' Get User Logins
#' @inheritParams api_request
#' @inheritParams get_users_table
#' @param user_id The `user_id` of the user.
#'
#' @return A `tbl`
#' @export
#' @importFrom purrr map_if
#' @importFrom purrr map_df
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_logins>
#' @examples
#' \dontrun{
#' get_user_logins(user_id = 192023)
#' }
get_user_logins <- function(url = NULL, apikey = NULL, user_id, order_column = NULL,
                            order_dir = "desc", start = 0, length = 50, search = NULL) {
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
    cmd = "get_user_logins", user_id = user_id,
    order_dir = order_dir, order_column = order_column,
    start = start, length = length, search = search
  )

  if (result$result != "success") {
    warning("Error in 'get_user_logins': ", result$result)
    return(tibble())
  }

  result <- purrr::map_df(result$data$data, function(x) {
    x <- map_if(x, is.null, ~return(""))
    x$timestamp <- as.POSIXct(x$timestamp, origin = "1970-01-01")
    as_tibble(x)
  })

  result
}
