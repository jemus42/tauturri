#' Get Library Sections and Names
#'
#' @inheritParams api_request
#'
#' @return A `tbl` with columns `section_id` and `section_name`
#' @export
#' @importFrom purrr map_df
#' @importFrom purrr map_if
#' @importFrom tibble as_tibble
#' @importFrom tibble tibble
#' @examples
#' \dontrun{
#' get_library_names()
#' }
get_library_names <- function(url = NULL, apikey = NULL) {

  result <- api_request(url = url, apikey = apikey, cmd = "get_library_names")

  if (result$result != "success") {
    warning("Error in 'get_library_names': ", result$result)
    return(tibble())
  }

  result <- map_df(result$data, function(x) {
    x <- map_if(x, is.null, ~ return(NA_character_))
    as_tibble(x)
  })
  result[order(result$section_id), ]
}

#' Get A Library's Media Info
#'
#' @inheritParams api_request
#' @param section_id The id of the Plex library section, OR
#' @param rating_key The grandparent or parent rating key
#' @param section_type Optional, "movie" (default), "show", "artist", "photo"
#' @param order_column Optional, "added_at", "title", "container", "bitrate", "video_codec",
#' "video_resolution", "video_framerate", "audio_codec", "audio_channels",
#' "file_size", "last_played", "play_count"
#' @param order_dir "desc" (default) or "asc"
#' @param start Row to start from, default 0
#' @param length Number of items to return, default 25
#' @param search A string to search for
#'
#' @return A `list` with a `totals` list and an `items` `tbl`
#' @export
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_media_info>
#' @importFrom purrr map_df
#' @importFrom purrr flatten
#' @importFrom tibble tibble
#' @examples
#' \dontrun{
#' get_library_media_info(section_id = 2)
#' }
get_library_media_info <- function(url = NULL, apikey = NULL,
                                   section_id = NULL, rating_key = NULL,
                                   section_type = "movie", order_column = "added_at",
                                   order_dir = "desc", start = 0, length = 25,
                                   search = NULL) {

  if (is.null(section_id) & is.null(rating_key)) {
    stop("Either 'section_id' OR 'rating_key' must be supplied")
  }

  result <- api_request(
    url = url, apikey = apikey, cmd = "get_library_media_info",
    section_id = section_id, rating_key = rating_key,
    section_type = section_type, order_column = order_column,
    order_dir = order_dir, start = start, length = length,
    search = search
  )

  if (result$result != "success") {
    warning("Error in 'get_library_media_info': ", result$result)
    return(tibble())
  }
  if (length(result$data$data) == 1) {
    if (result$data$data == "null") {
      stop("Error in 'get_library_media_info': ", result$data$error)
    }
  }

  totals <- result$data[names(result$data) != "data"]
  items <- result$data$data %>%
    map_df(flatten)

  list(
    totals = totals,
    items = items
  )
}


#' Get Library Watch Time Stats
#'
#' @inheritParams api_request
#' @inheritParams get_library_media_info
#'
#' @return A `tbl` of length 3
#' @export
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_watch_time_stats>
#' @importFrom purrr map_df
#' @importFrom tibble as_tibble
#' @importFrom tibble tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_names>
#' @examples
#' \dontrun{
#' get_library_watch_time_stats(section_id = 2)
#' }
get_library_watch_time_stats <- function(url = NULL, apikey = NULL,
                                         section_id = NULL) {

  result <- api_request(
    url = url, apikey = apikey, cmd = "get_library_watch_time_stats",
    section_id = section_id
  )

  if (result$result != "success") {
    warning("Error in 'get_library_watch_time_stats': ", result$result)
    return(tibble())
  }

  map_df(result$data, as_tibble)
}

#' Get A Single Library Information
#'
#' @inheritParams api_request
#' @param section_id The library's `section_id`, see [get_library_names]
#' @return A `tbl` with columns `section_id` and `section_name`
#' @export
#' @importFrom tibble as_tibble
#' @importFrom tibble tibble
#' @importFrom purrr map_if
#' @examples
#' \dontrun{
#' get_library(section_id = 1)
#' }
get_library <- function(url = NULL, apikey = NULL, section_id) {

  result <- api_request(
    url = url, apikey = apikey, cmd = "get_library",
    section_id = section_id
  )

  if (result$result != "success") {
    warning("Error in 'get_library_names': ", result$result)
    return(tibble())
  }

  result$data <- map_if(result$data, is.null, ~ return(""))
  as_tibble(result$data)
}

#' Get All the Libraries' Data
#'
#' @inheritParams api_request
#' @return A `tbl` with columns `section_id` and `section_name`
#' @export
#' @importFrom tibble as_tibble
#' @importFrom tibble tibble
#' @importFrom purrr map_df
#' @examples
#' \dontrun{
#' get_libraries()
#' }
get_libraries <- function(url = NULL, apikey = NULL) {

  result <- api_request(url = url, apikey = apikey, cmd = "get_libraries")

  if (result$result != "success") {
    warning("Error in 'get_libraries': ", result$result)
    return(tibble())
  }

  map_df(result$data, as_tibble)
}

#' Get All the Libraries-Table
#'
#' @inheritParams api_request
#' @inheritParams get_library_media_info
#' @return A `tbl` with columns `section_id` and `section_name`
#' @export
#' @importFrom purrr map_if
#' @importFrom purrr map_df
#' @examples
#' \dontrun{
#' get_libraries_table()
#' }
get_libraries_table <- function(url = NULL, apikey = NULL,
                                order_column = NULL, order_dir = "desc",
                                start = 0, length = 25, search = NULL) {

  result <- api_request(
    url = url, apikey = apikey, cmd = "get_libraries_table",
    order_column = order_column, order_dir = order_dir,
    start = start, length = length, search = search
  )

  if (result$result != "success") {
    warning("Error in 'get_libraries': ", result$result)
    return(tibble())
  }

  res <- map_df(result$data$data, function(x) {
    x <- map_if(x, ~ identical(list(), .x), ~ return(""))
    x <- map_if(x, is.null, ~ return(""))
    x <- map_if(x, is.list, ~ paste0(.x, collapse = ", "))
    x <- map(x, as.character)
    as_tibble(x)
  })

  res$duration <- as.numeric(res$duration)
  res$year <- as.numeric(res$year)
  res$plays <- as.numeric(res$plays)
  res$child_count <- as.numeric(res$child_count)
  res$parent_count <- as.numeric(res$parent_count)

  res
}

#' Get Library User Stats
#'
#' @inheritParams api_request
#' @param section_id The library's `section_id`, e.g. `1`.
#' @return A `tbl` with 4 columns and one row per user.
#' @export
#' @importFrom tibble as_tibble
#' @importFrom tibble tibble
#' @importFrom purrr map_df
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_user_stats>
#' @examples
#' \dontrun{
#' get_library_user_stats(section_id = 1)
#' }
get_library_user_stats <- function(url = NULL, apikey = NULL, section_id) {

  result <- api_request(
    url = url, apikey = apikey, cmd = "get_library_user_stats",
    section_id = section_id
  )

  if (result$result != "success") {
    warning("Error in 'get_library_user_stats': ", result$result)
    return(tibble())
  }

  map_df(result$data, as_tibble)
}
