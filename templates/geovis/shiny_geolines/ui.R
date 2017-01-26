## =============================== License ========================================
## ================================================================================
## This work is distributed under the CC0 1.0 Universal (CC0 1.0) license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

## ==== Packages to load for server

library(shiny) # Some advanced functionality depends on the shiny package being loaded client-side, including plot.ly
library(leaflet)

## ==== Global Variables (client-side)

shinyUI(navbarPage(
  ## ==== Include google analytics code
  #  tags$head(includeScript("google-analytics.js")),
  "Geolines visualisations",
  tabPanel(
    "Visualisation",
    wellPanel(uiOutput("short_viz_description_UI")),
    fluidPage(
      ## url_allow_popout_UI MUST occur in first tabPanel
      uiOutput("url_allow_popout_UI"),
      fluidRow(column(
        selectInput(
          "selected_library",
          "Select visualisation library:",
          choices = c("leaflet")
        ),
        width = 3
      ),
      column(
        uiOutput("geo_lines_daterange_UI"), width = 9
      )),
      # leafletOutput("leaflet_map") 
      leafletOutput("geo_lines_map")
    )
  ),
  tabPanel("About",
           uiOutput("about_page_UI")),
  collapsible = T
))
