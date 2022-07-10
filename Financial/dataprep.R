
# Financial Data Prep 

# Packages
require(dplyr)
require(stringr)
require(ggplot2)

# Source
df <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vSNwyF0GHoS_VUYOzXkw4yWie44Zx_9rBJ5iXZesRgYpRcXnes8TMKWpIXyLs0YPEZcSp0E31BzAP6M/pub?gid=1021108104&single=true&output=csv")
df$Date <- as.Date(df$Date)
df$Cost <- as.numeric(stringr::str_remove_all(df$Cost, "\\$"))
df$Category <- as.factor(df$Category)
df$Account <- as.factor(df$Account)
df <- df %>% 
  dplyr::select("Location", "Date", "Description", 
                "Cost", "Category", "Account") 
df <- na.omit(df)


hist(df$Cost) # Needs to be fixed, current bin size is 0 - 50 with 800+ transactions
# as.Date.character() # Does this work to format the date or will we need to change the source data type? 
# Location - Should this be a factor data type with lots of levels? We shop at a lot of the same stores
# Category - needs an amount associated with each
# Amount - needs an amount associated with each and needs fixing (extra 11 transactions under Zach
#   would otherwise be unclassified)
# Big picture - what do we want to gain from this as a shiny?
#   Are there any particular questions that we ask each time we want to make a purchase that could save us money? 

plot(df)
summary(df)

df[which(is.na(df)),]



# Average expenses per month
April <- 2279.77
March <- 2634.28
February <- 4463.10
Statements <- data.frame(Month = c(February, March, April))
mean <- mean(Statements$Month)
median <- median(Statements$Month)



