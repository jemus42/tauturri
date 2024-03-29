% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{words}
\alias{words}
\title{Common English Words}
\format{
A \code{character} of length 283 containing words.
}
\source{
\url{https://gist.github.com/deekayen/4148741/01c6252ccc5b5fb307c1bb899c95989a8a284616/}
}
\usage{
words
}
\description{
A subset of 283 of the 1000 most common English words.
From the original list, only words longer than 5 and without apostrophes were selected.
}
\note{
I should have just used \code{stringr::words}
}
\keyword{dataset}
