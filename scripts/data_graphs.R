# Read the summary data CSV file
summary_delays <- read_csv("inputs/data/summary-data.csv")

# Since the summary_delays now contains calculated DelayCount, we just need to ensure
# that the Month and Year columns are in the correct date format for plotting
summary_delays <- summary_delays %>%
  mutate(MonthYear = as.Date(paste0(Year, "-", Month, "-01")))

# Create the line graph using ggplot2
plot_delaycount <- ggplot(summary_delays, aes(x = MonthYear, y = DelayCount)) +
  geom_line(color = "deeppink3", size = 1.5) +  # Recolor to blue and increase line thickness
  geom_point(color = 'deeppink4', size = 3) + # Increase point size
  theme_minimal() +
  theme(
    plot.title = element_text(size = 20, hjust = 0.5, face='bold'),  # Increase title size and center
    plot.margin = margin(t = 30, b = 30, l = 30, r = 30),  # Add space around the plot
    axis.text.x = element_text(margin = margin(t = 10)),  # Add space under x-axis labels
    axis.text.y = element_text(margin = margin(r = 10)),   # Add space left of y-axis labels
    plot.background = element_rect(fill = "white")      # White background
  ) +
  labs(
    title = "Changes in TTC Subway Delay Occurrence (2018-2023)",
    x = "Year",
    y = "Number of Delays"
  )

ggsave(filename = "outputs/plots/delay-count.png", plot = plot_delaycount,
       dpi = 600, width = 8, height = 6, units = 'in')

# Create the line graph using ggplot2
plot_maxdelay <- ggplot(summary_delays, aes(x = MonthYear, y = MaxDelay)) +
  geom_point(color = 'cyan4', size = 3) +  # Increase point size
  geom_hline(yintercept = 300, color = "orange", linetype = "solid", size = 1) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 20, hjust = 0.5, face='bold'),  # Increase title size and center
    plot.margin = margin(t = 30, b = 30, l = 30, r = 30),  # Add space around the plot
    axis.text.x = element_text(margin = margin(t = 10)),  # Add space under x-axis labels
    axis.text.y = element_text(margin = margin(r = 10)),   # Add space left of y-axis labels
    plot.background = element_rect(fill = "white")      # White background
  ) +
  labs(
    title = "Longest Delay in TTC Subway Service per Month",
    x = "Year",
    y = "Longest Monthly Delay (minutes)"
  )

ggsave(filename = "outputs/plots/delay-max.png", plot = plot_maxdelay, 
        dpi = 600, width = 8, height = 6, units = 'in')
