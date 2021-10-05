library(tidyverse)
library(scales)
library(pracma)
rm(list=ls())
db <- dbConnect(SQLite(), dbname="../COVID-19-DB/OURWORLD.sqlite3")
df <- dbGetQuery(db,"select * from OWID")
df <- df %>% filter(location =="United States")
# df <- subset(df,location =="United States" )
df$date <- as.Date(df$date)
## Calc Moivng Averages: weighted and exponential
df$weighted <- movavg(df$new_cases,14,type ="w")
df$exponential <- movavg(df$new_cases,14,type="e")
## Plot both 
df %>% filter(date >="2021-01-01") %>%
ggplot() +
  geom_line(aes(x=date,y=weighted,col="Weighted")) +
  geom_line(aes(x=date,y=exponential,col="Exponential"))

library(BenfordTests)
?BenfordTests
set.seed(421)
X<-rbenf(n=200)
Y<-rbenf(n=200)
X <- as.data.frame(X)
Y <- as.data.frame(Y)
bf <- as.data.frame(X$X,Y$Y)
hist(X$X)
hist(Y$Y)
