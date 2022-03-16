
# Financial Data Prep 

# Packages
require(dplyr)
require(stringr)

# Source
df <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vSNwyF0GHoS_VUYOzXkw4yWie44Zx_9rBJ5iXZesRgYpRcXnes8TMKWpIXyLs0YPEZcSp0E31BzAP6M/pub?gid=1021108104&single=true&output=csv")
sapply(df[1:8], class())

df$Date <- as.Date(df$Date)
df$Cost <- as.numeric(stringr::str_remove_all(df$Cost, "\\$"))
# Alternative for cost
# df %>%
#   mutate(across(starts_with("Cost"), ~gsub("\\$", "", .) %>% as.numeric)) 
df$Category <- as.factor(df$Category)
df$Account <- as.factor(df$Account)
df <- df %>% 
  dplyr::select("Location", "Date", "Description", 
                "Cost", "Category", "Account") 
summary(df)

hist(df$Cost) # Needs to be fixed, current bin size is 0 - 50 with 800+ transactions
as.Date.character() # Does this work to format the date or will we need to change the source data type? 
# Location - Should this be a factor data type with lots of levels? We shop at a lot of the same stores
# Category - needs an amount associated with each
# Amount - needs an amount associated with each and needs fixing (extra 11 transactions under Zach
#   would otherwise be unclassified)
# Big picture - what do we want to gain from this as a shiny?
#   Are there any particular questions that we ask each time we want to make a purchase that could save us money? 

