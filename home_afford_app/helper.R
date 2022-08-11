library(tidyverse)
library(lubridate)

# Calculate number of months
months_passed <- function(start_date, end_date) {
  num_months <- interval(start_date, end_date) %/% months(1)
  return(num_months)
}

# Calculate monthly savings
monthly_savings <- function(income, expenses) {
  savings <- income - expenses
  return(savings)
}

# Calculate total savings
calculate_savings <- function(init_savings, savings, start_date, end_date) {
  # initialize total_savings to init_savings
  total_savings <- init_savings
  # calculate num_months
  num_months <- months_passed(start_date, end_date)
  i <- num_months
  # add savings to total_savings for num_months
  while (i > 0) {
    total_savings <- total_savings + savings
    i <- i -1
  }
  return(total_savings)
}

# Create savings df
create_savingsdf <- function(init_savings, savings, start_date, end_date) {
  # initialize total_savings to init_savings
  total_savings <- init_savings
  # create df with column for savings
  df = data.frame(
    Savings = c(total_savings)
  )
  # calculate num_months
  num_months <- months_passed(start_date, end_date)
  # add savings to total_savings for num_months
  while (num_months > 0) {
    total_savings <- total_savings + savings
    num_months <- num_months - 1
    df = rbind(df, total_savings)
  }
  # add column for dates
  Date <- seq(as.Date(start_date), as.Date(end_date), by="month")
  df <- cbind(Date, df)
  return(df)
}

# Calculate monthly mortgage payment
mortgage_payment <- function(yearly_income) {
  monthly_income <- yearly_income / 12
  mortgage <- monthly_income * 0.28
  return(mortgage)
}

# Calculate loan amount
calculate_loan <- function(yearly_income, rate, term) {
  m <- mortgage_payment(yearly_income)
  i <- rate / 1200
  n <- term * 12
  loan <- m * ((1 + i) ^ n - 1) / (i * (1 + i) ^ n)
  return(loan)
}

# Calculate home price
calculate_home_price <- function(loan) {
  home_price <- loan / .8
  return(home_price)
}

# Calculate down payment
down_payment <- function(loan, percent) {
  down_payment <- calculate_home_price(loan) * percent / 100
  return(down_payment)
}

