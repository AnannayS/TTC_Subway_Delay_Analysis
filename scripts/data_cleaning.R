library(tidyverse)
library(readxl) # Note this is used because the initial data is provided in XLSX format

# Set column data types
# Initialize an empty data frame to store the combined data
combined_data <- data.frame()

# Loop through each year
for (year in 2018:2023) {
  file_name <- paste0("inputs/data/ttc-subway-delay-data-", year, ".xlsx")
  sheets <- readxl::excel_sheets(file_name)

  # Loop through each month (12 sheets per file)
   for (month in sheets) {
     # Read the sheet
     monthly_data <- read_excel(file_name, sheet = month)

     # Combine the data
     combined_data <- rbind(combined_data, monthly_data)
   }
}

# Clean up date-time to just dates
combined_data <- combined_data %>% mutate(Date = as.Date(Date))

# Remove excess columns
excess_cols <- c("Time", "Min Gap", "Bound", "Vehicle")
combined_data <- combined_data %>% select(-one_of(excess_cols))

# Write the combined data to a new CSV file
readr::write_csv(combined_data, "inputs/data/combined-data.csv")


