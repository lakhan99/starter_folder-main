#### Preamble ####
# Purpose: Download data from opendatatoronto 
# Author: Arsh Lakhanpal 
# Data: 3 January 2022
# Contact: arsh.lakhanpal@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!
# - Change these to yours
# Any other information needed?


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Data Download ####
#From https://open.toronto.ca/dataset/covid-19-cases-in-toronto/ 

# Datasets are grouped into packages that have multiple datasets that are relevant to that topic.
# So we first look at the package using a unique key that we obtain 
# from the datasets webpage. 
# get package

package <- show_package("64b54586-6180-4485-83eb-81e8fae3b8fe")

# get all resources for this package
resources <- list_package_resources("64b54586-6180-4485-83eb-81e8fae3b8fe")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

#There is only one rsource and so get_resource() will load that
covid_cases <-
  filter(datastore_resources, row_number() == 1) %>% get_resource()


#### Save data #### 

write_csv(covid_cases, "inputs/data/covid_cases.csv")
       
