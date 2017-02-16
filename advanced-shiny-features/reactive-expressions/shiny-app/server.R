## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
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
    
    output$histogram_renderPlot <- renderPlot({
      hist_data <- rnorm(100, mean = input$mean, sd = 4)
      hist(hist_data,
           main = input$plot_label)
    })
    
    hist_data_eventReactive <- eventReactive(c(input$mean),
                                             {
                                               rnorm(100, mean = input$mean, sd = 4)
                                             })
    
    
    output$histogram_eventReactive <- renderPlot({
      ## hist_data_eventReactive is a reactive object and needs () to be called
      ## but this looks ugly, so it's nice to create a new variable that only 
      ## updates when the eventReactive expression is invalidated
      hist_data <- hist_data_eventReactive
      hist(hist_data,
           main = input$plot_label)
    })
    
  }
)