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
library(oidnChaRts) # devtools::install_github("martinjhnhadley/oidnChaRts")
library(dplyr)

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
  
  output$subcategory_column_UI <- renderUI({
    selectInput(
      "subcategory_column",
      "Subcategory column (i.e. what individual bars represent):",
      choices = category_columns[!match(as.character(category_columns),
                                        input$category_column,
                                        nomatch = FALSE)],
      width = "100%"
    )
    
  })
  
  oidnchart_call <- eventReactive(
    c(input$stacking_type, input$selected_library, input$category_column, input$subcategory_column),
    {
      if(input$subcategory_column == input$category_column){
        return() # for a moment, the two inputs are equal switching. This prevents errors.
      }
      stacked_bar_chart(
        business_trips,
        library = input$selected_library,
        categories.column = as.formula(paste0("~",input$category_column)),
        value.column = ~ hours,
        subcategories.column = as.formula(paste0("~",input$subcategory_column)),
        stacking.type = ifelse(input$stacking_type == "NA", NA, input$stacking_type)
      )
    }, ignoreNULL = F
  )
  
  
  output$plotly_oidnchart <- renderPlotly(if (input$selected_library == "plotly") {
    oidnchart_call()
  } else {
    return()
  })
  
  output$highcharter_oidnchart <- renderHighchart(if (input$selected_library == "highcharter") {
    oidnchart_call()
  } else {
    return()
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
