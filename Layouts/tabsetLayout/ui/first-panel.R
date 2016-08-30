## First Panel

tabPanel("Plot",
         wellPanel(HTML(
           paste0("<p>Nicely formatted description of tabPanel</p>")
         )),
         
         ## ==== Allow for an anchor link to this location, shinyuser.shinyapp.io/shinyapp#child2
         value = 'child2')