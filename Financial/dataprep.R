
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
plot(df)
