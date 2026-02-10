lasso<-function(x,y){
        n<-nrow(x)
        set.seed(1542)
        train_idx<-sample(seq_len(n),size = 0.8*n)
        x_train<-x[train_idx,]
        y_train<-y[train_idx]
        x_test<-x[-train_idx,]
        y_test<-y[-train_idx]
        cv_model<-cv.glmnet(x_train,y_train)
        lambda<-cv_model$lambda.min
        
        
        model<-glmnet(x_train,y_train,lambda=lambda)
        
        f_pred<-predict(model,newx = x_test,s=lambda)
        f_mae<-mae(y_test,f_pred)
        f_rmse<-rmse(y_test,f_pred)
        f_ss_res<-sum((y_test-f_pred)^2)
        f_ss_tot<-sum((y_test-mean(y_test))^2)
        f_r2<-1-f_ss_res/f_ss_tot
        
        coeftable<-data.frame(variabes=row.names(coef(model)),
                              values=as.numeric(round(coef(model),4)))
        coeftable<-coeftable[order(abs(coeftable$values),
                                   decreasing = TRUE),]
        return(list(mae=f_mae,rmse=f_rmse,r2=f_r2,coef=head(coeftable,6)))
        
}