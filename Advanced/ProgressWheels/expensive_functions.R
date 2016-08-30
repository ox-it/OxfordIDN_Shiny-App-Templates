## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## Academic Contact: Felix Krawatzek
## Data Source: local file
## ================================================================================
## Note that this example is designed around http://shiny.rstudio.com/articles/progress.html

compute_data <- function(updateProgress = NULL) {
  # Create 0-row data frame which will be used to store data
  dat <- data.frame(x = numeric(0), y = numeric(0))
  
  for (i in 1:10) {
    Sys.sleep(5)
    
    # Compute new row of data
    new_row <- data.frame(x = rnorm(1), y = rnorm(1))
    
    # If we were passed a progress update function, call it
    if (is.function(updateProgress)) {
      text <- paste0("<strong>bold</strong>","\n","x:", round(new_row$x, 2), " y:", round(new_row$y, 2))
      updateProgress(detail = HTML(text))
    }
    
    # Add the new row of data
    dat <- rbind(dat, new_row)
  }
  
  dat
}