library(tidyverse)
library(lubridate)

# Read the data from the CSV file
combined_data <- read_csv("inputs/data/combined-data.csv")

# Convert the "Date" column to a Date type if it's not already
combined_data$Date <- as.Date(combined_data$Date)

# Extract the year from the "Date" column and create a new column "Year"
combined_data <- combined_data %>%
  mutate(Year = year(Date))

# Select only the "Year" and "Line" columns
selected_data <- combined_data %>%
  select(Year, Line)

# Group the data by both "Year" and "Line" and count occurrences
line_counts_by_year <- selected_data %>%
  group_by(Year, Line) %>%
  summarize(Line_Counts = n()) %>%
  top_n(5, wt = Line_Counts)  # Keep only the top 5 counts within each year

plot_linecodes <- ggplot(line_counts_by_year, aes(x = Year, y = Line_Counts, fill = Line)) +
  geom_bar(stat = "identity") +
  labs(title = "Distribution of Delays across Subway Stations", x = "Year", y = "Reported Delays") +
  theme(
    plot.title = element_text(size = 20, hjust = 0.5, face='bold'),  # Increase title size and center
    plot.margin = margin(t = 30, b = 30, l = 30, r = 30),  # Add space around the plot
    axis.text.x = element_text(margin = margin(t = 10)),  # Add space under x-axis labels
    axis.text.y = element_text(margin = margin(r = 10))   # Add space left of y-axis labels
  )

ggsave(filename = "outputs/plots/delay-sub-lines.png", plot = plot_linecodes, 
       dpi = 600, width = 8, height = 6, units = 'in')