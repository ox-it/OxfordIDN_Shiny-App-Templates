## =============================== License ========================================
## ================================================================================
## This work is distributed under the CC0 1.0 Universal (CC0 1.0) license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

## ==== CSS

appCSS <- "
#loading-content {
position: absolute;
background: #000000;
opacity: 0.9;
z-index: 100;
left: 0;
right: 0;
height: 100%;
text-align: center;
color: #FFFFFF;
}
"

## ==== Packages to load for server
## ==== Note some packages may be loaded within data-processing, i.e. tidyverse
library(shiny) # Some advanced functionality depends on the shiny package being loaded server-side
library(leaflet)
library(shinyjs)

## ==== Load data/functions globally
source("data-processing.R", local = TRUE)

## ==== Load beautification, palettes etc, globally
source("beautification.R", local = TRUE)

shinyServer(function(input, output, session) {
  ## ==== About Page
  output$about_page_UI <- renderUI({
    includeHTML(knitr::knit("About_Page.Rmd"))
  })
  
  ## ==== Short Viz Description
  output$short_viz_description_UI <- renderUI({
    includeHTML(knitr::knit("Short_Viz_Description.Rmd"))
  })
  
  ## ==== Viz Page
  output$selected_categories_UI <- renderUI(
    selectInput(
      "selected_categories",
      "Selected Categories",
      choices = locations$type,
      selected = locations$type,
      multiple = T,
      width = "100%"
    )
  )
  
  leaflet_map_data <- eventReactive(
    input$selected_categories,
    locations %>%
      filter(type %in% input$selected_categories),
    ignoreNULL = TRUE
  )
  
  output$leaflet_map <- renderLeaflet({
    leaflet(leaflet_map_data()) %>%
      addTiles() %>%
      addCircleMarkers(color = ~ palette(type))
  })
  
  ## ==== Check URL for allowPopout
  source("url_allowPopout.R", local = TRUE)$value
  
  Sys.sleep(5)
  
  ## Hide loading screen, from https://github.com/daattali/shiny-server/blob/master/loading-screen/app.R
  hide(id = "loading-content", anim = TRUE, animType = "fade")  
  
})
