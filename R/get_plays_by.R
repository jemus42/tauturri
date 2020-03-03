#' Get Plays by Date
#'
#' @inheritParams api_request
#' @param time_range The number of days of data to return, default is `30`.
#' @param y_axis `"plays"` (default) or `"duration"`
#' @param user_id The user id to filter the data
#' @return A `tbl` with columns `date`, `Movies`, `TV`, `Music`
#' @export
#' @importFrom purrr map_chr
#' @importFrom purrr pluck
#' @importFrom purrr map
#' @importFrom purrr set_names
#' @importFrom purrr flatten_chr
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_date>
#' @family Playback History
#' @examples
#' \dontrun{
#' get_plays_by_date(y_axis = "duration")
#' }
get_plays_by_date <- function(url = NULL, apikey = NULL,
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

  result <- api_request(
    url, apikey,
    cmd = "get_plays_by_date",
    time_range = time_range, y_axis = y_axis, user_id = user_id
  )

  if (result$result != "success") {
    warning("Error in 'get_plays_by_date': ", result$result)
    return(tibble())
  }

  res <- pluck(result, "data", "series") %>%
    map(~ as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, "name")) %>%
    as_tibble()
  res$date <- pluck(result, "data", "categories") %>%
    flatten_chr() %>%
    as.Date()
  res <- res[c("date", names(res)[names(res) != "date"])]

  return(res)
}

#' Get Plays by Hour of Day
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
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_hourofday>
#' @family Playback History
#' @examples
#' \dontrun{
#' get_plays_by_hourofday()
#' }
get_plays_by_hourofday <- function(url = NULL, apikey = NULL,
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

  result <- api_request(
    url, apikey,
    cmd = "get_plays_by_hourofday",
    time_range = time_range, y_axis = y_axis, user_id = user_id
  )

  if (result$result != "success") {
    warning("Error in 'get_plays_by_hourofday': ", result$result)
    return(tibble())
  }

  res <- pluck(result, "data", "series") %>%
    map(~ as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, "name")) %>%
    as_tibble()
  res$hour <- pluck(result, "data", "categories") %>%
    flatten_chr() %>%
    as.numeric()
  res <- res[c("hour", names(res)[names(res) != "hour"])]

  return(res)
}

#' Get Plays by Day of Week
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
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_dayofweek>
#' @family Playback History
#' @examples
#' \dontrun{
#' get_plays_by_dayofweek()
#' }
get_plays_by_dayofweek <- function(url = NULL, apikey = NULL,
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

  result <- api_request(
    url, apikey,
    cmd = "get_plays_by_dayofweek",
    time_range = time_range, y_axis = y_axis, user_id = user_id
  )

  if (result$result != "success") {
    warning("Error in 'get_plays_by_dayofweek': ", result$result)
    return(tibble())
  }

  res <- pluck(result, "data", "series") %>%
    map(~ as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, "name")) %>%
    as_tibble()
  res$day <- pluck(result, "data", "categories") %>%
    flatten_chr()
  res$day <- factor(res$day, levels = res$day, ordered = TRUE)
  res <- res[c("day", names(res)[names(res) != "day"])]

  return(res)
}

#' Get Plays by Month
#'
#' @inheritParams api_request
#' @inheritParams get_plays_by_date
#' @return A `tbl` with columns `month`, `Movies`, `TV`, `Music`
#' @export
#' @importFrom purrr map_chr
#' @importFrom purrr pluck
#' @importFrom purrr map
#' @importFrom purrr set_names
#' @importFrom purrr flatten_chr
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_month>
#' @family Playback History
#' @examples
#' \dontrun{
#' get_plays_per_month()
#' }
get_plays_per_month <- function(url = NULL, apikey = NULL,
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

  result <- api_request(
    url, apikey,
    cmd = "get_plays_per_month",
    time_range = time_range, y_axis = y_axis, user_id = user_id
  )

  if (result$result != "success") {
    warning("Error in 'get_plays_per_month': ", result$result)
    return(tibble())
  }

  res <- pluck(result, "data", "series") %>%
    map(~ as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, "name")) %>%
    as_tibble()
  res$month <- pluck(result, "data", "categories") %>%
    flatten_chr()
  res$month <- factor(res$month, levels = res$month, ordered = TRUE)
  res <- res[c("month", names(res)[names(res) != "month"])]

  return(res)
}

#' Get Plays by Source Resolution
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
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_source_resolution>
#' @family Playback History
#' @examples
#' \dontrun{
#' get_plays_by_source_resolution()
#' }
get_plays_by_source_resolution <- function(url = NULL, apikey = NULL,
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

  result <- api_request(
    url, apikey,
    cmd = "get_plays_by_source_resolution",
    time_range = time_range, y_axis = y_axis, user_id = user_id
  )

  if (result$result != "success") {
    warning("Error in 'get_plays_by_source_resolution': ", result$result)
    return(tibble())
  }

  res <- pluck(result, "data", "series") %>%
    map(~ as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, "name")) %>%
    as_tibble()
  names(res) <- sub(" ", replacement = "_", x = names(res))

  res$resolution <- pluck(result, "data", "categories") %>%
    flatten_chr()
  res <- res[c("resolution", names(res)[names(res) != "resolution"])]

  return(res)
}

#' Get Plays by Stream Resolution
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
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_source_resolution>
#' @family Playback History
#' @examples
#' \dontrun{
#' get_plays_by_stream_resolution()
#' }
get_plays_by_stream_resolution <- function(url = NULL, apikey = NULL,
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

  result <- api_request(
    url, apikey,
    cmd = "get_plays_by_stream_resolution",
    time_range = time_range, y_axis = y_axis, user_id = user_id
  )

  if (result$result != "success") {
    warning("Error in 'get_plays_by_stream_resolution': ", result$result)
    return(tibble())
  }

  res <- pluck(result, "data", "series") %>%
    map(~ as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, "name")) %>%
    as_tibble()
  names(res) <- sub(" ", replacement = "_", x = names(res))

  res$resolution <- pluck(result, "data", "categories") %>%
    flatten_chr()
  res <- res[c("resolution", names(res)[names(res) != "resolution"])]

  return(res)
}

#' Get Plays by Stream Type
#'
#' @inheritParams api_request
#' @inheritParams get_plays_by_date
#' @return A `tbl` with columns `date`, `Movies`, `TV`, `Music`
#' @export
#' @importFrom purrr map_chr
#' @importFrom purrr pluck
#' @importFrom purrr map
#' @importFrom purrr set_names
#' @importFrom purrr flatten_chr
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_stream_type>
#' @family Playback History
#' @examples
#' \dontrun{
#' get_plays_by_stream_type()
#' }
get_plays_by_stream_type <- function(url = NULL, apikey = NULL,
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

  result <- api_request(
    url, apikey,
    cmd = "get_plays_by_stream_type",
    time_range = time_range, y_axis = y_axis, user_id = user_id
  )

  if (result$result != "success") {
    warning("Error in 'get_plays_by_stream_type': ", result$result)
    return(tibble())
  }

  res <- pluck(result, "data", "series") %>%
    map(~ as.numeric(.x$data)) %>%
    set_names(map_chr(result$data$series, "name")) %>%
    as_tibble()
  names(res) <- sub(" ", replacement = "_", x = names(res))

  res$date <- pluck(result, "data", "categories") %>%
    flatten_chr() %>%
    as.Date()
  res <- res[c("date", names(res)[names(res) != "date"])]

  return(res)
}
