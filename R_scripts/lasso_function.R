lasso<-function(x,y){
        library(glmnet)
        cv_model<-cv.glmnet(x,y)
        lambda<-cv_model$lambda.min
        model<-glmnet(x,y,lambda=lambda)
        
        library(Metrics)
        f_pred<-predict(model,newx = x,s=lambda)
        f_mae<-mae(y,f_pred)
        f_rmse<-rmse(y,f_pred)
        f_ss_res<-sum((y-f_pred)^2)
        f_ss_tot<-sum((y-mean(y))^2)
        f_r2<-1-f_ss_res/f_ss_tot
        
        coeftable<-data.frame(variabes=row.names(coef(model)),
                              values=as.numeric(round(coef(model),4)))
        coeftable<-coeftable<-coeftable[order(abs(coeftable$value),
                                              decreasing = TRUE),]
        return(list(mae=f_mae,rmse=f_rmse,r2=f_r2,coef=head(coeftable,6)))
        
}