#' Get Library Sections and Names
#'
#' @inheritParams api_request
#'
#' @return A `data.frame` with columns `section_id` and `section_name`
#' @export
#' @importFrom purrr map_df
#' @importFrom tibble as_tibble
#' @importFrom tibble tibble
#' @examples
#' \dontrun{
#' get_library_names()
#' }
get_library_names <- function(url = NULL, apikey = NULL) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  result <- api_request(url = url, apikey = apikey, cmd = "get_library_names")

  if (result$result != "success") {
    warning("Error in 'get_library_names': ", result$result)
    return(tibble())
  }

  result <- map_df(result$data, as_tibble)
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
#' @importFrom purrr map_df
#' @importFrom purrr flatten
#' @examples
#' \dontrun{
#' get_library_media_info(section_id = 2)
#' }
get_library_media_info <- function(url = NULL, apikey = NULL,
                                   section_id = NULL, rating_key = NULL,
                                   section_type = "movie", order_column = "added_at",
                                   order_dir = "desc", start = 0, length = 25,
                                   search = NULL) {
  if (is.null(url)) {
    url <- Sys.getenv("tautulli_url")
  }
  if (is.null(apikey)) {
    apikey <- Sys.getenv("tautulli_apikey")
  }
  if (apikey == "" | url == "") {
    stop("No URL or API-Key set, please see setup instructions")
  }

  if (is.null(section_id) & is.null(rating_key)) {
    stop("Either 'section_id' OR 'rating_key' must be supplied")
  }

  result <- api_request(url = url, apikey = apikey, cmd = "get_library_media_info",
                        section_id = section_id, rating_key = rating_key,
                        section_type = section_type, order_column = order_column,
                        order_dir = order_dir, start = start, length = length,
                        search = search)

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

  list(totals = totals,
       items = items)

}
