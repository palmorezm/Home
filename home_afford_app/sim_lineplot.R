
# Line Plot
# Using simulated data
library(dplyr)
library(ggplot2) 
library(lubridate)
# setwd("C:/Users/Zachary.Palmore/GitHub/Home/home_afford_app")
source("helper.R")
# The original data inputs:
# savings <- monthly_savings(input$monthly_income, input$expenses)
# # create df from init_savings, savings, start_date, and end_date
# df <- create_savingsdf(init_savings = input$init_savings,
#                        savings,
#                        start_date = input$dates[1],
#                        end_date = input$dates[2])
# Recreate monthly savings given some number
start_date <- as.Date("2022-09-15")
end_date <- as.Date("2023-12-31")
goal_purchase_date <- as.Date("2023-10-01")
monthly_income <-  4000
monthly_expenses <- 2800
current_savings <- 24000
dp <- down_payment(calculate_loan(monthly_income * 12, .04, 30), 20)
# seq(from = start_date, to = end_date, by = )
df <- ""
df$date <- seq.Date(from = start_date, to = end_date, by = 1)
df <- create_savingsdf(init_savings = current_savings, 
                 savings = monthly_income - monthly_expenses, 
                 start_date = start_date, end_date = end_date)

calculate_savings(current_savings, savings = monthly_income - monthly_expenses, 
                  start_date = start_date, end_date = end_date)

# What is this intended to do? 
df$Points <- rnorm(length(df$Savings), mean = monthly_income - monthly_expenses, sd = 3000) # Insert realistic standard deviation
df <- df %>% mutate(Theory_Savings = cumsum(Points))
# Visualizing
ggplot(df, aes(Date, Theory_Savings + Savings)) + 
  geom_smooth(method = "lm") +
  geom_point() + geom_line(aes(Date, Savings)) +
  geom_hline(yintercept = dp, lty = 3) +
  geom_hline(yintercept = current_savings, lty = 3) +
  geom_vline(xintercept = goal_purchase_date) + 
  scale_x_date(date_labels = "%b-%Y", breaks = as.Date("2024-01-01")) + 
  scale_y_continuous(labels=scales::dollar_format(), 
                     breaks = c(10000, 80000)) +
  theme_classic() 

# TODO: 
# On the y axis to show only starting savings and required down payment amount
# On the x axis show only necessary dates?
# Place text box with date of goal 
# Have another text box to show difference between savings at goal date and what's needed to reach goal
# Show when scenario 1 occurs, stop linear trend for old data, then update trend with new scenario 1 data


# The variation should be controlled by the user. 
# It should demonstrate that if you're loose with ya money ya lose money
# And there is not a lot of ways of getting back without earning more 

# Part 1
# Create a simulated dataset that takes the income, expenses, and savings variables as inputs
# and produce some 'natural' (or normalized) variation. 

# A)
# Acknowledging the inputs and their effects: 
# Current savings shifts the savings plot by adjusting the starting point
# Date Range controls start and end points for savings goals
# Monthly income (net) is the total money earned in a month 
# Monthly expenses is the total money spent in a month 
# The rest of the controls do not impact the savings plot 

# B) Forming a data frame with those components
# C) 

