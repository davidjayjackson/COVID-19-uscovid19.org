library(tidyverse)
library(scales)
library(forecast)
library(RSQLite)

rm(list=ls())
db <- dbConnect(SQLite(), dbname="../COVID-19-DB/OURWORLD.sqlite3")
df <- dbGetQuery(db,"select * from OWID")
df <- df %>% filter(location =="United States")
df$date <- as.Date(df$date)


## 365 day rolling average

df$rolling <- ma(df$new_cases,365,centre = T)
df$moving <- ma(df$new_deaths,365,centre = T)


ggplot(df) +
  geom_line(aes(x=date,y=rolling))

ggplot(df) +
  geom_line(aes(x=date,y=moving))
