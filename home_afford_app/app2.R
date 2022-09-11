
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

ui <- navbarPage(
  "Home Savings", 
  theme = shinytheme("cosmo"), 
  # header = "Header Section for all Tabs in Navbar",
  tabPanel(
    title = "Plot", 
      # column(c(4, 8), 
      #        Title = "Selection Options"),
      sidebarPanel(
      h3("Heading 3"),
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
        )
      ),
      mainPanel("Main1", 
                plotOutput(outputId = "linePlot"))
    ), # End Tab 1
  tabPanel(
    title = "Key", 
    fluidPage(
    sidebarPanel(
      h3("Heading 3"),
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
      )
    ),
    mainPanel("Main2", 
              textOutput(outputId = "homeAmount")),
    )
  ),
  tabPanel(
    "Name Card",
    box(title = "Home Price",
        footer = "Footer here", 
        background = "aqua", collapsible = FALSE)
    ), 
    valueBox(value = "$367,900", subtitle = "subtitle", color="aqua")
  ) 

  
  
  
  # Define server logic required to draw a histogram
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
    
    output$homeAmount <- renderText({
      # calculate how much home you can afford based on inputs
      mortgage <- mortgage_payment(input$yearly_income)
      loan <- calculate_loan(input$yearly_income, input$rate, input$term)
      home_price <- calculate_home_price(loan)
      down_payment <- down_payment(loan, input$percent)
      # display results
      homePrice <- paste("Home Price: ", dollar(home_price, largest_with_cents = 100))
      downPayment <- paste("Down Payment: ", dollar(down_payment, largest_with_cents = 100))
      mortgageAmount <- paste("Mortgage Amount: ", dollar(loan, largest_with_cents = 100))
      monthlyPayment <- paste("Monthly Payment: ", dollar(mortgage, largest_with_cents = 100))
      paste(homePrice, downPayment, mortgageAmount, monthlyPayment, sep="\n")
    })
    
    # output$PriceofHome <- renderText(expr = "$367,924")
    output$PriceofHome <- shinydashboard::renderValueBox(
      shinydashboard::valueBox(value = "$367,924", 
                               title = "Title",
                               subtitle = "Home Price", 
                               icon = NULL, 
                               color = "aqua")
    )
    
    output$box1 <- renderValueBox(
      expr = valueBox(
        value = scales::number(x = 100*10000),
        subtitle = "subtitle",
        icon = NULL
      )
    )
  }

shinyApp(ui, server)
