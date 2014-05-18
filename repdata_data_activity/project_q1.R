#Loading and Preprocessing the data
actvty<-read.csv("activity.csv", header = T, na.strings = "NA") 
 
# What is mean total number of steps taken per day? Ignore missing values
#Omitting na and missing values
actvty1<-na.omit(actvty)

#Aggregating steps as per dates
actvty1_a<-aggregate(actvty1$steps, by = list(actvty1$date), FUN = sum)
colnames(actvty1_a)<- c("date", "total.steps")

# Creating histogram
hist(actvty1_a$total.steps, col = "yellow", main = "Histogram of Total Steps",
     xlab = "Total Steps", ylab = "Number of days")

#Calculating and reporting mean and median
print(mean(actvty1_a$total.steps))
print(median(actvty1_a$total.steps))



