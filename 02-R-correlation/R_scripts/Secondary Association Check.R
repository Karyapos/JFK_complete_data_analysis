library(lsr)
library(infotheo)
library(vcd)
data<-read.csv2("most_effective_vars.csv",header = TRUE,sep = ",")

#departures~destination
assocstats(table(data$departures_5tile,data$destination))
model<-aov(departures~destination, data = data)
etaSquared(model)
kruskal.test(departures ~ destination, data = data)
mutinformation(discretize(data$departures_5tile), data$destination)

#departures~wind
assocstats(table(data$departures_5tile,data$wind))
model<-aov(departures~wind, data = data)
etaSquared(model)
kruskal.test(departures ~ wind, data = data)
mutinformation(discretize(data$departures_5tile), data$wind)

