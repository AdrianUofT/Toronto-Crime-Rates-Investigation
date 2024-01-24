#### Preamble ####
# Purpose: Simulates a dataset of the average crime rate for each crime 
# from the years 2014-2023
# Author: Adrian Ly
# Date: 16 January 2024
# Contact: adrian.ly@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Simulate data ####
set.seed(123) # Setting a seed for reproducibility

# Define crime types
crime_types <- c("assault", "autotheft", "biketheft", "breakenter", 
                 "homicide", "robbery", "shooting", "theftfrommv", 
                 "theftover")

# Years
years <- 2014:2023

# Simulating data
simulated_crime_data <- 
  tibble(
    crime = rep(crime_types, each = length(years)),
    year = rep(years, times = length(crime_types)),
    average_rate = runif(n = length(years) * length(crime_types), min = 0, max = 1000) # Random rates between 0 and 1000
  )

head(simulated_crime_data)

write_csv(simulated_crime_data, "inputs/data/simulated_crime_data.csv") 


