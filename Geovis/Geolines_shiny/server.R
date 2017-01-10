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
library(leaflet)
library(oidnChaRts) # devtools::install_github("martinjhnhadley/oidnChaRts")
library(geosphere) # required for geo_lines_map
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
  
  ## ==== Short Viz Description
  output$short_viz_description_UI <- renderUI({
    includeHTML(knitr::knit("Short_Viz_Description.Rmd"))
  })
  
  ## ==== Viz Page
  output$geo_lines_daterange_UI <- renderUI(
    sliderInput(
      "geo_lines_daterange",
      "Filter journeys between dates:",
      min = min(journeys$date),
      max = max(journeys$date),
      value = c(min(journeys$date), max(journeys$date)),
      width = "100%"
    )
  )
  
  filtered_journeys <- eventReactive(
    input$geo_lines_daterange,
    journeys %>%
      filter(date >= input$geo_lines_daterange[1] &
               date <= input$geo_lines_daterange[2])
  )
  
  output$geo_lines_map <- renderLeaflet({
    
    filtered_journeys <- filtered_journeys() # eventReactive must be called as an object, repeated () are unsightly
    
    filtered_journeys %>%
    geo_lines_map()
    
    
  })
  
  # 
  # output$leaflet_map <- renderLeaflet({
  #   leaflet(leaflet_map_data()) %>%
  #     addTiles() %>%
  #     addCircleMarkers(color = ~ palette(type))
  # })
  
})
