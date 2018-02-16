## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
set.seed(0)

## ----setup_plays_by_date, message=FALSE----------------------------------
library(tauturri)
library(knitr) # kable()
library(dplyr)
library(magrittr)
library(tidyr)

history <- get_plays_by_date(time_range = 365)

history %>% 
  head %>% 
  kable()

## ----plays_by_date_2-----------------------------------------------------
history %<>% 
  gather(Type, Plays, -date)

history %>%
  head %>%
  kable()

## ----plays_by_date_3-----------------------------------------------------
library(ggplot2)
library(hrbrthemes)

ggplot(data = history, aes(x = date, y = Plays, fill = Type)) +
  geom_col() +
  scale_fill_brewer(palette = "Set1") +
  theme_ipsum() +
  theme(legend.position = "top") +
  labs(title = "Plex Server Usage by Day",
       subtitle = "Last Year of Activity",
       y = "# of Plays", x = "Date")

## ----plays_by_date_perc--------------------------------------------------
history %>%
  group_by(date) %>%
  mutate(total = sum(Plays),
         perc = Plays / total) %>%
  ggplot(aes(x = date, y = perc, fill = Type)) +
  geom_col(width = 1) +
  scale_y_percent() +
  scale_fill_brewer(palette = "Set1") +
  theme_ipsum() +
  theme(legend.position = "top") +
  labs(title = "Plex Server Usage by Day and Media Type",
       subtitle = "Last Year of Activity",
       y = "% of Plays", x = "Date")

## ----plays_by_hourofday--------------------------------------------------
history_hours <- get_plays_by_hourofday(time_range = 365) %>%
  gather(Type, Plays, -hour) %>%
  mutate(hour = hms::hms(hours = hour))

ggplot(data = history_hours, aes(x = hour, y = Plays, fill = Type)) +
  geom_col() +
  scale_fill_brewer(palette = "Set1") +
  theme_ipsum() +
  theme(legend.position = "top") +
  labs(title = "Plex Server Usage by Time of Day",
       subtitle = "Last Year of Activity",
       y = "# of Plays", x = "Hour")

## ----plays_by_top_10_users-----------------------------------------------
history_users <- get_plays_by_top_10_users(time_range = 365) %>%
  gather(Type, Plays, -user)

ggplot(data = history_users, aes(x = reorder(user, Plays), y = Plays, fill = Type)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(labels = sample(words, nrow(history_users))) +
  scale_fill_brewer(palette = "Set1") +
  theme_ipsum() +
  theme(legend.position = "top") +
  labs(title = "Plex Server Usage by User",
       subtitle = "Last Year of Activity",
       y = "# of Plays", x = "User")

