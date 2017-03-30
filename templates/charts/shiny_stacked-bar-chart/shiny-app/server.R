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
library(highcharter)
library(plotly)
library(oidnChaRts) # devtools::install_github("ox-it/oidnChaRts")
library(dplyr)
library(shinyjs)

## ==== Load data/functions globally
source("data-processing.R", local = TRUE)

## ==== Load beautification, palettes etc, globally
source("beautification.R", local = TRUE)

shinyServer(function(input, output, session) {
  ## ==== Check URL for allowPopout
  source("url_allowPopout.R", local = TRUE)$value
  
  ## ==== About Page
  output$about_page_UI <- renderUI({
    includeHTML(knitr::knit("About_Page.Rmd"))
  })
  
  ## ==== Viz Page
  
  output$category_column_UI <- renderUI({
    selectInput(
      "category_column",
      "Category column (i.e. y-axis):",
      choices = category_columns,
      width = "100%"
    )
    
  })

  output$plotly_oidnchart <- renderPlotly({
    
    if(input$selected_library != "plotly"){
      return()
    }
    
    show("loading-content")
    
    plotly_chart <- stacked_bar_chart(
      business_trips,
      library = input$selected_library,
      categories.column = as.formula(paste0("~",input$category_column)),
      value.column = ~ hours,
      subcategories.column = as.formula(paste0("~",setdiff(c("country","activity"), input$category_column))),
      stacking.type = ifelse(input$stacking_type == "NA", NA, input$stacking_type)
    )
    
    hide("loading-content")
    
    plotly_chart
    
  })
  
  output$highcharter_oidnchart <- renderHighchart({

    if(input$selected_library != "highcharter"){
      return()
    }
    
    show("loading-content")
    
    highcharter_chart <- stacked_bar_chart(
      business_trips,
      library = input$selected_library,
      categories.column = as.formula(paste0("~",input$category_column)),
      value.column = ~ hours,
      subcategories.column = as.formula(paste0("~",setdiff(c("country","activity"), input$category_column))),
      stacking.type = ifelse(input$stacking_type == "NA", NA, input$stacking_type)
    )
    
    hide("loading-content")
    
    highcharter_chart
    
  })
  
  output$oidnchart_ui <- renderUI({
    switch(input$selected_library,
           "plotly" = {
             plotlyOutput("plotly_oidnchart")
           },
           "highcharter" = {
             highchartOutput("highcharter_oidnchart")
           })
  })
  
  
})
