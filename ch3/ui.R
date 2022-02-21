library(shiny)

ui <- fluidPage(
  titlePanel("Reactive values"),
  sidebarLayout(
    sidebarPanel(
      selectInput("select", 
	        "Choose one:", 
          choices = list("None" = "0", "Rabbit" = "1", "Fish" = "2", "Cat" = "3")
	    ),
      
      sliderInput("height", "Image height", min = 1, max = 1000, value = 200),
      
      textOutput("display")
      
    ),
    mainPanel(
      #add ui output here
      uiOutput("image")
    )
  ))