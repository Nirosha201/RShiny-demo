#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fixedPage(
  
  fluidRow(
    column(12, tags$img(src="img/img1.jpg", width="100%"))),
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  # titlePanel(h3("Old Faithful Geyser Data")),
  
  # Fluid row
  fluidRow(
    column(4, (
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    )
    ),

    # Show a plot of the generated distribution
    column(8, (
      tabsetPanel(
        tabPanel("Plot",
          plotOutput("distPlot")
        ),
        tabPanel("Plot2",
                 plotOutput("distPlot2")
        ))
    )
    )
  ),
  
  fluidRow(column(4, "Nirosha"),
           column(4, tags$a(href="a@b.com", "email")),
           column(4, tags$a(href="https://epi-interactive.com/", "home", target="_blank"))
  )
)
