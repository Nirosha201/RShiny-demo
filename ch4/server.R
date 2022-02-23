server <- function(input, output) {

    # create a dropdown list - country
    countries <- eventReactive(input$cont, {
      x <-subset(gapminder, continent == input$cont)
      x$country <- factor(x$country)
      y <-  unique(x$country)
      return(y)

    })
    
    output$country <- renderUI({
      selectInput("country", "Country", choices = countries ())
    })
    
    # prepare output table
    data <- reactive({
      inFile <- input$file1
      if (is.null(inFile)){
        return (NULL)
      }
      else{
        out <- read_csv(inFile$datapath)

        out <- filter(out, continent == input$cont  & country == input$country & lifeExp >= input$lifex)

        return (out)
      }
    })

    output$table_challenge <- DT::renderDataTable({
        datatable(data (), # replace mtcars with your data
                  options = list(scrollX = TRUE)
        )
    })

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