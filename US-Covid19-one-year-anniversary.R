## USA Covid-19 One Year Anniversary

library(ggplot2)
library(scales)
library(forecast)
library(dplyr)
library(forecast)
library(readr)
library(plotly)
theme_set(theme_gray())
## Read Data
rm(list=ls())
US <- read_csv("./DATA/owid-covid-data.csv") %>% filter(location=="United States") %>%
  select(date,new_cases,new_deaths,total_cases,total_deaths)
## Calculate 14 Day Moving Averages: Cases and Deaths
US$MAC <- ma(US$new_cases,7,centre = TRUE)
US$MAD <- ma(US$new_deaths,7,centre = TRUE) 
summary(US)

### PLot of US Daily Cases w/ 14 Day Moving Average
p1 <- US %>% filter(date >="2020-01-24") %>% ggplot() + geom_line(aes(x=date,y=new_cases,col="Daily Cases"),lwd=1) +
  geom_line(aes(x=date,y=MAC,col="Moving Average"),lwd=1) +
  labs(title="US Daily Cases w/ 14 Day Moving Average",x="Year",y="Daily Cases") +
  scale_y_continuous(labels=comma)
ggplotly(p1)

### PLot of US Daily Cases w/ 14 Day Moving Average Since Jan. 1, 2021
p2 <- US %>% filter(date >="2021-01-01") %>% ggplot() + geom_line(aes(x=date,y=new_cases,col="Daily Cases"),lwd=1) +
  geom_line(aes(x=date,y=MAC,col="Moving Average"),lwd=1) +
  labs(title="US Daily Cases w/ 14 Day Moving Average",x="Year",y="Daily Cases") +
  scale_y_continuous(labels=comma)
ggplotly(p2)
### PLot of US Daily Deaths w/ 14 Day Moving Average
p3 <- US %>% filter(date >="2020-02-29") %>% ggplot() + geom_line(aes(x=date,y=new_deaths,col="Daily Deaths"),lwd=1) +
  geom_line(aes(x=date,y=MAD,col="Moving Average"),lwd=1) +
  labs(title="US Daily Deaths w/ 14 Day Moving Average",x="Year",y="Daily Deaths") +
  scale_y_continuous(labels=comma)
ggplotly(p3)
