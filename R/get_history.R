#' Get Playback History
#'
#' @inheritParams api_request
#' @param grouping  0 (default) or 1
#' @param user  "Jon Snow"
#' @param user_id  133788
#' @param rating_key 4348
#' @param parent_rating_key 544
#' @param grandparent_rating_key 351
#' @param start_date "YYYY-MM-DD"
#' @param section_id 2
#' @param media_type "movie", "episode", "track"
#' @param transcode_decision "direct play", "copy", "transcode",
#' @param order_column "date", "friendly_name", "ip_address", "platform", "player", "full_title", "started", "paused_counter", "stopped", "duration"
#' @param order_dir "desc" (default) or "asc"
#' @param start  Row to start from, 0 (default)
#' @param length  Number of items to return, 25
#' @param search  A string to search for, "Thrones"
#'
#' @return A `list` with totals and the history as `tbl`
#' @export
#' @importFrom purrr map
#' @importFrom purrr flatten
#' @importFrom purrr reduce
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @importFrom plyr rbind.fill
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_history>
#' @examples
#' \dontrun{
#' get_history(length = 10)
#' }
get_history <- function(url = NULL, apikey = NULL,
                        grouping = 0, user = NULL, user_id = NULL, rating_key = NULL,
                        parent_rating_key = NULL, grandparent_rating_key = NULL,
                        start_date = NULL, section_id = NULL, media_type = NULL,
                        transcode_decision = NULL, order_column = NULL,
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

  result <- api_request(url, apikey, cmd = "get_history",
                        grouping = grouping, user = user, user_id = user_id,
                        rating_key = rating_key, parent_rating_key = parent_rating_key,
                        grandparent_rating_key = grandparent_rating_key,
                        start_date = start_date, section_id = section_id,
                        media_type = media_type, transcode_decision = transcode_decision,
                        order_column = order_column, order_dir = order_dir,
                        start = start, length = length, search = search)

  if (result$result != "success") {
    warning("Error in 'get_history': ", result$result)
    return(list(totals = tibble(),
                history = tibble()))
  }

  totals  <- as_tibble(result$data[names(result$data) != "data"])

  history <- map(result[["data"]][["data"]], ~as_tibble(flatten(.x))) %>%
    reduce(plyr::rbind.fill)

  history$started     <- as.POSIXct(history$started, origin = "1970-01-01")
  history$stopped     <- as.POSIXct(history$stopped, origin = "1970-01-01")
  history$date        <- as.POSIXct(history$date, origin = "1970-01-01")
  history$year        <- as.numeric(history$year)
  history$media_index <- as.character(history$media_index)
  history$rating_key  <- as.character(history$rating_key)
  history$parent_rating_key      <- as.character(history$parent_rating_key)
  history$parent_media_index     <- as.character(history$parent_media_index)
  history$grandparent_rating_key <- as.character(history$grandparent_rating_key)

  if ("session_key" %in% names(history)) {
    history$session_key <- as.character(history$session_key)
  }

  list(totals = totals,
       history = history)

}
