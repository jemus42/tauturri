#! /usr/bin/env Rscript

devtools::document(roclets = c('rd', 'collate', 'namespace', 'vignette'))
devtools::build()
devtools::reload()
devtools::test()
pkgdown::build_site()

repo <- git2r::repository(".")
git2r::add(repo, "*")
git2r::commit(repo, message = "Rebuild everything", all = TRUE)
