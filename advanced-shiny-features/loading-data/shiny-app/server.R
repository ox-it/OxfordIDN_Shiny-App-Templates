## =============================== License ========================================
## ================================================================================
## This work is distributed under a CC0 license.
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

## ==== Packages to load for server
## ==== Note some packages may be loaded within data-processing, i.e. tidyverse
library(shiny) # Some advanced functionality depends on the shiny package being loaded server-side
library(shinyjs)
library(ggplot2)

shinyServer(
  function(input, output, session){
    
    output$chart <- renderPlot({
      
      input$reload # trigger a reload
      
      show("loading-content") # make the loading pane appear
      
      Sys.sleep(2)
      
      g <- ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length)) + geom_point()
      
      hide("loading-content") # make the loading pane disappear
      
      g # display the output after hiding it
      
    })
    
  }
)