library(shiny)
library(flexdashboard)
library(shinydashboard)
library(scales)
library(tibble)

header <- dashboardHeader(title = "Home Savings")

sidebar <- dashboardSidebar(
  sidebarMenu(
    
    id = "tabs", width = 300,
    
    menuItem("Plot", tabName = "dashboard", icon = icon("list-ol"))
    
  )
)

body <- dashboardBody(
  
  tabItems(
    
    tabItem(tabName = "dashboard", titlePanel("Plot"), 
            
            fluidPage(
              
              column(2, 
                     
                     box(title = "Plot", width = 75, 
                         sliderInput(
                           inputId = 'aa', label = 'AA', 
                           value = 0.5 * 100, 
                           min = 0 * 100, 
                           max = 1 * 100, 
                           step = 1
                         ), 
                         
                         sliderInput(
                           inputId = 'bb', label = 'BB', 
                           value = 0.5 * 100, 
                           min = 0 * 100, 
                           max = 1 * 100, 
                           step = 1
                         ), 
                         
                         sliderInput(
                           inputId = 'cc', label = 'CC', 
                           value = 2.5, min = 1, max = 5, step = .15
                         ), 
                         
                         sliderInput(
                           inputId = 'dd', label = 'DD', 
                           value = 2.5, min = 1, max = 5, step = .15
                         )
                     )
              ), 
              
              column(8, 
                     shinydashboard::valueBoxOutput(outputId = "box1", width = 3), title = "boxs")
            )
    )
  )
)

ui <- dashboardPage(header, sidebar, body)

server <- function(input, output, session) {
  
  ac <- function(aa, bb, cc, dd) {
    (aa + cc) + (bb ^ dd)
  }
  
  reac_1 <- reactive({
    tibble(
      aa = input$aa, 
      bb = input$bb, 
      cc = input$cc, 
      dd = input$dd
    )
  })
  
  pred_1 <- reactive({
    temp <- reac_1()
    ac(
      aa = input$aa, 
      bb = input$bb, 
      cc = input$cc, 
      dd = input$dd
    )
  })
  
  output$box1 <- shinydashboard::renderValueBox(
    shinydashboard::valueBox(
      value = scales::number(x = pred_1() / 100, accuracy = 0.01), 
      subtitle =ifelse(test = pred_1() / 100 <= 2.33, yes = 'AAAAAAAAAA', 
                       ifelse(test = pred_1() / 100 <= 3.67, yes = 'BBBBBBBBB', 
                              no = 'CCCCCCCCCC')), 
      color = ifelse(test = pred_1() / 100 <= 2.33, yes = 'red', 
                     ifelse(test = pred_1() / 100 <= 3.67, yes = 'green', 
                            no = 'blue')), 
      icon = icon(ifelse(test = pred_1() / 100 <= 2.33, yes = 'fa-times-circle', 
                         ifelse(test = pred_1() / 100 <= 3.67, yes = 'fa-exclamation-circle', 
                                no = 'fa-check-circle')))
    )
  )
}

shinyApp(ui, server)