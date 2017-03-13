

shinyServer(
  function(input, output){
    
    output$app_layout_UI <- renderUI({
      selectInput("app_layout", label = "App layout", choices = c("navbarPage", "singleFluidPage"), selected = "singleFluidPage")
    })

    
    
    layout_fn <- function(layout){
      print("layout_fn")
      switch(layout,
             "singleFluidPage" = {
               fluidPage(
                 uiOutput("app_layout_UI"),
                 h2("First section"),
                 stri_rand_lipsum(2),
                 h2("Second section"),
                 stri_rand_lipsum(2),
                 h2("Third section")
               )
             },
             "navbarPage" = {
               print("navbarPage")
               navbarPage(
                 "Layouts demo",
                 tabPanel("First Tab",
                          fluidPage(
                            uiOutput("app_layout_UI"),
                            stri_rand_lipsum(2)
                          )),
                 tabPanel("Second Tab",
                          fluidPage(
                            stri_rand_lipsum(2)
                          ))
               )
             }
             )
    }
    
    app_contents <- eventReactive(c(input$app_layout),
                                  {
                                    print("in app_contents before eval")
                                    layout_fn(input$app_layout)
                                  }, ignoreInit = FALSE)
    
    output$display_app_UI <- renderUI({
      
      if(is.null(input$app_layout)){
        layout_fn("navbarPage")
      } 
      
      app_contents()
      
      
    })
    
  }
)