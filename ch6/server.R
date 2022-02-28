
library(shiny)
library(leaflet)
library(RColorBrewer)
library(spData)
library(sf)
library(dplyr)

shinyServer(function(input, output) {
  
  data("world")
  
  # Filter the data basaed on selected continent
  worldData <- reactive({
    dat <- world
    if (input$cont != "All"){
      dat <- filter(dat, continent == input$cont)
    }
    return (dat)
  })
  
  # Select what to draw
  type <- reactive({
    if (input$type == "gdp"){
      out = 1
    }
    else if(input$type == "life"){
      out = 2
    }
    else{
      out = 3
    }
    return (out)
  })
  
  # Create a continuous palette function
  pal <- reactive({
    data <- worldData ()
    if (type () == 1){
      colorNumeric(palette = "Greens",
                   domain = data$gdpPercap) 
    }
    else if (type () == 2){
      colorNumeric(palette = "Blues",
                   domain = data$lifeExp)
    }
    else{
      colorNumeric(palette = "Reds",
                   domain = data$pop)
    }
  })
    
  
  output$map <- renderLeaflet({
    leaflet() %>% addTiles() %>%
      addProviderTiles(providers$CartoDB.PositronNoLabels) #%>%
      # fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat)) # how to fit bounds?
  })
  
  observe({
    pal <- pal ()
    data = worldData ()
    proxy <- leafletProxy("map") %>%
      clearShapes()
    
    if (type () == 1){
      proxy %>%
        addPolygons(data = data, stroke = FALSE, smoothFactor = 0.1, fillOpacity = 1,
                    color = ~pal(gdpPercap)) 
    }
    else if(type () == 2){
      proxy %>%
        addPolygons(data = data, stroke = FALSE, smoothFactor = 0.1, fillOpacity = 1,
                    color = ~pal(lifeExp))
    }
    else{
        proxy %>%
          addPolygons(data = data,stroke = FALSE, smoothFactor = 0.1, fillOpacity = 1,
                      color = ~pal(pop)) 
    }
  })

  
})
