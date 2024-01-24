# Is Crime Really On A Rise In Toronto? An Analysis of The Past And Current Crime Rates of Toronto

**Statement on LLM usage: Aspects of the code were written with the help of ChatGPT. The README you are currently reading were written with the help of ChatGPT and the entire chat history is available in `inputs/llms/usage.txt`**

## Overview
This repository contains the work of our investigation into the crime rates in Toronto. Our goal was to analyze various types of crime data from the years 2014 to 2023 to identify trends and draw conclusions about the safety and security in Toronto.

## Data Source
The dataset was sourced from a publicly available database [link](https://open.toronto.ca/dataset/neighbourhood-crime-rates/), providing detailed information on different types of crimes reported in Toronto.

## Methodology
Our analysis involved several key steps:

### 1. Data Simulation
To complement our analysis and for testing our methods, we simulated crime rate data resembling the structure of the real dataset. This was achieved using R's random number generation functions to create a plausible range of crime rates for various crime types across the specified years.

### 2. Data Acquisition
The real crime data was downloaded from https://open.toronto.ca/dataset/neighbourhood-crime-rates/.

### 3. Data Cleaning
Upon acquisition, the dataset underwent a thorough cleaning process using R. This involved handling missing values, correcting inconsistencies, and structuring the data in a suitable format for analysis.
### 4. Data Testing
We performed various tests on both simulated and real data to ensure the integrity and reliability of our analysis. This included consistency checks, validation against known benchmarks, and exploratory data analysis.
### 5. Analysis
Using R, we conducted a comprehensive analysis of the crime rates. Our approach involved examining trends over the years for different types of crimes, comparing rates across different regions within Toronto, and identifying any notable patterns.
### 6. Conclusion
Our findings provide insights into the crime trends in Toronto. Detailed conclusions are presented in the final report, including any correlations found between different types of crimes, temporal changes, and recommendations for future studies.
## Tools Used
* R Language: For data cleaning, manipulation, simulation, testing, and analysis.
* R Libraries: Key packages like dplyr, tidyverse, opendatatoronto, lubridate, janitor, and knitr were extensively used for efficient data handling and visualization.
# Repository Structure
* /inputs/sketches: Contains sketches for the datasets.
* /inputs/data: Contains raw and simulated datasets.
* /inputs/llm: Contains LLM usage.
* /outputs/data: Contains cleaned datasets.
* /outputs/paper: Documentation and final analysis report.
* /scripts: R scripts used for data processing and analysis.

# How to Use
Clone the repository.
Install R and necessary packages.
Run the scripts in the /scripts directory to replicate the analysis.

# License
This project is licensed under the MIT License.

# Contact
For any queries or further information, please contact adrian.ly@mail.utoronto.ca

