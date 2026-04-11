library(vcd)
data<-read.csv2("most_effective_vars.csv",header = TRUE,sep = ",")
list<-c("flight_code","departures_5tile","carrier","destination","wind")
cramers_matrix<- function(variables){
        n<-length(variables)
        mat<-matrix(data=NA,n,n)
        colnames(mat)<-rownames(mat)<-variables
        for(i in 1:n){
                for(j in 1:n){
                        if ( i != j){
                                tab<-table(data[[variables[[i]]]],data[[variables[[j]]]])
                                mat[i,j]<-assocstats(tab)$cramer
                        }
                }
        }
        return(mat)
}
cramer<-as.data.frame (cramers_matrix(list))