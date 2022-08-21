library(tidyverse)
library(lubridate)
source("home_afford_app/helper.R")

init_savings <- 29000
savings <- monthly_savings(4052.46, 2800)
start_date <- '2022-02-01'
end_date <- '2026-02-01'

total_savings <- calculate_savings(init_savings, savings, start_date, end_date)
total_savings

df <- create_savingsdf(init_savings, savings, start_date, end_date)
df
df %>% ggplot(., aes(Date, Savings)) +
  geom_line() + scale_x_date(date_labels = "%b-%Y")

yearly_income <- 75108.80
rate <- 4
term <- 30
percent <- 20

mortgage <- mortgage_payment(yearly_income)
loan <- calculate_loan(yearly_income, rate, term)

home_price <- calculate_home_price(loan)
down_payment <- down_payment(loan, percent)


