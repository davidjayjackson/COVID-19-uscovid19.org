library(ggplot2)
library(scales)
library(dplyr)
library(RSQLite)
# theme_set(theme_linedraw() + theme(panel.grid = element_line(linetype = 'dashed')))
theme_set(theme_linedraw())
## Pull in some data.
rm(list=ls())
db <- db <- dbConnect(RSQLite::SQLite(),dbname= "../COVIDDB/COVID.sqlite3")
df <- dbGetQuery(db,"select * from ECDC")
df <- subset(df,Countries =="USA" & Deaths >0 )
df$Reported <- as.Date(df$Reported)
##
df$First <- substr(df$Deaths,1,2)
df$First <- as.factor(df$First)
summary(df$First)
##
first_digit <- df %>% group_by(First) %>%
                  summarise(Cts = n())
##                            
ggplot(first_digit) + geom_col(aes(x=First,y=Cts))
