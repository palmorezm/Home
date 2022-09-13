
# Line Plot
# Using simulated data
library(dplyr)
library(lubridate)
# setwd("C:/Users/Zachary.Palmore/GitHub/Home/home_afford_app")
source("helper.R")
# The original data inputs:
savings <- monthly_savings(input$monthly_income, input$expenses)
# create df from init_savings, savings, start_date, and end_date
df <- create_savingsdf(init_savings = input$init_savings,
                       savings,
                       start_date = input$dates[1],
                       end_date = input$dates[2])
# Recreate monthly savings given some number
start_date <- as.Date("2020-01-01")
end_date <- as.Date("2025-12-31")
monthly_income <-  3000
monthly_expenses <- 1500
current_savings <- 10000
# seq(from = start_date, to = end_date, by = )
Date <- seq.Date(from = start_date, to = end_date, by = 1)
df <- ""
df$date <- seq.Date(from = start_date, to = end_date, by = 1)
data.frame(df) %>% 
  mutate(month = lubridate::month(date), 
         current_savings = current_savings, 
         month_tally = rep(rep(1:12, 12), length(df$date)),
         test = month*(current_savings + (monthly_income - monthly_expenses))) %>% View()
  mutate(date = seq.Date(from = start_date, to = end_date, by = 1), 
         theoretical_savings = current_savings + (monthly_income - monthly_expenses))

df <- create_savingsdf(init_savings = current_savings, 
                 savings = monthly_income - monthly_expenses, 
                 start_date = start_date, end_date = end_date)

calculate_savings(current_savings, savings = monthly_income - monthly_expenses, 
                  start_date = start_date, end_date = end_date)


df$Points <- rnorm(72, mean = monthly_income - monthly_expenses, sd = 1700) # Insert realistic standard deviation
df <- df %>% mutate(Theory_Savings = cumsum(Points)) 
library(ggplot2) 
ggplot(df, aes(Date, Theory_Savings)) + geom_point() + geom_smooth(method = "lm")

ggplot(df, aes(x = Date, y = Savings, group = 1)) +
  geom_line(size = 2) + 
  scale_x_date(date_labels = "%b-%Y") + 
  scale_y_continuous(labels=scales::dollar_format()) + 
  theme_minimal()