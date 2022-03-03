
library(shiny)
library(leaflet)

shinyUI(
  
  bootstrapPage(
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    leafletOutput("map", width = "100%", height = "100%"),
    
    absolutePanel(top = 10, right = 10,
                  wellPanel(
                    h4("Challenge"),
                    selectInput('cont', tags$i("Continent"), choices = append("All", unique(world$continent)), multiple = FALSE, width = "200px"),
                    radioButtons('type', tags$i("Filter by"), choiceNames = list("GDP per capita", "Life expectancy", "Population"), choiceValues = list("gdp", "life", "population")),
                    checkboxInput("leg", "Show legend", value = TRUE)
                    )
                  )
    )
  )