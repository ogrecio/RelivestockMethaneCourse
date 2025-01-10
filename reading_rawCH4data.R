#####################################################################################################
######################### READING RAW DATABASE FOR THE COURSE ####################################
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

########## calculating duration of the visit ##############
event_duration <- event_ch4 %>%
  group_by(eventID) %>%
  summarize(
    start_time = min(datetime),
    end_time = max(datetime),
    lenght = as.numeric(difftime(max(datetime), min(datetime), units = "secs"))
  )

############ calculating the average of the lowest 3 or 5 measurements per visit to use it as background ########
event_5low <- event_ch42 %>%
  group_by(eventID) %>%
  arrange(ch4) %>%
  slice_head(n = 5) %>%
  summarise(avg_ch4 = mean(ch4, na.rm = TRUE))

event_3low <- event_ch42 %>%
  group_by(eventID) %>%
  arrange(ch4) %>%
  slice_head(n = 3) %>%
  summarise(avg_ch4 = mean(ch4, na.rm = TRUE))

############ calculating the 0.001 quantile per visit to use it as background ############
event_quant <- event_ch42 %>%
  group_by(eventID) %>%
  summarise(ch4_quantile_0_001 = quantile(ch4, probs = 0.001, na.rm = TRUE))

############### calculating the mean for ch4 and co2 per visit #################
event_means <- event_ch42 %>%
  group_by(eventID) %>%
  summarise(
    mean_ch4 = mean(ch4, na.rm = TRUE),
    mean_co2 = mean(co2, na.rm = TRUE)
  )

############# calculating the mean for ch4 only for 60-300 sec per visit ######## losing one event
library(dplyr)
library(lubridate)

# Assuming your data is stored in event_ch42
event_cut <- event_ch42 %>%
  # Trim any spaces from the TimeStamp column
  mutate(TimeStamp = trimws(TimeStamp)) %>%
  # Convert TimeStamp to datetime object
  mutate(TimeStamp = ymd_hms(TimeStamp)) %>%
  group_by(eventID) %>%
  # Calculate the time difference in seconds from the first TimeStamp per eventID
  mutate(time_diff_sec = as.numeric(difftime(TimeStamp, min(TimeStamp), units = "secs"))) %>%
  # Filter to keep only rows where the time difference is between 60 and 300 seconds
  filter(time_diff_sec >= 60 & time_diff_sec <= 300) %>%
  # Optionally, summarize the data (for example, calculating means of ch4 and co2)
  summarise(
    mean_ch4 = mean(ch4, na.rm = TRUE),
    mean_co2 = mean(co2, na.rm = TRUE)
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
event_id <- 247

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

################################### Detect Peaks ################################
# Load necessary libraries
library(dplyr)
library(ggplot2)

# Read the data
data <- event_ch42

# Function to detect peaks
detectPeaks <- function(ch4, windowSize = 5, threshold = 0.0005) {
  peaksIni <- c()
  peaksFin <- c()
  stage <- FALSE
  peak_decreasing <- FALSE
  
  for (i in 1:(length(ch4) - windowSize)) {
    tempW <- ch4[i:(i + windowSize - 1)]
    tempX <- 1:windowSize
    
    mean_tempW <- mean(tempW, na.rm = TRUE)
    mean_tempX <- mean(tempX, na.rm = TRUE)
    
    cov_xy <- sum((tempW - mean_tempW) * (tempX - mean_tempX), na.rm = TRUE)
    var_x <- sum((tempX - mean_tempX) * (tempX - mean_tempX), na.rm = TRUE)
    
    pendiente <- cov_xy / var_x
    
    if (pendiente > threshold && !stage) {
      peaksIni <- c(peaksIni, i)
      stage <- TRUE
      peak_decreasing <- FALSE
    } else if (stage && pendiente < -threshold) {
      peak_decreasing <- TRUE
    } else if (stage && peak_decreasing && pendiente > -threshold / 2) {
      peaksFin <- c(peaksFin, i)
      stage <- FALSE
      peak_decreasing <- FALSE
    } else if (length(peaksIni) == 0 && pendiente > threshold / 2) {
      # Handle case where no peaks have been detected yet
    } else if (i == (length(ch4) - windowSize) && peak_decreasing) {
      peaksFin <- c(peaksFin, i)
    }
  }
  
  list(peaksIni = peaksIni, peaksFin = peaksFin)
}

# Apply the peak detection to the entire database
results <- data %>%
  group_by(eventID) %>%
  summarise(num_peaks = length(detectPeaks(ch4)$peaksIni))

# Print the results
print(results)

####################### ADDING THE PHENOTYPES ############## 
# Load necessary libraries
library(dplyr)
library(ggplot2)

# Read the data
data <- event_ch42

# Function to detect peaks and calculate sum2maxpeaks
detectPeaksAndSum <- function(ch4, windowSize = 5, threshold = 0.0005) {
  peaksIni <- c()
  peaksFin <- c()
  stage <- FALSE
  peak_decreasing <- FALSE
  
  for (i in 1:(length(ch4) - windowSize)) {
    tempW <- ch4[i:(i + windowSize - 1)]
    tempX <- 1:windowSize
    
    mean_tempW <- mean(tempW, na.rm = TRUE)
    mean_tempX <- mean(tempX, na.rm = TRUE)
    
    cov_xy <- sum((tempW - mean_tempW) * (tempX - mean_tempX), na.rm = TRUE)
    var_x <- sum((tempX - mean_tempX) * (tempX - mean_tempX), na.rm = TRUE)
    
    pendiente <- cov_xy / var_x
    
    if (pendiente > threshold && !stage) {
      peaksIni <- c(peaksIni, i)
      stage <- TRUE
      peak_decreasing <- FALSE
    } else if (stage && pendiente < -threshold) {
      peak_decreasing <- TRUE
    } else if (stage && peak_decreasing && pendiente > -threshold / 2) {
      peaksFin <- c(peaksFin, i)
      stage <- FALSE
      peak_decreasing <- FALSE
    } else if (length(peaksIni) == 0 && pendiente > threshold / 2) {
      # Handle case where no peaks have been detected yet
    } else if (i == (length(ch4) - windowSize) && peak_decreasing) {
      peaksFin <- c(peaksFin, i)
    }
  }
  
  sum2maxpeaks <- 0
  if (length(peaksIni) > 0 && length(peaksFin) > 0) {
    for (j in 1:length(peaksIni)) {
      start <- peaksIni[j]
      end <- ifelse(j <= length(peaksFin), peaksFin[j], NA)
      if (!is.na(end) && end > start) {
        peak_values <- ch4[start:end]
        max_values <- sort(peak_values, decreasing = TRUE)[1:2]
        avg_max_values <- mean(max_values)
        sum2maxpeaks <- sum2maxpeaks + avg_max_values
      }
    }
  }
  
  list(peaksIni = peaksIni, peaksFin = peaksFin, sum2maxpeaks = sum2maxpeaks)
}

# Apply the peak detection to the entire database
results <- data %>%
  group_by(eventID) %>%
  summarise(
    num_peaks = {
      result <- detectPeaksAndSum(ch4)
      length(result$peaksIni)
    },
    sum2maxpeaks = {
      result <- detectPeaksAndSum(ch4)
      result$sum2maxpeaks
    }
  )

# Print the results
print(results)

############################### now with AUC #####################
# Function to detect peaks and calculate sum2maxpeaks and area under the curve
detectPeaksAndSum <- function(ch4, windowSize = 5, threshold = 0.0005) {
  peaksIni <- c()
  peaksFin <- c()
  stage <- FALSE
  peak_decreasing <- FALSE
  
  for (i in 1:(length(ch4) - windowSize)) {
    tempW <- ch4[i:(i + windowSize - 1)]
    tempX <- 1:windowSize
    
    mean_tempW <- mean(tempW, na.rm = TRUE)
    mean_tempX <- mean(tempX, na.rm = TRUE)
    
    cov_xy <- sum((tempW - mean_tempW) * (tempX - mean_tempX), na.rm = TRUE)
    var_x <- sum((tempX - mean_tempX) * (tempX - mean_tempX), na.rm = TRUE)
    
    pendiente <- cov_xy / var_x
    
    if (pendiente > threshold && !stage) {
      peaksIni <- c(peaksIni, i)
      stage <- TRUE
      peak_decreasing <- FALSE
    } else if (stage && pendiente < -threshold) {
      peak_decreasing <- TRUE
    } else if (stage && peak_decreasing && pendiente > -threshold / 2) {
      peaksFin <- c(peaksFin, i)
      stage <- FALSE
      peak_decreasing <- FALSE
    } else if (length(peaksIni) == 0 && pendiente > threshold / 2) {
      # Handle case where no peaks have been detected yet
    } else if (i == (length(ch4) - windowSize) && peak_decreasing) {
      peaksFin <- c(peaksFin, i)
    }
  }
  
  sum2maxpeaks <- 0
  area_under_curve <- 0
  if (length(peaksIni) > 0 && length(peaksFin) > 0) {
    for (j in 1:length(peaksIni)) {
      start <- peaksIni[j]
      end <- ifelse(j <= length(peaksFin), peaksFin[j], NA)
      if (!is.na(end) && end > start) {
        peak_values <- ch4[start:end]
        max_values <- sort(peak_values, decreasing = TRUE)[1:2]
        avg_max_values <- mean(max_values)
        sum2maxpeaks <- sum2maxpeaks + avg_max_values
        
        # Calculate area under the curve above ground level (assumed to be the minimum value in ch4)
        ground_level <- min(ch4)
        area_under_curve <- area_under_curve + sum(peak_values - ground_level)
      }
    }
  }
  
  list(peaksIni = peaksIni, peaksFin = peaksFin, sum2maxpeaks = sum2maxpeaks, area_under_curve = area_under_curve)
}

# Apply the peak detection to the entire database
results <- data %>%
  group_by(eventID) %>%
  summarise(
    num_peaks = {
      result <- detectPeaksAndSum(ch4)
      length(result$peaksIni)
    },
    sum2maxpeaks = {
      result <- detectPeaksAndSum(ch4)
      result$sum2maxpeaks
    },
    area_under_curve = {
      result <- detectPeaksAndSum(ch4)
      result$area_under_curve
    }
  )

# Print the results
print(results)

############################### NOW WITH THE CUT VISIT (EVENT) ###########################
# Load necessary libraries
library(dplyr)
library(ggplot2)

# Read the data
data <- event_ch42

# Convert TimeStamp to POSIXct
data$TimeStamp <- as.POSIXct(data$TimeStamp, format = "%Y-%m-%d %H:%M:%S")

# Calculate the time difference in seconds from the first TimeStamp per eventID
data <- data %>%
  group_by(eventID) %>%
  mutate(time_diff_sec = as.numeric(difftime(TimeStamp, min(TimeStamp), units = "secs"))) %>%
  ungroup()

# Function to detect peaks and calculate sum2maxpeaks and area under the curve
detectPeaksAndSum <- function(ch4, windowSize = 5, threshold = 0.0005) {
  peaksIni <- c()
  peaksFin <- c()
  stage <- FALSE
  peak_decreasing <- FALSE
  
  for (i in 1:(length(ch4) - windowSize)) {
    tempW <- ch4[i:(i + windowSize - 1)]
    tempX <- 1:windowSize
    
    mean_tempW <- mean(tempW, na.rm = TRUE)
    mean_tempX <- mean(tempX, na.rm = TRUE)
    
    cov_xy <- sum((tempW - mean_tempW) * (tempX - mean_tempX), na.rm = TRUE)
    var_x <- sum((tempX - mean_tempX) * (tempX - mean_tempX), na.rm = TRUE)
    
    pendiente <- cov_xy / var_x
    
    if (pendiente > threshold && !stage) {
      peaksIni <- c(peaksIni, i)
      stage <- TRUE
      peak_decreasing <- FALSE
    } else if (stage && pendiente < -threshold) {
      peak_decreasing <- TRUE
    } else if (stage && peak_decreasing && pendiente > -threshold / 2) {
      peaksFin <- c(peaksFin, i)
      stage <- FALSE
      peak_decreasing <- FALSE
    } else if (length(peaksIni) == 0 && pendiente > threshold / 2) {
      # Handle case where no peaks have been detected yet
    } else if (i == (length(ch4) - windowSize) && peak_decreasing) {
      peaksFin <- c(peaksFin, i)
    }
  }
  
  sum2maxpeaks <- 0
  area_under_curve <- 0
  if (length(peaksIni) > 0 && length(peaksFin) > 0) {
    for (j in 1:length(peaksIni)) {
      start <- peaksIni[j]
      end <- ifelse(j <= length(peaksFin), peaksFin[j], NA)
      if (!is.na(end) && end > start) {
        peak_values <- ch4[start:end]
        max_values <- sort(peak_values, decreasing = TRUE)[1:2]
        avg_max_values <- mean(max_values)
        sum2maxpeaks <- sum2maxpeaks + avg_max_values
        
        # Calculate area under the curve above ground level (assumed to be the minimum value in ch4)
        ground_level <- min(ch4)
        area_under_curve <- area_under_curve + sum(peak_values - ground_level)
      }
    }
  }
  
  list(peaksIni = peaksIni, peaksFin = peaksFin, sum2maxpeaks = sum2maxpeaks, area_under_curve = area_under_curve)
}

# Apply the peak detection to the entire database, considering only data between 60 sec to 300 sec per eventID
results2 <- data %>%
  filter(time_diff_sec >= 60 & time_diff_sec <= 300) %>%
  group_by(eventID) %>%
  summarise(
    num_peaks = {
      result <- detectPeaksAndSum(ch4)
      length(result$peaksIni)
    },
    sum2maxpeaks = {
      result <- detectPeaksAndSum(ch4)
      result$sum2maxpeaks
    },
    area_under_curve = {
      result <- detectPeaksAndSum(ch4)
      result$area_under_curve
    }
  )

# Print the results
print(results2)
