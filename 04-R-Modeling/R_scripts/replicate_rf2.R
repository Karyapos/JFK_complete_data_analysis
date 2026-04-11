#This part of code is ONLY executable after you run evaluation_function.R
#and code_phase4.R

scores<- replicate(30,{ train_idx<-sample(seq_len(n),0.8*n) 
rf2_train<-data[train_idx,] 
rf2_test<-data[-train_idx,]
rf2<-randomForest(taxi_out~., data=rf2_train, mtry=6, importance=TRUE, maxnodes=500, nodesize=150) 
evaluation(rf2,rf2_test)
},
simplify=FALSE)

mean_mae  <- mean(sapply(scores, function(x) x$mae))
mean_rmse <- mean(sapply(scores, function(x) x$rmse))
mean_r2   <- mean(sapply(scores, function(x) x$r2))

c(mean_mae = mean_mae,
  mean_rmse = mean_rmse,
  mean_r2 = mean_r2)
