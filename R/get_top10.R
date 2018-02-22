#' Get Plays by Top 10 Users
#'
#' @inheritParams api_request
#' @inheritParams get_plays_by_date
#' @return A `tbl` with columns `user`, `Movies`, `TV`, `Music`
#' @export
#' @importFrom purrr map_chr
#' @importFrom purrr pluck
#' @importFrom purrr map
#' @importFrom purrr set_names
#' @importFrom purrr flatten_chr
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_top_10_users>
#'
#' @examples
#' \dontrun{
#' get_plays_by_top_10_users()
#' }
get_plays_by_top_10_users <- function(url = NULL, apikey = NULL,
                                      time_range = 30, y_axis = "plays", user_id = NULL) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_plays_by_top_10_users",
                        time_range = time_range, y_axis = y_axis, user_id = user_id)

  if (result$result != "success") {
    warning("Error in 'get_plays_by_top_10_users': ", result$result)
    return(tibble())
  }

  res     <- pluck(result, "data", "series") %>%
    map(~as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, "name")) %>%
    as_tibble()
  res$user <- pluck(result, "data", "categories") %>%
    flatten_chr()

  res      <- res[c("user", names(res)[names(res) != "user"])]

  return(res)
}

#' Get Plays by Top 10 Platforms
#'
#' @inheritParams api_request
#' @inheritParams get_plays_by_date
#' @return A `tbl` with columns `hour`, `Movies`, `TV`, `Music`
#' @export
#' @importFrom purrr map_chr
#' @importFrom purrr pluck
#' @importFrom purrr map
#' @importFrom purrr set_names
#' @importFrom purrr flatten_chr
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_top_10_platforms>
#'
#' @examples
#' \dontrun{
#' get_plays_by_top_10_platforms()
#' }
get_plays_by_top_10_platforms <- function(url = NULL, apikey = NULL,
                                          time_range = 30, y_axis = "plays", user_id = NULL) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_plays_by_top_10_platforms",
                        time_range = time_range, y_axis = y_axis, user_id = user_id)

  if (result$result != "success") {
    warning("Error in 'get_plays_by_top_10_platforms': ", result$result)
    return(tibble())
  }

  res     <- pluck(result, "data", "series") %>%
    map(~as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, "name")) %>%
    as_tibble()
  res$platform <- pluck(result, "data", "categories") %>%
    flatten_chr()

  res      <- res[c("platform", names(res)[names(res) != "platform"])]

  return(res)
}

#' Get Stream Type by Top 10 Users
#'
#' @inheritParams api_request
#' @inheritParams get_plays_by_date
#' @return A `tbl` with columns `user`, `Direct_Play`, `Direct_Stream`, `Transcode`.
#' @export
#' @importFrom purrr map_chr
#' @importFrom purrr pluck
#' @importFrom purrr map
#' @importFrom purrr set_names
#' @importFrom purrr flatten_chr
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_stream_type_by_top_10_users>
#'
#' @examples
#' \dontrun{
#' get_stream_type_by_top_10_users()
#' }
get_stream_type_by_top_10_users <- function(url = NULL, apikey = NULL,
                                      time_range = 30, y_axis = "plays", user_id = NULL) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_stream_type_by_top_10_users",
                        time_range = time_range, y_axis = y_axis, user_id = user_id)

  if (result$result != "success") {
    warning("Error in 'get_stream_type_by_top_10_users': ", result$result)
    return(tibble())
  }

  res     <- pluck(result, "data", "series") %>%
                map(~as.numeric(.x$data)) %>%
                set_names(map_chr(result$data$series, function(x) {
                  sub(" ", "_", x$name)
                })) %>%
                as_tibble()
  res$user <- pluck(result, "data", "categories") %>%
                    flatten_chr()

  res      <- res[c("user", names(res)[names(res) != "user"])]

  return(res)
}

#' Get Stream Type by Top 10 Platforms
#'
#' @inheritParams api_request
#' @inheritParams get_plays_by_date
#' @return A `tbl` with columns `platform`, `Direct_Play`, `Direct_Stream`, `Transcode`.
#' @export
#' @importFrom purrr map_chr
#' @importFrom purrr pluck
#' @importFrom purrr map
#' @importFrom purrr set_names
#' @importFrom purrr flatten_chr
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_stream_type_by_top_10_platforms>
#'
#' @examples
#' \dontrun{
#' get_stream_type_by_top_10_platforms()
#' }
get_stream_type_by_top_10_platforms <- function(url = NULL, apikey = NULL,
                                                time_range = 30, y_axis = "plays", user_id = NULL) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url, apikey, cmd = "get_stream_type_by_top_10_platforms",
                        time_range = time_range, y_axis = y_axis, user_id = user_id)

  if (result$result != "success") {
    warning("Error in 'get_stream_type_by_top_10_platforms': ", result$result)
    return(tibble())
  }

  res     <- pluck(result, "data", "series") %>%
    map(~as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, function(x) {
      sub(" ", "_", x$name)
    })) %>%
    as_tibble()
  res$platform <- pluck(result, "data", "categories") %>%
    flatten_chr()

  res      <- res[c("platform", names(res)[names(res) != "platform"])]

  return(res)
}
