#### Preamble ####
# Purpose: Cleans the raw crime data and transforms the data
# Author: Adrian Ly
# Date: 16 January 2024
# Contact: adrian.ly@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must first run 01-download_data.R

#### Workspace setup ####
library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Clean data ####
raw_data <- read_csv("inputs/data/crime_rates.csv")

cleaned_data <-
  clean_names(raw_data) |>
  select(assault_rate_2014, assault_rate_2015, assault_rate_2016,  
         assault_rate_2017, assault_rate_2018, assault_rate_2019, 
         assault_rate_2020, assault_rate_2021, assault_rate_2022, 
         assault_rate_2023, autotheft_rate_2014, autotheft_rate_2015,
         autotheft_rate_2016, autotheft_rate_2017, autotheft_rate_2018,
         autotheft_rate_2019, autotheft_rate_2020, autotheft_rate_2021,
         autotheft_rate_2022, autotheft_rate_2023, biketheft_rate_2014,
         biketheft_rate_2015, biketheft_rate_2016, biketheft_rate_2017,
         biketheft_rate_2018, biketheft_rate_2019, biketheft_rate_2020,
         biketheft_rate_2021, biketheft_rate_2022, biketheft_rate_2023,
         breakenter_rate_2014, breakenter_rate_2015, breakenter_rate_2016,
         breakenter_rate_2017, breakenter_rate_2018, breakenter_rate_2019,
         breakenter_rate_2020, breakenter_rate_2021, breakenter_rate_2022,
         breakenter_rate_2023, homicide_rate_2014, homicide_rate_2015,
         homicide_rate_2016, homicide_rate_2017, homicide_rate_2018,
         homicide_rate_2019, homicide_rate_2020, homicide_rate_2021,
         homicide_rate_2022, homicide_rate_2023, robbery_rate_2014,
         robbery_rate_2015, robbery_rate_2016, robbery_rate_2017,
         robbery_rate_2018, robbery_rate_2019, robbery_rate_2020,
         robbery_rate_2021, robbery_rate_2022, robbery_rate_2023, 
         shooting_rate_2014, shooting_rate_2015, shooting_rate_2016,
         shooting_rate_2017, shooting_rate_2018, shooting_rate_2019,
         shooting_rate_2020, shooting_rate_2021, shooting_rate_2022, 
         shooting_rate_2023, theftfrommv_rate_2014, theftfrommv_rate_2015,
         theftfrommv_rate_2016, theftfrommv_rate_2017, theftfrommv_rate_2018,
         theftfrommv_rate_2019, theftfrommv_rate_2020, theftfrommv_rate_2021, 
         theftfrommv_rate_2022, theftfrommv_rate_2023, theftover_rate_2014,
         theftover_rate_2015, theftover_rate_2016, theftover_rate_2017,
         theftover_rate_2018, theftover_rate_2019, theftover_rate_2020,
         theftover_rate_2021, theftover_rate_2022, theftover_rate_2023) 

# Manipulate the data so that we can group the data by crime and year
long_data <- cleaned_data |>
  pivot_longer(
    cols = everything(),
    names_to = c("crime", "year"),
    # Look for a certain text pattern with regex
    # If we had an column named 'assault_rate_2017', it would be broken down
    # into assault (crime) and 2017 (year)
    names_pattern = "([^_]+)_rate_(\\d{4})", 
    # This is where the actual crime rates will be stored
    values_to = "rate"
  ) |>
  mutate(year = as.integer(year)) |>
  na.omit() # Omit rows with NA values

# Calculating the average crime rate for each crime type per year
average_crime_rates_per_year <- long_data |>
  group_by(crime, year) |>
  summarize(average_rate = mean(rate, na.rm = TRUE))

#### Save data ####
write_csv(average_crime_rates_per_year, "outputs/data/analysis_data.csv")
