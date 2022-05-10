
# Questions: 
# What mortgage can I afford with [x] salary? 
# How much will a monthly payment on [x] mortgage be with a 30 year fixed interest rate? 

# Amortization schedule equation
# https://en.wikipedia.org/wiki/Amortization_calculator
# Google's calculator based on 36% debt-to-income ratio rule
# https://www.google.com/search?q=purchase+budget+mortgage+calculator+&rlz=1C1CHBF_enUS912US912&sxsrf=APq-WBuMyoeKRqMjgFcwClNiiA2VOZ4r8Q%3A1650593894466&ei=ZhBiYpaHHMeStAakqJLQDQ&ved=0ahUKEwiW0v21zab3AhVHCc0KHSSUBNoQ4dUDCA4&uact=5&oq=purchase+budget+mortgage+calculator+&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBggAEBYQHjIFCAAQhgM6BwgjELADECc6BwgAEEcQsAM6CAgAEJECEIsDOhQILhCABBCxAxCDARDHARDRAxCLAzoRCC4QsQMQgwEQxwEQowIQiwM6EQguEIAEELEDEMcBEKMCEIsDOg4IABCABBCxAxCDARCLAzoHCAAQQxCLAzoFCAAQkQI6BAgAEEM6CgguEMcBEKMCEEM6DQguELEDEMcBEKMCEEM6EAgAEIAEEIcCELEDEIMBEBQ6DgguEIAEELEDENQCEIsDOgcIABCxAxBDOgoIABCxAxBDEIsDSgQIQRgASgQIRhgAUJsJWJ0sYI8uaAVwAXgAgAF-iAH1DJIBBDEyLjaYAQCgAQHIAQm4AQLAAQE&sclient=gws-wiz 

# Interest Rates came from:
# https://fred.stlouisfed.org/series/MORTGAGE30US


require(dplyr)

# Smaller, more recent dataset
# df <- data.frame(readxl::read_xlsx("Data/mortgage_rates_30yr_fixed.xlsx"))
# Data from 1971-04-02 until 2022-04-21
df <- read.csv("Data/MORTGAGE30US.csv")
term <- 30 # Length of loan (Must be 30 year fixed for these rates)
mortgage_amount <- 100000
down_payment <- 20000

# For smaller dataset only
# df %>%
#   transmute(Rate = as.numeric(Rate), 
#             Pts = as.numeric(Pts), 
#             Year = as.integer(Year), 
#             Month = as.factor(Month)) %>% 
#   mutate(number_payments = t * 12, 
#          interest = )
  

df <- df %>% 
  transmute(Date = as.Date(DATE),
    APRYR30 = MORTGAGE30US) %>% 
  mutate(n = term * 12, 
         rec_down_payment = mortgage_amount * 0.20, 
         actual_down_payment = down_payment, 
         net_principal = mortgage_amount - actual_down_payment, 
         monthly_ir = (APRYR30/100)/12, 
         monthy_payment = net_principal*(((monthly_ir * (1 + monthly_ir)^n))/((1+monthly_ir)^n)) 
         # numerator = principal * ( (IRYR30 * (1 + IRYR30)^n) /
         #                         (1 + IRYR30)^n -1)
         )

save(df, file= "Data/app.Rdata")


df %>% 
  filter(Date > "1971-04-02" & Date < "1971-08-02") %>%
  ggplot(aes(Date, APRYR30)) + geom_line()






