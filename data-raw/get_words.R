words <- readr::read_lines("data-raw/1-1000.txt")
words <- words[nchar(words) > 5]
words <- words[!(grepl("'", words))]

usethis::use_data(words, overwrite = TRUE)
