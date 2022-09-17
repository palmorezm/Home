
# Shiny Dashboard (by shinydashboard)


# Packages
library(shinydashboard)
library(shiny)
# library(remotes)
# remotes::install_github("rstudio/shinyuieditor")
library(gridlayout)
library(tidyverse)
library(lubridate)
library(scales)
library(flexdashboard)
library(shinythemes)
source("helper.R")

# --------- #
# Define UI #
# --------- #
header <- shinydashboard::dashboardHeader(title = "Home Savings")

sidebar <- shinydashboard::dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", tabName = "widgets", icon = icon("th"))
  )
)

body <- shinydashboard::dashboardBody(
  tabItems(
    tabItem(
      tabName = "dashboard",
      fluidRow(
        box(
          shinydashboard::valueBoxOutput(outputId = "homePrice", width = 3), 
          shinydashboard::valueBoxOutput(outputId = "downPayment", width = 3),
          shinydashboard::valueBoxOutput(outputId = "mortgageAmount", width = 3), 
          shinydashboard::valueBoxOutput(outputId = "monthlyPayment", width = 3),
          width = 12
        )
      ),
      fluidRow(
        box(
          title = "controls", 
          numericInput(
            inputId = "init_savings",
            label = "Current Savings",
            value = 1000L
          ),
          numericInput(
            inputId = "monthly_income",
            label = "Monthly Income (net)",
            value = 4290L
          ),
          numericInput(
            inputId = "expenses",
            label = "Monthly Expenses",
            value = 3241L
          ),
          dateRangeInput(
            inputId = "dates",
            label = "Date Range",
            format = "mm-dd-yyyy", 
            start = "2022-01-01",
            end = "2028-01-01"
          ), 
          numericInput(
            inputId = "yearly_income",
            label = "Yearly Income (gross)",
            value = 60000L
          ),
          sliderInput(
            inputId = "percent",
            label = "Down Payment %",
            min = 0L,
            max = 100L,
            value = 20L,
            width = "100%"
          ),
          numericInput(
            inputId = "term",
            label = "Loan Term (years)",
            value = 30L
          ),
          numericInput(
            inputId = "rate",
            label = "Interest Rate (%)",
            value = 4L
          ),
        width = 3),
        box(plotOutput(outputId = "linePlot", 
                       height = 650), width = 9), 
      )
    ),
    tabItem(
      tabName = "widgets", 
      h2("Tab for Widgets")
    )
  )
)

ui <- shinydashboard::dashboardPage(header = header, sidebar = sidebar, body = body, 
                                    skin = c("black"))

# ------------------- #
# Define Server Logic #
# ------------------- # 
server <- function(input, output, session) {
  
  output$linePlot <- renderPlot({
    # calculate savings from income and expenses
    savings <- monthly_savings(input$monthly_income, input$expenses)
    # create df from init_savings, savings, start_date, and end_date
    df <- create_savingsdf(init_savings = input$init_savings,
                           savings,
                           start_date = input$dates[1],
                           end_date = input$dates[2])
    # plot savings over date range
    ggplot(df, aes(x = Date, y = Savings, group = 1)) +
      geom_line(size = 2) + 
      scale_x_date(date_labels = "%b-%Y") + 
      scale_y_continuous(labels=scales::dollar_format()) + 
      theme_minimal()
  })
  
  output$homePrice <- renderValueBox({
    loan <- calculate_loan(input$yearly_income, input$rate, input$term)
    home_price <- calculate_home_price(loan)
    shinydashboard::valueBox(
      paste(scales::dollar(home_price, largest_with_cents = 100)), 
      subtitle = "Home Price",
      color = "blue", 
      width = 12
    )
  })
  
  output$downPayment <- renderValueBox({
    loan <- calculate_loan(input$yearly_income, input$rate, input$term)
    down_payment <- down_payment(loan, input$percent)
    shinydashboard::valueBox(
      scales::dollar(down_payment),
      subtitle = "Down Payment", 
      color = "yellow", 
      width = 12
    )
  })
  
  output$mortgageAmount <- renderValueBox({
    loan <- calculate_loan(input$yearly_income, input$rate, input$term)
    shinydashboard::valueBox(
      scales::dollar(loan),
      subtitle = "Mortage Amount",
      color = "orange",
      width = 12
    )
  })
  
  output$monthlyPayment <- renderValueBox({
    mortgage <- mortgage_payment(input$yearly_income)
    shinydashboard::valueBox(
      scales::dollar(mortgage),
      subtitle = "Monthly Payment",
      color = "aqua", 
      width = 12
    )
  })
}

shinyApp(ui, server)
