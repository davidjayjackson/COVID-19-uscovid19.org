library(tidyverse)
library(scales)
theme_set(theme_gray())

median_deaths <- median(df$new_deaths,na.rm = T)
mean_deaths <- mean(df$new_deaths,na.rm = T)
deaths_sd <- sd(df$new_deaths,na.rm = T)
cases_sd <- sd(df$new_cases,na.rm = T)
deaths_low_sd <- mean_deaths - deaths_sd
deaths_hi_sd <- mean_deaths + deaths_sd
  
  ggplot(df) + geom_histogram(aes(x=new_deaths,group=factor(Year))) +
  geom_vline(aes(xintercept = median_deaths,col="Median"),lwd=3) +
    geom_vline(aes(xintercept = mean_deaths,col="Mean"),lwd=3) +
    geom_vline(aes(xintercept = deaths_low_sd,col="Std Dev -1 "),lwd=3) +
    geom_vline(aes(xintercept = deaths_hi_sd,col="Std Dev +1"),lwd=3) +
  scale_x_continuous(labels = comma) +
    labs(title ="Histogram of US Covid-19 Deaths by Year") +
  facet_wrap(~Year) 
  
  median_cases <- median(df$new_cases,na.rm = T)
  mean_cases <- mean(df$new_cases,na.rm = T)
  
  ggplot(df) + geom_histogram(aes(x=new_cases,group=factor(Year))) +
    geom_vline(aes(xintercept = median_cases,col="Median"),lwd=1) +
    geom_vline(aes(xintercept = mean_cases,col="Mean"),lwd=1) +
    scale_x_continuous(labels = comma) +
    labs(title ="Histogram of US Covid-19 Cases by Year") +
    facet_wrap(~Year) 
  