
# Amortization Calculator

require(shiny)
require(dplyr)
require(ggplot2)

# df %>% 
#   ggplot(aes(Date, APRYR30)) + geom_line()

# dateRangeInput() ? 
# df %>% 
#   filter(Date == "") %>% 
#   ggplot(aes(Date, APRYR30)) + 
#   geom_line(fill = input$fillcolor, col = input$histcolor, alpha = input$alpha) +
#   theme_function()

colors <- data.frame(list(c("light blue", "white", "green", "light green", "grey", "black", "pink", "yellow", "orange", "purple", "black")))
colnames(colors) <- "col"

ui <- fluidPage(
  fluidRow(
    column(12,
           dateRangeInput(
             inputId = "DateSelection",
             label = "Dates",
             start = "1971-04-02",
             end = "1971-06-21",
             min = "1971-04-02",
             max = "2022-04-21",
             format = "yyyy-mm-dd",
             startview = "month",
             weekstart = 0,
             language = "en",
             separator = " to ",
             width = NULL,
             autoclose = TRUE
           ),
           sliderInput("DateSelected",
                       "Dates:",
                       min = as.Date("1971-04-02","%Y-%m-%d"),
                       max = as.Date("2022-01-01","%Y-%m-%d"),
                       value=as.Date("1971-04-02"),
                       timeFormat="%Y-%m-%d"),
           selectizeInput(
             inputId = "fillcolor", 
             label = "Choose Color:", 
             choices = unique(colors$col), 
             selected = "light blue", 
             multiple = F),
           selectizeInput(
             inputId = "plotcolor", 
             label = "Choose Color:", 
             choices = unique(colors$col), 
             selected = "light blue", 
             multiple = F),
           selectizeInput(
             inputId = "plottheme", 
             label = "Choose Theme", 
             choices = c("Minimal", "BW", "Classic"),
             selected = "Classic",
             multiple = F),
           sliderInput(
             inputId = "alpha", 
             label = "Alpha", 
             min = 0, 
             max = 1,
             value = 0.95, 
             step = 0.05,
             ticks = T),
           plotOutput(outputId = "Plot1" 
                      # height = "1000px", 
                      # width = "1600px"
           ),
           plotOutput(
             outputId = "Plot2"
           )
    ))
)

server <- function(input, output){
  
  output$Plot1 <- renderPlot({
    
    theme_function <- switch(input$plottheme,
                             Minimal = theme_minimal,
                             BW = theme_bw,
                             Classic = theme_classic)
    
    df %>% 
      ggplot(aes(Date, APRYR30)) + 
      geom_line(col = input$plotcolor, alpha = input$alpha) +
      theme_function()
  })
  
  output$Plot2 <- renderPlot({
    
    theme_function <- switch(input$plottheme,
                             Minimal = theme_minimal,
                             BW = theme_bw,
                             Classic = theme_classic)
    
    df %>% 
      ggplot(aes(Date, APRYR30)) + 
      geom_line(col = input$plotcolor, alpha = input$alpha) +
      theme_function()
  })
  
}



shiny::shinyApp(ui, server)
