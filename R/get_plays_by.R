#' Get Plays by Date
#'
#' @inheritParams api_request
#' @param time_range The number of days of data to return, default is `30`.
#' @param y_axis `"plays"` (default) or `"duration"`
#' @param user_id The user id to filter the data
#' @return A `data.frame`
#' @export
#' @importFrom purrr map_chr
#' @importFrom purrr pluck
#' @importFrom purrr map
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_date>
#'
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

  result <- api_request(url, apikey, cmd = "get_plays_by_date",
                        time_range = time_range, y_axis = y_axis, user_id = user_id)

  if (result$result != "success") {
    warning("Error in 'get_plays_by_date': ", result$result)
    return(data.frame())
  }

  cat_names  <- map_chr(pluck(result, "data", "series"), "name")
  values     <- map(pluck(result, "data", "series"), function(x) {as.numeric(x$data)})
  names(values) <- tolower(cat_names)
  res           <- as.data.frame(values)
  res$date      <- as.Date(unlist(pluck(result, "data", "categories")))
  res           <- res[c("date", names(res)[names(res) != "date"])]

  return(res)
}
