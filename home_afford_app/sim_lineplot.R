
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
start_date <- as.Date("2020-01-01")
end_date <- as.Date("2025-12-31")
monthly_income <-  3000
monthly_expenses <- 1500
current_savings <- 10000
# seq(from = start_date, to = end_date, by = )
df <- ""
df$date <- seq.Date(from = start_date, to = end_date, by = 1)
df <- create_savingsdf(init_savings = current_savings, 
                 savings = monthly_income - monthly_expenses, 
                 start_date = start_date, end_date = end_date)

calculate_savings(current_savings, savings = monthly_income - monthly_expenses, 
                  start_date = start_date, end_date = end_date)
dp <- down_payment(calculate_loan(monthly_income * 12, .04, 30), 20)
goal_purchase_date <- as.Date("2024-06-01")
df$Points <- rnorm(length(df$Savings), mean = monthly_income - monthly_expenses, sd = 3000) # Insert realistic standard deviation
df <- df %>% mutate(Theory_Savings = cumsum(Points))
# Visualizing
ggplot(df, aes(Date, Theory_Savings)) + 
  geom_smooth(method = "lm") +
  geom_point() + geom_line(aes(Date, Savings)) +
  scale_x_date(date_labels = "%b-%Y") + 
  scale_y_continuous(labels=scales::dollar_format()) +
  geom_hline(yintercept = dp, lty = 3) +
  geom_hline(yintercept = current_savings, lty = 3) +
  geom_vline(xintercept = goal_purchase_date)
  theme_minimal()

# Scenarios
# in each scenario we want to change the amount of savings that gets accrued starting at a given time
# inputs: start time of new job, new monthly income, new monthly expenses? 
new_date <- as.Date("2022-11-01")
new_monthly_income <- 3000
new_monthly_expenses <- 500

df %>% 
  mutate(Scenario1 = case_when(
    Date < new_date ~ as.numeric(0),
    Date >= new_date ~ as.numeric(cumsum(rnorm(length(Savings), 
                                               mean = new_monthly_income - new_monthly_expenses, 
                                               sd = 500)))
  ))

# Value at current time
# Value after first boost
# Cumulative values after boost
x <- rbinom(1:100, 10, (1/6))
plot(x, main= "Binomial")
x <- rgeom(1:100, (1/6))
plot(x, main= "Geometric")
x <- rpois(1:100, lambda = (1/6))
plot(x, main= "Poisson")
x <- runif(1:100, min = 1, max = 6)
plot(x, main= "Uniform")
x <- rexp(1:100, rate = 1)
plot(x, main= "Exponential")
x <- rnorm(1:100, mean = 3, sd = 1)
plot(x, main= "Normal")

library(mnonr)
mnonr::mnonr(72, 2, 2)
mnonr::unonr(72, mu = monthly_income - monthly_expenses, 
             Sigma = matrix(c(1,0.5,0.5,1), 2,2))
unonr(100, c(1, 2), matrix(c(10, 2, 2, 5), 2, 2), 
      skewness = c(1, 2), 
      kurtosis = c(3, 8))
mnonr::mnonr(n=10000,p=2,ms=3,mk=61,
             Sigma=matrix(c(1,0.5,0.5,1),2,2),
             initial=NULL)
