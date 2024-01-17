#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto 
# Author: Adrian Ly
# Date: 16 January 2024 
# Contact: adrian.ly@mail.utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Link to dataset used: https://open.toronto.ca/dataset/neighbourhood-crime-rates/


#### Workspace setup ####
library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Download data ####
crime_rates <- 
  list_package_resources("neighbourhood-crime-rates") |>
  # Within this package, we are interested in the MTM10 projection
  filter(name == "neighbourhood-crime-rates - 2952.csv") |>
  # Having reduced the dataset to one row we can get the resource
  get_resource()



#### Save data ####
# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(crime_rates, "inputs/data/crime_rates.csv") 

         
