server <- function(input, output) {
  
  output$display <- renderText({
    paste("value = ", selectedImage (), selectedSize ())  
  })
  
  # As a reactive function here
  selectedImage <- reactive({
    paste0("img/img", input$select ,".jpg") #reactive value
  })
  
  # # As a normal function here
  # selectedImage <- function(){
  #   paste0("img", input$select ,".jpg") 
  # }
  
  selectedSize <- reactive({
    if(input$select == 0){
      print(", none")
    }
    else if(input$height <= 200){
      print(", small")
    }
    else if(input$height <= 599){
      print(", medium")
    }
    else{
      print(", large")
    }
  })
  
  #render UI here
  output$image <- renderUI({
    img(src = selectedImage (), height = input$height) #observer
    
  })
  
}
