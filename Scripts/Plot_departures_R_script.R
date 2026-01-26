library(ggplot2) 

data<-read.csv2("most_effective_vars.csv",header = TRUE,sep = ",")

data$departures_5tile <- dplyr::case_when(
        grepl("^Very Low", data$departures_5tile) ~ "Very Low",
        grepl("^Low", data$departures_5tile)      ~ "Low",
        grepl("^Medium", data$departures_5tile)   ~ "Medium",
        grepl("^High", data$departures_5tile)     ~ "High",
        grepl("^Very High", data$departures_5tile)~ "Very High"
)

data$departures_5tile <- factor(
        data$departures_5tile,
        levels = c("Very Low", "Low", "Medium", "High", "Very High"),
        ordered = TRUE
)

ggplot(data, 
       aes(x = departures_5tile, y = taxi_out)) + 
        geom_boxplot(fill = "#708C60") + 
        theme_minimal() + 
        labs(
                title  = "Taxi_Out Distribution by Departure Traffic Quintile",
                x = "Departures Traffic Quantiles",
                y = "Taxi_Out ")