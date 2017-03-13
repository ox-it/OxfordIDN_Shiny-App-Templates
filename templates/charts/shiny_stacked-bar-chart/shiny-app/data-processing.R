## =============================== License ========================================
## ================================================================================
## This work is distributed under the CC0 1.0 Universal (CC0 1.0) license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

## ==== Packages to load for data processing
library(readr)

## Load data from file
business_trips <- read_csv("data/sample_stacked_bar_chart.csv")

# wide_import <- read_csv("data/wide_data.csv")
# colnames(wide_import) <- tolower(colnames(wide_import))
# 
# which(colnames(wide_import) %in% c("Country","Client"))
# 
# business_trips <- wide_import %>%
#   gather(activity, hours, which(!colnames(wide_import) %in% c("country","client")))


category_columns <-
  list(
    "Type of activity" = "activity",
    "Country" = "country"
  )
