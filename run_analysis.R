library(stringr)

# ---EXTRACT ALL THE DATA---
# 1 Test data  
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# 2 Train data
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# 3 Reference data
features <- read.table("UCI HAR Dataset/features.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt")

# ---MERGE DATA---
# 4 Union similiar tables
x <- rbind(xtrain,xtest)
y <- rbind(ytrain,ytest)
subject <- rbind(subject_train,subject_test)

# 5 Filter columns
head_filter <- str_detect(features[[2]],"std()") | str_detect(features[[2]],"mean()")
names(x) <- features[[2]]
x <- x[,head_filter]

# 6 Binding data
names(subject) <- "subject"
names(y) <- "cod_activity"
x <- cbind(subject,y,x)

# 7 Join reference data
names(activity) <- c("cod_activity", "activity")
x <- merge(x = activity, y = x, by.x="cod_activity", by.y="cod_activity", all=TRUE)

# 8 Set descriptive variable names
pat <- c("tBodyAcc-","tGravityAcc-","tBodyAccJerk-","tBodyGyro-","tBodyGyroJerk-","tBodyAccMag-","tGravityAccMag-","tBodyAccJerkMag-","fBodyAcc-","fBodyAccJerk-","fBodyGyro-","fBodyAccMag-","fBodyBodyAccJerkMag-","fBodyBodyGyroMag-","fBodyBodyGyroJerkMag-","mean","std","meanFreq","-X","-Y","-Z")
desc <- c("Time.Body.Accelerometer.","Time.Gravity.Accelerometer.","Time.Body.Accelerometer.Jerk.","Time.Body.Gyroscope.","Time.Body.Gyroscope.Jerk.","Time.Body.Accelerometer.Magnitude.","Time.Gravity.Accelerometer.Magnitude.","Time.Body.Accelerometer.Jerk.Magnitude.","Frequency.Body.Accelerometer.","Frequency.Body.Acceleromenter.Jerk.","Frequency.Body.Gyroscope.","Frequency.Body.Accelerometer.Magnitude.","Frequency.Body.Body.Accelerometer.Jerk.Magnitude.","Frequency.Body.Body.Gyroscope.Magnitude.","Frequency.Body.Body.Jerk.Magnitude.","Mean","Std","MeanFrequency",".X",".Y",".Z")

for(i in 1:length(pat)){
  names(x) <- str_replace(names(x),pat[i],desc[i])
}

# 9 creates a second, independent tidy data set with the average of each variable for each activity and each subject 
x5 <- aggregate(x = x[,-which(names(x) %in% c("activity", "subject","cod_activity"))], by = list(activity = x$activity, subject= x$subject),FUN = mean)

