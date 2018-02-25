#! /usr/bin/env Rscript

usethis::use_tidy_style()
usethis::use_tidy_description()
devtools::document(roclets = c('rd', 'collate', 'namespace', 'vignette'))
devtools::build()
devtools::reload()
devtools::test()
pkgdown::build_site()

repo <- git2r::repository(".")
git2r::add(repo, "*")
git2r::commit(repo, message = "Rebuild everything", all = TRUE)
