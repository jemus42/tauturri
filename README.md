
<!-- README.md is generated from README.Rmd. Please edit that file -->
tauturri
========

[![Travis build status](https://travis-ci.org/jemus42/tauturri.svg?branch=master)](https://travis-ci.org/jemus42/tauturri) [![Coverage status](https://codecov.io/gh/jemus42/tauturri/branch/master/graph/badge.svg)](https://codecov.io/github/jemus42/tauturri?branch=master) [![CRAN status](http://www.r-pkg.org/badges/version/tauturri)](https://cran.r-project.org/package=tauturri)

The goal of `tauturri` is to get data out of [**Tautulli**](https://github.com/Tautulli/Tautulli) (formerly **PlexPy**) as simply as possible.

The project is still pretty young, and while it's reasonably functional, there might still be some issues. At least it passes all the tests, I guess?

Installation
------------

I don't know if I want to push this to CRAN yet, so we stick with the GitHub version for no.

``` r
if (!("remotes" %in% installed.packages())){
  install.packages("remotes")
}

remotes::install_github("jemus42/tauturri")
```

Setup
-----

In your `~/.Renviron`, set the following:

    # Tautulli
    tautulli_url=<Tautulli URL (with port, if necessary)>
    tautulli_apikey=<Tautilli API key>

That's it.
Alternatively use `Sys.setenv()` to set the appropriate values in a script.

Server Info
-----------

``` r
info <- get_servers_info()

# Probably shouldn't show URL etc.
names(info)
#> [1] "port"               "host"               "version"           
#> [4] "name"               "machine_identifier"
info[c("name", "version")]
#> # A tibble: 1 x 2
#>   name  version              
#>   <chr> <chr>                
#> 1 PPTH  1.11.3.4803-c40bba82e
```

`get_plays_by` \[date|dayofweek|...\]
-------------------------------------

All plays in the current year, per day:

``` r
plays <- get_plays_by_date(time_range = lubridate::yday(lubridate::now()))

plays %>% 
  gather(category, playcount, TV, Movies, Music) %>%
  ggplot(aes(x = date, y = playcount, fill = category)) +
  geom_col() +
  scale_fill_brewer(palette = "Set1", 
                    breaks = c("Movies", "TV", "Music")) +
  labs(title = "Plex Plays by Date",
       subtitle = "Showing Movie, TV and Music Categories",
       x = "Date", y = "Plays", fill = "Category") +
  theme_minimal() +
  theme(legend.position = "top")
```

<img src="man/figures/README-get_plays_by_date-1.png" width="100%" />

... per day of week:

``` r
plays <- get_plays_by_dayofweek(time_range = lubridate::yday(lubridate::now()))

plays %>% 
  gather(category, playcount, TV, Movies, Music) %>%
  ggplot(aes(x = day, y = playcount, fill = category)) +
  geom_col() +
  scale_fill_brewer(palette = "Set1", 
                    breaks = c("Movies", "TV", "Music")) +
  labs(title = "Plex Plays by Day of Week",
       subtitle = "Showing Movie, TV and Music Categories",
       x = "Day", y = "Plays", fill = "Category") +
  theme_minimal() +
  theme(legend.position = "top")
```

<img src="man/figures/README-get_plays_by_dayofweek-1.png" width="100%" />

... and per hour of day:

``` r
plays <- get_plays_by_hourofday(time_range = lubridate::yday(lubridate::now()))

plays %>% 
  gather(category, playcount, TV, Movies, Music) %>%
  ggplot(aes(x = hms::hms(hours = hour), y = playcount, fill = category)) +
  geom_col() +
  scale_fill_brewer(palette = "Set1", 
                    breaks = c("Movies", "TV", "Music")) +
  labs(title = "Plex Plays by Hour of Day",
       subtitle = "Showing Movie, TV and Music Categories",
       x = "Hour", y = "Plays", fill = "Category") +
  theme_minimal() +
  theme(legend.position = "top")
```

<img src="man/figures/README-get_plays_by_hourofday-1.png" width="100%" />

API Functions Not Yet Implemented
---------------------------------

``` r
api_functions <- names(api_request(cmd = "docs")$data)
api_functions <- api_functions[grepl("^get_", api_functions)]
sort(api_functions[!(api_functions %in% getNamespaceExports("tauturri"))])
#>  [1] "get_apikey"               "get_date_formats"        
#>  [3] "get_geoip_lookup"         "get_home_stats"          
#>  [5] "get_logs"                 "get_metadata"            
#>  [7] "get_new_rating_keys"      "get_notification_log"    
#>  [9] "get_notifier_config"      "get_notifier_parameters" 
#> [11] "get_notifiers"            "get_old_rating_keys"     
#> [13] "get_plex_log"             "get_pms_token"           
#> [15] "get_pms_update"           "get_server_friendly_name"
#> [17] "get_server_id"            "get_server_pref"         
#> [19] "get_settings"             "get_synced_items"        
#> [21] "get_user"                 "get_user_ips"            
#> [23] "get_user_logins"          "get_whois_lookup"
```

Test Results
------------

``` r
date()
#> [1] "Thu Feb 22 16:57:27 2018"
devtools::test()
#> Loading tauturri
#> Loading required package: testthat
#> Testing tauturri
#> ✔ | OK F W S | Context
#> 
⠏ |  0       | test-api-interaction.R
⠋ |  1       | test-api-interaction.R
⠙ |  2       | test-api-interaction.R
⠹ |  3       | test-api-interaction.R
⠸ |  4       | test-api-interaction.R
⠼ |  5       | test-api-interaction.R
⠴ |  6       | test-api-interaction.R
⠦ |  7       | test-api-interaction.R
✔ |  7       | test-api-interaction.R [0.5 s]
#> 
⠏ |  0       | test-get_activity.R
⠋ |  1       | test-get_activity.R
⠙ |  2       | test-get_activity.R
⠹ |  3       | test-get_activity.R
⠸ |  4       | test-get_activity.R
⠼ |  5       | test-get_activity.R
✔ |  5       | test-get_activity.R
#> 
⠏ |  0       | test-get_history.R
⠋ |  1       | test-get_history.R
⠙ |  2       | test-get_history.R
⠹ |  3       | test-get_history.R
⠸ |  4       | test-get_history.R
✔ |  4       | test-get_history.R [0.4 s]
#> 
⠏ |  0       | test-get_library.R
⠋ |  1       | test-get_library.R
⠙ |  2       | test-get_library.R
⠹ |  3       | test-get_library.R
⠸ |  4       | test-get_library.R
⠼ |  5       | test-get_library.R
⠴ |  6       | test-get_library.R
⠦ |  7       | test-get_library.R
⠧ |  8       | test-get_library.R
⠇ |  9       | test-get_library.R
⠏ | 10       | test-get_library.R
⠋ | 11       | test-get_library.R
⠙ | 12       | test-get_library.R
⠹ | 13       | test-get_library.R
⠸ | 14       | test-get_library.R
⠼ | 15       | test-get_library.R
⠴ | 16       | test-get_library.R
⠦ | 17       | test-get_library.R
⠧ | 18       | test-get_library.R
⠇ | 19       | test-get_library.R
⠏ | 20       | test-get_library.R
⠋ | 21       | test-get_library.R
⠙ | 22       | test-get_library.R
⠹ | 23       | test-get_library.R
⠸ | 24       | test-get_library.R
⠼ | 25       | test-get_library.R
⠴ | 26       | test-get_library.R
⠦ | 27       | test-get_library.R
⠧ | 28       | test-get_library.R
⠇ | 29       | test-get_library.R
⠏ | 30       | test-get_library.R
⠋ | 31       | test-get_library.R
✔ | 31       | test-get_library.R [2.9 s]
#> 
⠏ |  0       | test-get_plays_by.R
⠋ |  1       | test-get_plays_by.R
⠙ |  2       | test-get_plays_by.R
⠹ |  3       | test-get_plays_by.R
⠸ |  4       | test-get_plays_by.R
⠼ |  5       | test-get_plays_by.R
⠴ |  6       | test-get_plays_by.R
⠦ |  7       | test-get_plays_by.R
⠧ |  8       | test-get_plays_by.R
⠇ |  9       | test-get_plays_by.R
⠏ | 10       | test-get_plays_by.R
⠋ | 11       | test-get_plays_by.R
⠙ | 12       | test-get_plays_by.R
⠹ | 13       | test-get_plays_by.R
⠸ | 14       | test-get_plays_by.R
⠼ | 15       | test-get_plays_by.R
⠴ | 16       | test-get_plays_by.R
⠦ | 17       | test-get_plays_by.R
⠧ | 18       | test-get_plays_by.R
⠇ | 19       | test-get_plays_by.R
⠏ | 20       | test-get_plays_by.R
⠋ | 21       | test-get_plays_by.R
⠙ | 22       | test-get_plays_by.R
⠹ | 23       | test-get_plays_by.R
⠸ | 24       | test-get_plays_by.R
⠼ | 25       | test-get_plays_by.R
⠴ | 26       | test-get_plays_by.R
⠦ | 27       | test-get_plays_by.R
⠧ | 28       | test-get_plays_by.R
⠇ | 29       | test-get_plays_by.R
✔ | 29       | test-get_plays_by.R [0.8 s]
#> 
⠏ |  0       | test-get_user.R
⠋ |  1       | test-get_user.R
⠙ |  2       | test-get_user.R
⠹ |  3       | test-get_user.R
⠸ |  4       | test-get_user.R
⠼ |  5       | test-get_user.R
⠴ |  6       | test-get_user.R
⠦ |  7       | test-get_user.R
⠧ |  8       | test-get_user.R
⠇ |  9       | test-get_user.R
⠏ | 10       | test-get_user.R
⠋ | 11       | test-get_user.R
⠙ | 12       | test-get_user.R
⠹ | 13       | test-get_user.R
⠸ | 14       | test-get_user.R
⠼ | 15       | test-get_user.R
⠴ | 16       | test-get_user.R
⠦ | 17       | test-get_user.R
⠧ | 18       | test-get_user.R
⠇ | 19       | test-get_user.R
⠏ | 20       | test-get_user.R
⠋ | 21       | test-get_user.R
⠙ | 22       | test-get_user.R
⠹ | 23       | test-get_user.R
✔ | 23       | test-get_user.R [1.6 s]
#> 
⠏ |  0       | test-recently-added.R
⠋ |  1       | test-recently-added.R
⠙ |  2       | test-recently-added.R
⠹ |  3       | test-recently-added.R
⠸ |  4       | test-recently-added.R
⠼ |  5       | test-recently-added.R
✔ |  5       | test-recently-added.R [0.8 s]
#> 
⠏ |  0       | test-server-info.R
⠋ |  1       | test-server-info.R
⠙ |  2       | test-server-info.R
⠹ |  3       | test-server-info.R
⠸ |  4       | test-server-info.R
⠼ |  5       | test-server-info.R
⠴ |  6       | test-server-info.R
⠦ |  7       | test-server-info.R
⠧ |  8       | test-server-info.R
⠇ |  9       | test-server-info.R
⠏ | 10       | test-server-info.R
⠋ | 11       | test-server-info.R
✔ | 11       | test-server-info.R [1.1 s]
#> 
⠏ |  0       | test-top10.R
⠋ |  1       | test-top10.R
⠙ |  2       | test-top10.R
⠹ |  3       | test-top10.R
⠸ |  4       | test-top10.R
⠼ |  5       | test-top10.R
⠴ |  6       | test-top10.R
⠦ |  7       | test-top10.R
⠧ |  8       | test-top10.R
⠇ |  9       | test-top10.R
⠏ | 10       | test-top10.R
⠋ | 11       | test-top10.R
⠙ | 12       | test-top10.R
⠹ | 13       | test-top10.R
⠸ | 14       | test-top10.R
⠼ | 15       | test-top10.R
⠴ | 16       | test-top10.R
✔ | 16       | test-top10.R [1.0 s]
#> 
#> ══ Results ════════════════════════════════════════════════════════════════════════════════════════════════════
#> Duration: 9.3 s
#> 
#> OK:       131
#> Failed:   0
#> Warnings: 0
#> Skipped:  0
```

CoC
---

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
