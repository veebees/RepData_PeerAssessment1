#Loading and Preprocessing the data
actvty<-read.csv("activity.csv", header = T, na.strings = "NA")

#Omitting na and missing values
actvty1<-na.omit(actvty)


# #Aggregating average of steps as per interval
actvty1_2<-aggregate(actvty1$steps, by = list(actvty1$interval), FUN = mean)
colnames(actvty1_2)<- c("interval_2", "avg.steps")

# replicating the aggregated dataframe to make it equal to the original df
actvty1_2_a<- do.call("rbind", replicate(61, actvty1_2, simplify = FALSE))

actvty1_3 <- cbind(actvty)
# Replacing NA values with average values for intervals
suppressWarnings(actvty1_3$steps[is.na(actvty1_3$steps)] <- actvty1_2_a$avg.steps)

#Introducing weekend variable into the dataframe
wkDayEnd<-data.frame(wkday = weekdays(as.Date(actvty1_3$date)), 
                     wkEnd = "")
wkDayEnd$wkEnd<- wkDayEnd$wkday == "Saturday" | wkDayEnd$wkday =="Sunday"
actvty1_4<- cbind(actvty1_3, wkDayEnd)
#subsetting for weekend and weekdays
actvty1_4_wdy<- subset(actvty1_4, wkEnd == F)
actvty1_4_wnd<- subset(actvty1_4, wkEnd == T)
#Aggregating steps as per dates

actvty1_4_wdy_a<-aggregate(actvty1_4_wdy$steps, by = list(actvty1_4_wdy$interval),
                       FUN = mean)
actvty1_4_wnd_a<-aggregate(actvty1_4_wnd$steps, by = list(actvty1_4_wnd$interval),
                           FUN = mean)
colnames(actvty1_4_wdy_a)<- c("Interval", "avg.steps")
colnames(actvty1_4_wnd_a)<- c("Interval", "avg.steps")
#adding weekday/weekend to aggregated data 
actvty1_4_wdy_aa<- cbind(actvty1_4_wdy_a, wknd = "Weekday")
actvty1_4_wnd_aa<- cbind(actvty1_4_wnd_a, wknd = "Weekend")
#combining aggregated data frames
actvty1_4_wdywnd<-rbind(actvty1_4_wdy_aa, actvty1_4_wnd_aa)

#drawing plot
library(lattice)

d<-xyplot(avg.steps ~ Interval | wknd, data = actvty1_4_wdywnd, type = "l", layout = c(1,2))
print(d)

