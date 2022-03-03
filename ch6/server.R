
library(shiny)
library(leaflet)
library(RColorBrewer)
library(spData)
# library(spDataLarge)
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
      addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
      setView(-10.0382679, 42.3489054, zoom = 2.4)
  })
  
  observe({
    pal <- pal ()
    data = worldData ()
    proxy <- leafletProxy("map") %>%
      clearShapes()
    
    if (type () == 1){
      proxy %>%
        addPolygons(data = data, stroke = FALSE, smoothFactor = 0.1, fillOpacity = 1,
                    color = ~pal(gdpPercap), layerId = 1) 
    }
    else if(type () == 2){
      proxy %>%
        addPolygons(data = data, stroke = FALSE, smoothFactor = 0.1, fillOpacity = 1,
                    color = ~pal(lifeExp), layerId = 2)
    }
    else{
        proxy %>%
          addPolygons(data = data,stroke = FALSE, smoothFactor = 0.1, fillOpacity = 1,
                      color = ~pal(pop), layerId = 3) 
    }
  })
  
  # ledgend
  observe({
    pal <- pal ()
    data = worldData ()
    
    proxy <- leafletProxy("map", data = data) 
    
    proxy %>%
      clearControls()
    
    if (input$leg) {
      if (type () == 1){
        proxy %>%
          addLegend(position = "bottomright", pal = pal, values = ~gdpPercap)
      }
      else if(type () == 2){
        proxy %>%
        addLegend(position = "bottomright", pal = pal, values = ~lifeExp)
      }
      else{
        proxy %>%
        addLegend(position = "bottomright", pal = pal, values = ~pop)
      }
    }
    
  })
  
  # # mouseover popup
  # inShape <- reactiveVal(FALSE)
  # oldLoc <- reactiveValues(lat=NULL,lng=NULL)
  # 
  # observeEvent(input$map_shape_mouseout$id, {
  #   map_shape_mouseover_info <- input$map_shape_mouseover
  #   map_shape_mouseover_info_old <- reactiveValuesToList(oldLoc)
  #   if (all(unlist(map_shape_mouseover_info[c('lat','lng')]) == unlist(map_shape_mouseover_info_old[c('lat','lng')]))){
  #     inShape(FALSE)
  #     
  #     # rv_location$lat <- 'not tracked (outside of the state)'
  #     # rv_location$lng <- 'not tracked (outside of the state)'
  #     leafletProxy("map") %>%
  #       clearPopups()
  #   }
  #   # else{
  #   #   rv_location_move_old$lat <- map_land_shape_mouseover_info$lat
  #   #   rv_location_move_old$lng <- map_land_shape_mouseover_info$lng
  #   # }
  #   
  #   
  #   # leafletProxy("map") %>%
  #   #   clearPopups()
  # })
  # 
  # observeEvent(input$map_shape_mouseover$id, {
  #   inShape(TRUE)
  #   loc <- input$map_shape_mouseover
  #   
  #   id <- loc$id
  #   lat <- round(loc$lat, 4)
  #   lng <- round(loc$lng, 4)
  #   print("**")
  #   print(loc)
  #   # oldLoc(lat, lng)
  # 
  #   leafletProxy("map") %>% addPopups(lat = lat, lng = lng, "Hello", options = popupOptions(closeButton = FALSE), layerId = id)
  # })

})
