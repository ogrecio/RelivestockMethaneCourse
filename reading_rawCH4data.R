setwd("~/Projects/Re-Livestock/course")
rawCH42 <- read.table("output.txt", sep = ",", stringsAsFactors = F, header = T)  

library(dplyr)
library(tidyr)

# Install and load necessary packages
install.packages(c("ggplot2", "lubridate", "findPeaks"))
library(ggplot2)
library(lubridate)
library(findPeaks)

# Parse datetime
rawCH42$date <- as.Date.character(rawCH42$date, "%Y/%d/%m")
rawCH42$datetime <- as.POSIXct(rawCH42$date, format = "%Y/%d/%m %H:%M:%S")
rawCH42$date <- as.Date.character(rawCH42$date, "%Y/%d/%m")

#create an event per entrance to the AMS per day per animal
event_ch4 <- rawCH42 %>%    
  select(ch4, co2, cow, date, datetime) %>%
  mutate(eventID = 1 + cumsum(cow != lag(cow, default = first(cow))))

hist(event_ch4$eventID)

event_duration <- event_ch4 %>%
  group_by(eventID) %>%
  summarize(
    start_time = min(datetime),
    end_time = max(datetime),
    lenght = as.numeric(difftime(max(datetime), min(datetime), units = "secs"))
  )

############################################# ploting automatically all cows and all events works well
install.packages(c("ggplot2", "lubridate"))

# Get unique combinations of cows and events
unique_combinations <- unique(event_ch4[, c("cow", "eventID")])

# Create a separate time series plot for each cow and event
for (i in seq_len(nrow(unique_combinations))) {
  cow_id <- unique_combinations$cow[i]
  event_id <- unique_combinations$eventID[i]
  
  # Filter data for the specific cow and event
  plot_data <- subset(event_ch4, cow == cow_id & eventID == event_id)
  
  # Create ggplot plot only if there is data for the combination
  if (nrow(plot_data) > 0) {
    pdf(paste("plot_timeseries_cow", cow_id, "_event", event_id, ".pdf", sep = ""))
    
    # Create ggplot plot
    p <- ggplot(plot_data, aes(x = datetime, y = ch4)) +
      geom_line() +
      geom_point() +
      labs(title = paste("CH4 Time Series for Cow", cow_id, "in Event", event_id),
           x = "Datetime",
           y = "Ch4") +
      theme_minimal()
    
    # Print the ggplot plot
    print(p)
    
    # Close the PDF file
    dev.off()
  }
}

############# lets try per cow per event   ####### 

# Choose a specific cow and event for the plot
cow_id <- 13
event_id <- 9

plot_data <- subset(event_ch4, cow == cow_id & eventID == event_id)

# Create ggplot plot
p <- ggplot(plot_data, aes(x = datetime, y = ch4)) +
  geom_line() +
  geom_point() +
  labs(title = paste("CH4 Time Series for Cow", cow_id, "in Event", event_id),
       x = "Datetime",
       y = "Ch4") +
  theme_minimal()

# Explicitly print and assign a name to the plot
print(p)

######################## LETS CALCULATE THE PEAKS PHENOTYPES AND REC TIME ################################
event_ch4$TimeStamp <- as.POSIXct(event_ch4$datetime, format = "%H:%M:%OS")

# Group by eventID and calculate the time difference
event_ch42 <- event_ch4 %>%
  group_by(eventID) %>%
  mutate(rec_t = difftime(max(TimeStamp), min(TimeStamp), units = "secs"))

event_ch42 <- as.data.frame(event_ch42)

#start
analyze_CH4_peaks2 <- function(data) {
  result_list <- list()
  
  unique_events <- unique(data$eventID)
  
  for (event_id in unique_events) {
    event_data <- subset(data, eventID == event_id)$ch4
    
    # Identify peaks with stricter conditions
    peaks <- which(diff(c(0, diff(event_data), 0) > 0) & diff(c(0, diff(event_data), 0) < 0) > 0)
    
    if (length(peaks) > 0) {
      num_peaks <- length(peaks)
      
      sum_top_two_all_peaks <- 0  # Initialize the sum of average of top two values per peak
      avg_top_two_all_peaks <- 0  # Initialize the average of average of top two values per peak
      
      for (peak_num in seq_along(peaks)) {
        peak_index <- peaks[peak_num]
        
        values_within_peak <- event_data[which((seq_along(event_data) >= peak_index - 1) & (seq_along(event_data) <= peak_index + 1))]
        
        if (length(values_within_peak) >= 2) {
          sorted_values <- sort(values_within_peak, decreasing = TRUE)
          top_two_values <- sorted_values[1:2]
          
          sum_top_two <- sum(top_two_values)
          avg_top_two <- mean(top_two_values)
          
          sum_top_two_all_peaks <- sum_top_two_all_peaks + sum_top_two
          avg_top_two_all_peaks <- avg_top_two_all_peaks + avg_top_two
        }
      }
      
      # Calculate average of average of top two values per peak
      if (num_peaks > 0) {
        avg_top_two_all_peaks <- avg_top_two_all_peaks / num_peaks
      }
      
      avg_sum_all_peaks <- sum_top_two_all_peaks / num_peaks
      
      # Extract rec_time from the first row of each event
      rec_time <- as.numeric(difftime(max(data$TimeStamp[data$eventID == event_id]), 
                                      min(data$TimeStamp[data$eventID == event_id]), 
                                      units = "secs"))
      
      result_list[[length(result_list) + 1]] <- list(
        eventID = event_id,
        num_peaks = num_peaks,
        sum_top_two_all_peaks = sum_top_two_all_peaks,
        avg_top_two_all_peaks = avg_top_two_all_peaks,
        avg_sum_all_peaks = avg_sum_all_peaks,
        rec_time = rec_time
      )
    }
  }
  
  result_df <- do.call(rbind.data.frame, result_list)
  return(result_df)
}

# Applying the function to the database
result_full <- analyze_CH4_peaks2(event_ch42)
