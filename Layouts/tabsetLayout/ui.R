## ==== Packages to load for server

library(shiny) # Some advanced functionality depends on the shiny package being loaded client-side, including plot.ly

## ==== Global Variables (client-side)

library(shinythemes) # Template uses the cerulean theme as it is pretty

shinyUI(fluidPage(
  ## ==== Include google analytics code
  #  tags$head(includeScript("google-analytics.js")),
  
  ## ==== Automatically include vertical scrollbar
  ## ==== This prevents the app from reloading content when the window is resized which would otherwise result in the
  ## ==== appearance of the scrollbar and the reloading of content. Note that "click data" may still be lost during
  ## ==== resizing, as discussed here https://github.com/rstudio/shiny/issues/937
  tags$style(type = "text/css", "body { overflow-y: scroll; }"),
  
  theme = shinytheme("cerulean"),
  
  # Application title
  titlePanel("Control Panel Title"),
  
  sidebarLayout(source("ui/control-panel.R", local = TRUE)$value,
                
                mainPanel(
                  tabsetPanel(type = "tabs",
                              source("ui/first-panel.R", local = TRUE)$value,
                              source("ui/second-panel.R", local = TRUE)$value)
                ))
))