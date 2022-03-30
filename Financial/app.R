

# Financial App 

require(shiny)
require(tidyverse)


colors <- data.frame(list(c("light blue", "white", "green", "light green", "grey", "black", "pink", "yellow", "orange", "purple", "black")))
colnames(colors) <- "col"

ui <- fluidPage(
  fluidRow(
    column(12,
           selectizeInput(
             inputId = "category", 
             label = "Category:", 
             choices = unique(df$Category), 
             selected = "bread", 
             multiple = T), 
           selectizeInput(
             inputId = "fillcolor", 
             label = "Choose Color:", 
             choices = unique(colors$col), 
             selected = "light blue", 
             multiple = F),
           selectizeInput(
             inputId = "histcolor", 
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
             value = 0.5, 
             step = 0.25,
             ticks = T),
           plotOutput(outputId = "Plot1" 
                        # height = "1000px", 
                        # width = "1600px"
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
      filter(Category == input$category) %>% 
      ggplot(aes(Cost)) + 
      geom_histogram(fill = input$fillcolor, col = input$histcolor, alpha = input$alpha) +
      theme_function()
  })
  
}

shiny::shinyApp(ui, server)

