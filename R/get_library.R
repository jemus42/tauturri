#' Get Library Sections and Names
#'
#' @inheritParams api_request
#'
#' @return A `data.frame` with columns `section_id` and `section_name`
#' @export
#' @importFrom purrr map_df
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
    warning("Error in 'get_plays_by_date': ", result$result)
    return(data.frame())
  }

  result <- map_df(result$data, ~data.frame(.x, stringsAsFactors = FALSE))
  result[order(result$section_id), ]
}
