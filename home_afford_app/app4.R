

source("helper.R")
library(shiny)
# library(remotes)
# remotes::install_github("rstudio/shinyuieditor")
library(gridlayout)
library(tidyverse)
library(lubridate)
library(scales)
library(flexdashboard)
library(shinydashboard)
library(shinythemes)

# Review
# https://rstudio.github.io/shinydashboard/structure.html#background-shiny-and-html

ui <- dashboardPage(
  dashboardHeader(title = "Home Savings"),
  dashboardSidebar(
    sidebarMenu(
      menuItemOutput("menuitem"),
      menuItemOutput("menuitem2")
    )
  ),
  dashboardBody()
)

server <- function(input, output) {
  output$menuitem <- renderMenu({
    menuItem("Menu item", icon = icon("calendar"))
  })
  output$menuitem <- renderMenu({
    menuItem("Menu item", icon = icon("calendar"))
  })
}

shinyApp(ui, server)