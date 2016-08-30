library(shiny)
library(highcharter)
library(htmltools)

shinyUI(fillPage(
  theme = "young-lives.css",
  navbarPage(
    "Young Lives: Ethiopia",
    tabPanel(
      "Education Comparison",
      fluidPage(
        fluidRow(
          column(uiOutput("selected_category_UI"), width = 4),
          column(uiOutput("selected_measure_UI"), width = 4),
          column(uiOutput("selected_stacking_UI"), width = 4)
        ),
        highchartOutput("comparison_chart")
      )
    ),
    tabPanel("About",
             fluidPage("About")),
    collapsible = TRUE
  )
))