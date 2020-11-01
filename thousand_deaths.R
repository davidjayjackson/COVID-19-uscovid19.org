## Plot days with deaths over 1000 in US
##
library(RSQLite)
library(ggplot2)
library(scales)
library(plotly)
theme_set(theme_linedraw())
##
rm(list=ls())
db <- db <- dbConnect(RSQLite::SQLite(),dbname= "../COVIDDB/COVID.sqlite3")
df <- dbGetQuery(db,"select * from JHDEATHS")
df$YMD <- as.Date(df$YMD)
df <- df[order(df$YMD),]


##
df1 <- df %>% filter(DEATHS >=1000)
x11()
ggplot(df1) + geom_histogram(aes(x=DEATHS)) + labs(title="Histogram of Covid19 Deaths")
##
x11()
    ggplot(df1) + geom_col(aes(x=YMD,y=DEATHS)) + scale_x_date(date_breaks = "1 month") +
    labs(title="Day With A 1000 Or More Deaths")
##
## Days with 1000 or Fewer Deaths
##
df2 <- df %>% filter(DEATHS <1000)
x11()
    ggplot(df2) + geom_col(aes(x=YMD,y=DEATHS)) + scale_x_date(date_breaks = "1 month") +
    labs(title="Day With Less Than  1000 Deaths")

