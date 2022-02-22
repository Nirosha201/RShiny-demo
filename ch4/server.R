# library(DT)
# library(readr)
# library(dplyr)
# library(gapminder)

server <- function(input, output) {
    # setwd("/cloud/project/challenge")
    
    # Set up your reactives to modify your data from reactive inputs here
    data <- reactive({
      inFile <- input$file1
      print("Hiiii")
      print(inFile)
      if (is.null(inFile)){
        return (NULL)
      }
      else{
        out <- read_csv(inFile$datapath) 
        print(summary(out))
        View(out)
        
        out <- filter(out, continent == input$cont  & lifeExp >= input$lifex)
        
        return (out)
      }
    })
    
    # countries <- reactive({
    #   countries <- unique(subset(gapminder, continent == input$cont)$country)
    #   return (countries)
    #   
    # })
    
    output$table_challenge <- DT::renderDataTable({
        # print(data ())
        datatable(data (), # replace mtcars with your data
                  options = list(scrollX = TRUE)
        )
    })
    
    # output$countries <- renderUI({
    #   list(countries ())
    # }
    # )
    
    # download csv
    output$dwl <- downloadHandler(
      filename = function(){
        return ('gapminder.csv')
      },
      content = function(file){
        write.csv(data (), file)
      }
    )
}