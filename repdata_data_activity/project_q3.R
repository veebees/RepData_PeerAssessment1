#Loading and Preprocessing the data
actvty<-read.csv("activity.csv", header = T, na.strings = "NA")

#Omitting na and missing values
actvty1<-na.omit(actvty)

print("The number of missing values (NA) is ")
print(nrow(actvty) - nrow(actvty1))

# #Aggregating average of steps as per interval
actvty1_2<-aggregate(actvty1$steps, by = list(actvty1$interval), FUN = mean)
colnames(actvty1_2)<- c("interval_2", "avg.steps")


actvty1_2_a<- do.call("rbind", replicate(61, actvty1_2, simplify = FALSE))
actvty1_3 <- cbind(actvty)
suppressWarnings(actvty1_3$steps[is.na(actvty1_3$steps)] <- actvty1_2_a$avg.steps)

#Aggregating steps as per dates
actvty1_3_a<-aggregate(actvty1_3$steps, by = list(actvty1_3$date),
                       FUN = sum)
colnames(actvty1_3_a)<- c("date", "total.steps")

# Creating histogram
hist(actvty1_3_a$total.steps, col = "yellow", main = "Histogram of Total Steps",
     xlab = "Total Steps", ylab = "Number of days")

#Calculating and reporting mean and median
print("The mean is ") 
print(mean(actvty1_3_a$total.steps))
print('The median is ')
print(median(actvty1_3_a$total.steps))

print("The mean after replacing the NA values remains the same but")
print("the median increases and is now equal to the mean.")

