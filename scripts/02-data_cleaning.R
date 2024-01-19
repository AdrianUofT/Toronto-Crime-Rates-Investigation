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

# Calculating the percentage change in the average rate per year for each crime type
percentage_change_data <- average_crime_rates_per_year |>
  group_by(crime) |>
  # We want to compare the current avg rate with the previous avg rate to get
  # our rate change
  mutate(percentage_change = (average_rate / lag(average_rate) - 1) * 100) |>
  na.omit() # Remove any NA values that may occur

# Calculating the average crime rate for each crime type in the first and last years
first_year <- min(long_data$year)
last_year <- max(long_data$year)

average_rates_first_last_years <- long_data |>
  filter(year == first_year | year == last_year) |>
  group_by(crime, year) |>
  summarize(average_rate = mean(rate, na.rm = TRUE)) |>
  spread(year, average_rate)

# Calculating the percentage change from first year to last year for each crime type
final_percentage_change <- average_rates_first_last_years |>
  mutate(percentage_change = ((`last_year` - `first_year`)/`first_year`) * 100)

# Selecting only relevant columns for the table
final_percentage_change_table <- final_percentage_change |>
  select(crime, percentage_change)

# Calculating the average crime rate for each crime type in 2022 and 2023
average_rates_2022_2023 <- long_data |>
  filter(year == 2022 | year == 2023) |>
  group_by(crime, year) |>
  summarize(average_rate = mean(rate, na.rm = TRUE)) |>
  spread(year, average_rate)

# Calculating the percentage change from 2022 to 2023 for each crime type
percentage_change_2022_2023 <- average_rates_2022_2023 |>
  mutate(percentage_change = ((`2023` - `2022`)/`2022`) * 100)

# Selecting only relevant columns for the table
percentage_change_table <- percentage_change_2022_2023 |>
  select(crime, percentage_change)

#### Save data ####
write_csv(average_crime_rates_per_year, "outputs/data/average_crime_rates_data.csv")
write_csv(percentage_change_data, "outputs/data/percentage_change_data.csv")
write.csv(final_percentage_change_table, "outputs/data/percentage_change_table_2014_2023.csv")
write.csv(percentage_change_table, "outputs/data/percentage_change_table_2022_2023.csv")

