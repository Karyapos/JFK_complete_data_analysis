#In order to run this code you have to run evaluation_function.R and 
#lasso_function.R

#Set up
library(readxl)
data<-read_xlsx("all_data.xlsx")
library(dplyr)
library(lubridate)
data<-data %>%
        mutate(timestamp=ymd_hms(timestamp),
               hour=hour(timestamp),
               weekday=wday(timestamp,label = TRUE),
               weekday=factor(weekday,ordered = FALSE),
               carrier=factor(carrier),
               wind=factor(wind)) %>%
        select(-c(id,timestamp,flight_code,
                  destination,taxi_10tile))
set.seed(1542)
#Lasso
y1<-data$taxi_out
library(fastDummies)
lasso_data1<- data %>%
        dummy_cols(select_columns = "weekday") %>%
        select(-c(carrier,wind,taxi_out))
x1<-model.matrix(~.,data = lasso_data1)
set.seed(1542)
lasso(x1,y1)
y2<-data$taxi_out
lasso_data2<-data %>%
        dummy_cols(select_columns = "carrier") %>%
        select(-c(wind,weekday,taxi_out))
x2<-model.matrix(~.,data = lasso_data2)
lasso(x2,y2)
y3<-data$taxi_out
lasso_data3<-data%>%
        dummy_cols(select_columns = "wind") %>%
        select(-c(carrier,weekday,taxi_out))
x3<-model.matrix(~.,data=lasso_data3)
lasso(x3,y3)
y4<-data$taxi_out
lasso_data4<-data%>%
        dummy_cols(select_columns = c("wind","carrier")) %>%
        select(-c(weekday,taxi_out))
x4<-model.matrix(~.,data=lasso_data4)
lasso(x4,y4)
y5<-data$taxi_out
lasso_data5<-data %>%
        select(departures,wind)
x5<-model.matrix(~.,data = lasso_data5)
lasso(x5,y5)
#GAM
n<-nrow(data)
train_idx<-sample(seq_len(n),size = 0.8*n)
gam_data1<- data %>%
        select(dep_delay,departures,arrivals,temperature,wind,taxi_out)
train_data1<-gam_data1[train_idx,]
test_data1<-gam_data1[-train_idx,]
library(mgcv)
gam_model1<-gam(taxi_out~s(departures) +wind,data = train_data1,
                method = "REML")
evaluation(gam_model1,test_data1)
gam_model2<-gam(taxi_out~s(dep_delay)+s(departures)+s(arrivals)
                +s(temperature)+wind, data = train_data1,
                method = "REML")
evaluation(gam_model2,test_data1)

gam_data2<- data %>%
        select(dep_delay,departures,arrivals,temperature,carrier,taxi_out)
train_data2<-gam_data2[train_idx,]
test_data2<-gam_data2[-train_idx,]
gam_model3<-gam(taxi_out~s(departures) +carrier+s(dep_delay)
                +s(arrivals)+s(temperature),data = train_data2,
                method = "REML")
evaluation(gam_model3,test_data2)

#Random Forest
library(randomForest)
rf1_train<-data[train_idx,] %>%
        select(c(departures,wind,taxi_out))
rf1_test<-data[-train_idx,] %>%
        select(c(departures,wind,taxi_out))
rf1<-randomForest(taxi_out~.,
                  data=rf1_train,
                  mtry=2,
                  maxnodes=30)
evaluation(rf1,rf1_test)
rf2_train<-data[train_idx,]
rf2_test<-data[-train_idx,]
rf2<-randomForest(taxi_out~.,
                  data=rf2_train,
                  mtry=6,
                  importance=TRUE,
                  maxnodes=500,
                  nodesize=150)
evaluation(rf2,rf2_test)
varImpPlot(rf2)
