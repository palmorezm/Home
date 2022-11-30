# Packages
library(dplyr)
library(ggplot2) 
library(lubridate)
# setwd("C:/Users/Zachary.Palmore/GitHub/Home/home_afford_app")
source("helper.R")

# This script is trash

# Starting data
start_date <- as.Date("2020-09-15")
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

df$Points <- rnorm(length(df$Savings), mean = monthly_income - monthly_expenses, sd = 3000) # Insert realistic standard deviation
df <- df %>% mutate(Theory_Savings = cumsum(Points))



# Scenarios
# in each scenario we want to change the amount of savings that gets accrued starting at a given time
# inputs: start time of new job, new monthly income, new monthly expenses? 

# New data
new_date <- as.Date("2022-10-01")
new_monthly_income <- 4700
new_monthly_expenses <- 5


df %>% 
  mutate(Scenario1 = case_when(
    Date < new_date ~ as.numeric(0), 
    Date >= new_date ~ rnorm(length(Savings), mean = new_monthly_income - new_monthly_expenses, 
                             sd = 500)),
    Savings1 = cumsum(Scenario1), 
    Total_Theory_Savings = Theory_Savings + Savings1) %>% View()

df[c(1,2)] %>% 
  mutate(Scenario = case_when(
    Date < new_date ~ as.numeric(0),
    Date >= new_date ~ (new_monthly_income - new_monthly_expenses)
  ), 
  new_savings = cumsum(Scenario), 
  total_saved = new_savings + Savings) %>% View()
  ggplot(aes(Date, total_saved, color = Scenario)) + 
  geom_line() + geom_point() 

ggplot(df, aes(Date, Total_Theory_Savings)) + 
  geom_smooth(method = "lm") +
  geom_point() + geom_line(aes(Date, Savings)) +
  geom_hline(yintercept = dp, lty = 3) +
  geom_hline(yintercept = current_savings, lty = 3) +
  geom_vline(xintercept = goal_purchase_date) + 
  scale_x_date(date_labels = "%b-%Y", breaks = goal_purchase_date) + 
  scale_y_continuous(labels=scales::dollar_format(), 
                     breaks = c(10000, 80000)) +
  theme_classic() 


