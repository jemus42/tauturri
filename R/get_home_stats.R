#' Get Home Stats
#'
#' The data displayed on the *Tautulli* home.
#' @inheritParams api_request
#' @param grouping 0 or 1
#' @param time_range The time range to calculate statistics, default is `30`
#' @param stats_type `0` for plays (default), `1` for duration
#' @param stats_count The number of top items to list, default is `5`
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_home_stats>
#' @return A `list` of length 10, with `tbl`s for each category of stats.
#' @export
#' @importFrom purrr map_df
#' @importFrom purrr compact
#' @importFrom purrr map_chr
#' @importFrom purrr map
#' @importFrom purrr transpose
#' @importFrom tibble as_tibble
#' @examples
#' \dontrun{
#' get_home_stats()
#' }
get_home_stats <- function(url = NULL, apikey = NULL,
                           grouping = 0, time_range = 30, stats_type = 0,
                           stats_count = 5) {

  result <- api_request(
    url = url, apikey = apikey,
    cmd = "get_home_stats",
    grouping = grouping, time_range = time_range,
    stats_type = stats_type, stats_count = stats_count
  )

  res <- result$data

  # It's a nasty list, baby steps.
  names(res) <- map_chr(res, ~ gsub(" ", "_", .x$stat_title))
  res <- map(res, "rows")

  map(res, function(x) {
    x %>%
      map(compact) %>%
      transpose() %>%
      as_tibble() %>%
      map_df(unlist)
  })
}
