library(tidyverse)
library(lubridate)

# Read the data from the CSV file
combined_data <- read_csv("inputs/data/combined-data.csv")

# Convert Date column to Date format and extract Year and Month
combined_data <- combined_data %>%
  mutate(
    Date = as.Date(Date, format = "%Y-%m-%d"),
    Year = year(Date),
    Month = month(Date)
  ) %>%
  filter(`Min Delay` > 0) # Filter out the zero delays for some calculations

# Calculate different summary statistics
summary_delays <- combined_data %>%
  group_by(Year, Month) %>%
  summarise(
    AvgNonZeroDelay = mean(`Min Delay`, na.rm = TRUE),
    MaxDelay = max(`Min Delay`, na.rm = TRUE),
    DelayCount = sum(`Min Delay` > 0, na.rm = TRUE),
    .groups = 'drop'
  )

# Write data to CSV
readr::write_csv(summary_delays, "inputs/data/summary-data.csv")

# Add a Year column from the Date column
combined_data <- combined_data %>%
  mutate(Year = year(as.Date(Date, format = "%Y-%m-%d")))

# Find the top 3 most common codes for each year
top_codes_per_year <- combined_data %>%
  count(Year, Code) %>%
  group_by(Year) %>%
  top_n(3, n) %>%
  ungroup()

names(top_codes_per_year)[names(top_codes_per_year) == "n"] <- "Number of Incidents"


# Write data to CSV
readr::write_csv(top_codes_per_year, "inputs/data/codes-data.csv")