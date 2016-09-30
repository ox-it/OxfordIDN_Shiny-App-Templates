library(shiny)
library(visNetwork)
library(shinyBS)

shinyUI(fluidPage(
  wellPanel("This is an app with a collapsible section that contains a colour legend"),
  uiOutput("some_svg"),
  bsCollapse(id = "collapseExample", open = NULL,
             bsCollapsePanel("Click to show/hide legend", uiOutput("colour_legend_ui"), style = "default")),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "shape",
        label = "shape (do change)",
        choices = c("circle", "square")
      ),
      selectInput(
        "focus",
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