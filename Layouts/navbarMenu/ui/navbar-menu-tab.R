

navbarMenu(
  "Navbar Element with Childen",
  tabPanel("Child 1",
           wellPanel(HTML(
             paste("<p><h1>About this Page</h1></p>",
                   sep = "")
           ))),
  tabPanel(
    "Child 2",
    fluidPage(
      wellPanel(HTML(paste(
        "<h1>About this Page</h1>",
        sep = ""
      )))
    ),
    ## ==== Allow for an anchor link to this location, shinyuser.shinyapp.io/shinyapp#child2
    value = 'child2'
  )
)