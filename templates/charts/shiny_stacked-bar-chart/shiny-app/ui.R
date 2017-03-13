## =============================== License ========================================
## ================================================================================
## This work is distributed under the CC0 1.0 Universal (CC0 1.0) license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

## ==== Packages to load for server

library(shiny) # Some advanced functionality depends on the shiny package being loaded client-side, including plot.ly
library(highcharter)
library(plotly)
library(shinyjs)

## ==== Global Variables (client-side)

shinyUI(navbarPage(
  "Stacked barcharts",
  tabPanel(
    "Visualisation",
    fluidPage(
      useShinyjs(),
      includeCSS("www/animate.min.css"),
      # provides pulsating effect
      includeCSS("www/loading-content.css"),
      uiOutput("url_allow_popout_UI"),
      fluidRow(column(
        selectInput(
          "selected_library",
          "Select visualisation library:",
          choices = c("highcharter", "plotly")
        ),
        width = 5
      ),
      column(
        selectInput(
          "stacking_type",
          "How to stack bars?",
          choices = list("Group (i.e. don't stack, make a separate bar for each subcategory)" = NA, "Stack (i.e. subcategories on top of one another, the length is the total number)" = "stack", "Percent (i.e. all bars are the same length, relative length of each subcategory shows the percentage of observations in that subcategory" = "percent"),
          width = "100%"
        ),
        width = 7
      )),
      selectInput(
        "category_column",
        "Category column (i.e. y-axis):",
        choices = c("country","activity"),
        width = "100%"
      ),
      div(
        id = "loading-content",
        class = "loading-content",
        h2(class = "animated infinite pulse", "Loading data...")
      ),
      uiOutput("oidnchart_ui")
    )
  ),
  tabPanel("About",
           includeMarkdown(knitr::knit("tab_about.Rmd"))),
  collapsible = T
))
