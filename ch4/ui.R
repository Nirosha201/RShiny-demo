library(shiny)
library(DT)

ui <- fluidPage(

    # Application title
    titlePanel("Practising with data sources and processing - challenge"),

    fluidRow(
        column(4, 
               wellPanel(
                 fileInput(inputId = "file1", 
                           label = "Upload data",
                           multiple = FALSE,
                           accept = c("text/csv",
                                      "text/comma-separated-values,text/plain",
                                      ".csv"),
                           placeholder = "upload your file",
                           buttonLabel = "Browse data"),
                 selectInput("cont", "Continent", choices = unique(gapminder$continent)),
                 uiOutput("country"),
                 sliderInput("lifex", "Life expectancy", min=floor(min(gapminder$lifeExp)), max = ceiling(max(gapminder$lifeExp)), value=quantile(gapminder$lifeExp)[1], post = " yrs", round = TRUE),
                 tags$hr(style="border-color: grey;"),
                 downloadLink("dwl", "Download as csv")
               )
        ),
        column(8, 
               wellPanel(
                   DT::dataTableOutput("table_challenge")
               )
        )
    )
)