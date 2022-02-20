#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
# runExample("01_hello")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

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
