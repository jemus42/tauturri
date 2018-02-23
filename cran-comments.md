## Test environments
* local OS X install, R 3.4.3
* ubuntu 14.04 (on travis-ci), R 3.4.3
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* Fix quoting of applicatin names in DESCRIPTION (single instead of double quotes)
* Add links for both Tautulli and Plex
    - There is no generic URL for the Tautulli API since it's intended to be self-hosted by 
    individual users, therefore it's not a public API like e.g. the Twitter API. 
* Remove VignetteBuilder field (along with various "Suggest")

