library(shiny)

# Define UI for app that draws a histogram ----
ui <- shinyUI(fluidPage(
    
    # Application title
    titlePanel("Old Faithful Geyser Data - Yellowstone National Park, Wyoming"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("distPlot")
      ),
      sidebarPanel(
        sliderInput(inputId = "bins",
                    label = "Resolution:",
                    min = 1,
                    max = 50,
                    value = 30,
                    # value = c(20, 40), # double-ended range slider, won't suit here
                    width = '90%')
      )
    )
  ))

# Define server logic required to draw a histogram ----
server <- shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgreen', border = 'white', 
         xlab = "Waiting time between eruptions", 
         ylab = "Number of eruptions",
         main = "Distribution of waiting time")
    
  })
  
})


shinyApp(ui = ui, server = server)