#' Get Recently Added Media Items
#'
#' @inheritParams api_request
#' @param count The number of items to return, default is `10`.
#' @param section_id Optional. The id of the Plex library section, e.g. `1``
#' @param start Optional. The item number to start at, e.g. `0`
#'
#' @return A `tbl` with `count` rows and 18 columns.
#' @export
#' @importFrom purrr map_df
#' @importFrom tibble as_tibble
#' @source <https://github.com/Tautulli/Tautulli/blob/master/API.md#get_recently_added>
#' @examples
#' \dontrun{
#' get_recently_added(section_id = 1)
#' }
get_recently_added <- function(url = NULL, apikey = NULL, count = 10,
                               section_id = NULL, start = NULL) {
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
    url = url, apikey = apikey, cmd = "get_recently_added",
    count = count, section_id = section_id, start = start
  )

  map_df(result$data$recently_added, function(x) {
    x <- map_if(x, .p = ~is.null(.x), function(y) return(NA))
    x <- map_if(x, .p = ~identical(.x, list()), function(y) return(NA))

    as_tibble(x)
  })
}
