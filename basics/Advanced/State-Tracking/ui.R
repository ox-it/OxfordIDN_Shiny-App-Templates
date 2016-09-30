library(shiny)
library(visNetwork)

shinyUI(fluidPage(
  uiOutput("reactive_output"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "colour_dontchange",
        label = "Colour (don't change click)",
        choices = c("red", "blue")
      ),
      selectInput(
        "shape_do_change",
        label = "shape (do change)",
        choices = c("circle", "square")
      ),
      selectInput(
        "focus_do_change",
        label = "foucs on node (do change)",
        choices = 1:8
      )
    ),
    mainPanel(visNetworkOutput("the_network"))
  ),
  conditionalPanel(
    "typeof input.current_node_id !== 'undefined'",
    verbatimTextOutput("selected_node")
    
  )
))