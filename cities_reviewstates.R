
# Review Cities List
# Home 

library(dplyr)
library(ggplot2)

cities <- read.csv("https://raw.githubusercontent.com/melanieriley/Home/master/cities.csv", skip = 1)
cities$State <- as.factor(cities$State)
state.tbl <- cities %>%
  group_by(State) %>% 
  summarise(n = n())

ggplot(state.tbl, aes(reorder(State, -n), n, fill = n)) + geom_col() + coord_flip()

