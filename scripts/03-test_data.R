#### Preamble ####
# Purpose: Tests the simulation data for any errors
# Author: Adrian Ly
# Date: 16 Jaunary 2024
# Contact: adrian.ly@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must first run 00-simulate_data.R


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Test data ####

# Read simulated data file
simulated_data <- read_csv("inputs/data/simulated_crime_data.csv")

# Check to see if all of the years are between 2014 and 2023
simulated_data$year |> unique() == c("2014", "2015", "2016", "2017", "2018", 
                                     "2019", "2020", "2021", "2022", "2023")

# Check that their are only 10 years
simulated_data$year |> unique() |> length() == 10

# Check that the average rate values are between 0 and 1000
simulated_data$average_rate |> min() >= 0
simulated_data$average_rate |> max() <= 1000

# Check to see that there are only the specified crimes
simulated_data$crime |> unique() == c("assault", "autotheft", "biketheft", "breakenter", 
                                      "homicide", "robbery", "shooting", "theftfrommv", 
                                      "theftover")

# Check that there are only 9 crimes
simulated_data$crime |> unique() |> length() == 9
