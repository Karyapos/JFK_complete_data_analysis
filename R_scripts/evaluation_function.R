evaluation<-function(model,test_data){
        library(Metrics)
        f_pred<-predict(model,newdata = test_data)
        f_mae<-mae(test_data$taxi_out,f_pred)
        f_rmse<-rmse(test_data$taxi_out,f_pred)
        f_ss_res<-sum((test_data$taxi_out-f_pred)^2)
        f_ss_tot<-sum((test_data$taxi_out-mean(test_data$taxi_out))^2)
        f_r2<-1-f_ss_res/f_ss_tot
        return(list(mae=f_mae,rmse=f_rmse,r2=f_r2))
}