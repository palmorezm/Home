

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

ui <- dashboardPage(
  dashboardHeader(title = "Dynamic sidebar"),
  dashboardSidebar(
    sidebarMenu(
      menuItemOutput("menuitem")
    )
  ),
  dashboardBody()
)

server <- function(input, output) {
  output$menuitem <- renderMenu({
    menuItem("Menu item", icon = icon("calendar"))
  })
}

shinyApp(ui, server)