model<-lm(taxi_out~destination+carrier+flight_code+departures, data = airport_data)
overlap<-etaSquared(model, type = 2)
overlap <- data.frame( variable = row.names(overlap),
                       r2 = round(overlap[,1] * 100, 2) , 
                       row.names = NULL ) %>%
        arrange(desc(r2)) %>% 
        mutate(r2 = paste0(r2, "%"))
overlap