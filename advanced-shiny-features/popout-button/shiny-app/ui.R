## =============================== License ========================================
## ================================================================================
## This work is distributed under the CC0 1.0 Universal (CC0 1.0) license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

library(stringi)

shinyUI(navbarPage(
  "Name of App",
  tabPanel("Visualisation",
           fluidPage(
             ## url_allow_popout_UI MUST occur in first tabPanel
             uiOutput("url_allow_popout_UI"),
             plotOutput("chart")
           )),
  tabPanel("About",
           fluidPage(
             ## generate random text for something to look at
             HTML(paste(stri_rand_lipsum(5), collapse = "<br/>"))
           )),
  ## collapses the menu bar into a "hamburger" when the window is narrower than 768px
  ## see https://shiny.rstudio.com/articles/layout-guide.html for more info
  collapsible = TRUE
))
