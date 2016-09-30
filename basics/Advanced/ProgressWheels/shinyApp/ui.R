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
library(shinyjs)

## ==== Global Variables (client-side)

shinyUI(
  fluidPage(
    useShinyjs(),
    inlineCSS(appCSS),
    navbarPage(

    ## ==== Include google analytics code
      #  tags$head(includeScript("google-analytics.js")),
    "Name of App",
    tabPanel("Visualisation",
             div(
               id = "loading-content",
               h2("Loading the shiny app...")
             ),
             wellPanel(uiOutput("short_viz_description_UI")),
             fluidPage(
               ## url_allow_popout_UI must occur in first tabPanel
               uiOutput("url_allow_popout_UI"),
               uiOutput("selected_categories_UI"),
               leafletOutput("leaflet_map")
             )),
    tabPanel("About",
             # includeHTML(knitr::knit(
             #   "App_Description.Rmd"
             # ))),
             uiOutput("about_page_UI")),
    collapsible = T
  )))
