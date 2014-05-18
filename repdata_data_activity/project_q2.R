#Loading and Preprocessing the data
actvty<-read.csv("activity.csv", header = T, na.strings = "NA") 


# What is mean total number of steps taken per day? Ignore missing values
#Omitting na and missing values
actvty1<-na.omit(actvty)

#Aggregating steps as per interval
actvty1_2<-aggregate(actvty1$steps, by = list(actvty1$interval), FUN = mean)
colnames(actvty1_2)<- c("interval", "avg.steps")

#drawing time series plot for average steps during an interval across all days
plot(actvty1_2$interval, actvty1_2$avg.steps, type = "l")

#calculating and reporting max interval
print(actvty1_2[which.max(actvty1_2$avg.steps),1])
