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

shinyUI(
  navbarPage(
    "Name of App",
    tabPanel("Visualisation",
             wellPanel(uiOutput("short_viz_description_UI")),
             fluidPage(
               uiOutput("url_allow_popout_UI"), ## url_allow_popout_UI MUST occur in first tabPanel
               uiOutput("selected_categories_UI"),
               leafletOutput("leaflet_map")
             )),
    tabPanel("About",
             uiOutput("about_page_UI")),
    collapsible = T
  ))
