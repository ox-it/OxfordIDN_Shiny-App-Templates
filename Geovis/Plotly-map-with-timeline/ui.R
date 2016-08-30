## ==== Packages to load for server

library(shiny) # Some advanced functionality depends on the shiny package being loaded client-side, including plot.ly
library(plotly) # Load the plotly library
library(shinythemes) # Template uses the cerulean theme as it is pretty
library(knitr)
library(DT)

## ==== Global client-side Variables

example_data_frame <-
  data.frame(
    "Send Location" = c("50.97178\n 13.960129"),
    "Send City" = c("DEU, Mockethal"),
    "Receive Location" = c("50.97178\n 13.960129"),
    "Receive City" = c("DEU, Mockethal"),
    "Date" = c("1800-01-01"),
    "Category" = c("A")
  )

## ====  shinyUI function which generates the UI

shinyUI(fluidPage(
  ## ==== Include google analytics code
  tags$head(includeScript("google-analytics.js")),
  
  ## ==== Automatically include vertical scrollbar
  ## ==== This prevents the app from reloading content when the window is resized which would otherwise result in the
  ## ==== appearance of the scrollbar and the reloading of content. Note that "click data" may still be lost during
  ## ==== resizing, as discussed here https://github.com/rstudio/shiny/issues/937
  tags$style(type = "text/css", "body { overflow-y: scroll; }"),
  
  theme = shinytheme("cerulean"),
  
  HTML(
    "<h2>Plot.ly Scattergeo Plot with Timeline to Filter out Data</h2>"
  ),
  sidebarLayout(
    sidebarPanel(
      uiOutput("show_timeslider_UI"),
      # uiOutput("legend_type_UI"),
      uiOutput("time_period_of_interest_UI"),
      uiOutput("show_letters_before_date_UI"),
      uiOutput("show_routes_UI"),
      width = 4
    ),
    mainPanel(
      uiOutput("nothing_to_display_UI"),
      plotlyOutput("europe_map", height = "100%"),
      width = 8
    )
  ),
wellPanel(
  HTML(
    "<p>This Shiny app is a template designed by Martin Hadley in the IT Services Department of Oxford University for the Live Data Project</p>",
    "<p>The template takes a .csv file with the following structure</p>"
  ),
  datatable(example_data_frame,options = list(dom = 't', autowidth = "50%",rownames = FALSE), rownames = FALSE),
  HTML(
    "<br>",
    "<p>The example data in this application is an anonymised subset of data collected from the 19th Century postal network, the size of each point
    corresponds to the number of letters sent from that location.</p>"
  ),
  HTML(
    "<br><p>The interactive map above is provided by the <a href=http://plot.ly>plot.ly</a> R package and provides the following features:</p>",
    "<ul>",
    "<li>Zoom with scrollwheel/touch</li>",
    "<li>Hide a location by clicking its corresponding trace in the legend</li>",
    "</ul>"
  ),
  HTML("<a rel='license' href='http://creativecommons.org/licenses/by/4.0/'><img alt='Creative Commons License' style='border-width:0' 
       src='https://i.creativecommons.org/l/by/4.0/88x31.png' /></a><br /><span xmlns:dct='http://purl.org/dc/terms/' 
       href='http://purl.org/dc/dcmitype/InteractiveResource' property='dct:title' rel='dct:type'>Plot.ly Scattergeo Plot with Timeline 
       to Filter out Data</span> by <span xmlns:cc='http://creativecommons.org/ns#' property='cc:attributionName'>Live Data Project</span> 
       is licensed under a <a rel='license' href='http://creativecommons.org/licenses/by/4.0/'>Creative Commons Attribution 4.0 International License</a>.")
)

))