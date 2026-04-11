#the following script presents the core R code used to rank
#each variable’s influence on taxi_out.

library(dplyr)
library(lsr)
#the initial data was provided in two different tables
get_df<-function(x){if (x %in% names(airport_data)) {
        airport_data
} else {
        weather_data
}}
#unfortunately, pressure is registered as character variable
weather_data$pressure<-as.numeric(weather_data$pressure)

#divide variables into numeric and character ones
num_vars<-c("dep_delay","distance","departures","arrivals",
            "hour","temperature","dew_point","humidity",
            "wind_speed","wind_gust","pressure")
char_vars<-c("carrier","flight_code","destination",
             "time","day","wind")
#correlation check (pearson) for numeric variables
num_results<- sapply(num_vars,function(x){
        df <- get_df(x)
        return(cor(df$taxi_out,df[[x]], method = "pearson")) 
})
# eta(anova I) for character variables
char_results<-sapply(char_vars,function(x){
        df <- get_df(x)
        f<-as.formula(paste("taxi_out ~ ",x))
        model<-aov(f, data=df)
        return(etaSquared(model)[1])
})
#Finally we create a decent structure for the outcome data frame
num_results<-data.frame(
        "variable"= names(num_results), 
        "r2"= round(num_results^2*100,2),
        row.names = NULL)
char_results<-data.frame(
        "variable" = names(char_results),
        "r2" = round(char_results*100,2),
        row.names = NULL
)
results<- rbind(char_results,num_results) %>%
        arrange(desc(r2)) %>%
        mutate(r2= paste(r2,"%"))
results