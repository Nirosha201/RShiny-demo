library(shiny)
# library(install.packages("plotly"))


shinyServer(function(input, output) {
  # Insert plotly server code here #
  # View(iris)
  iris$sp <- as.numeric(iris$Species)
  
  x <- list(title = "Sepal length")
  y <- list(title = "Petal length")
  l <- list(
    orientation = "v", 
    font = list( 
      family = "sans-serif",
      size = 14,
      color = "#000"),
    bgcolor = "#F5F5F5",
    bordercolor = "#000",
    borderwidth = 2
  )
  
  
  output$plot <- renderPlotly({
    custom.colors <- c("red", "orange", "yellow")
    plot_ly(data = iris,
            x = ~Sepal.Length,
            y = ~Petal.Length,
            color = ~Species,
            colors = custom.colors,
            text = ~Species,
            hovertemplate = paste0("<b>Species: %{text}</b><br>" ,
                                   "<i>Sepal.Length: %{x:.1f}</i><br>",
                                   "<i>Petal.Length: %{y:.1f}</i>",
                                   "<extra></extra>")
  ) %>%
      # layout(hovermode = "y unified x unified") %>%
      layout(title="Iris flowers", xaxis = x, yaxis = y, legend = l)
  })
})
