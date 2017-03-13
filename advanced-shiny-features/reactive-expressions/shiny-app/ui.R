## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

library(shinyjs)

shinyUI(navbarPage(
  "Reactive Expressions",
  tabPanel("Visualisation",
           fluidPage(
             wellPanel(
               "This template shows how eventReactive is incredibly important for controlling the update order of expressions.",
               br(),
               "Typing text into the input field will modify the title of the two histograms, but the one on the left will generate new data while you type.",
               br(),
                 "Clearly, this is undesireable behaviour. In the server.R file the control logic using eventReactive should be obvious.",
               br(),
                 a(
                   href = "https://martinjhnhadley.github.io/OxfordIDN_Shiny-App-Templates/advanced-shiny-features/reactive-expressions/",
                   "See here for a tutorial on this subject.",
                   target = "_blank"
                 ),
               sliderInput(
                 "mean",
                 "Mean of data displayed in histogram",
                 min = 0,
                 max = 5,
                 value = 1
               ),
               textInput("plot_label", label = "Label for histogram")
             ),
             
             fluidRow(
               column(
                 "Uncontrolled updating",
                 plotOutput("histogram_renderPlot"),
                 width = 6
               ),
               column(
                 "Controlled updating",
                 plotOutput("histogram_eventReactive"),
                 width = 6
               ),
               responsive = FALSE
             )
             
           )),
  tabPanel("About",
           includeMarkdown(knitr::knit("tab_about.Rmd"))),
  collapsible = TRUE
))
