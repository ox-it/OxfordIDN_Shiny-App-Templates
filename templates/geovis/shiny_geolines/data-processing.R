## =============================== License ========================================
## ================================================================================
## This work is distributed under the CC0 1.0 Universal (CC0 1.0) license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

## ==== Packages to load for data processing
library(readr)

## Load data from figshare
journeys <- read_csv("data/sample_geo_lines.csv")

## Assign (meaningless) categories
journeys$type <- rep(c("A","B","C"), each = 5, len = nrow(journeys))




