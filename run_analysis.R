## Preparing datasets

if(!file.exists("dataset.zip")){
  url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, "dataset.zip")
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip("dataset.zip") 
}

## Assigning all data frames

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","fun"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$fun)
y_train<-read.table("UCI HAR Dataset/train/y_train.txt",col.names = "code")

subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$fun)
y_test<-read.table("UCI HAR Dataset/test/y_test.txt",col.names = "code")

## 1. Merges the training and the test sets to create one data set.

x <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject,y,x)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

tidydata<-merged_data %>% 
  select(subject, code, contains("mean"),contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set.

tidydata<-tidydata %>% 
  merge(activities, by = "code")

# reordering column

names(tidydata)
refcols <- c("code", "subject", "activity")
tidydata <- tidydata[, c(refcols, setdiff(names(tidydata), refcols))]

## 4. Appropriately labels the data set with descriptive variable names.

names(tidydata)

names(tidydata)<-gsub("^t", "time", names(tidydata))
names(tidydata)<-gsub("^f", "frequency", names(tidydata))
names(tidydata)<-gsub("Acc", "Accelerometer", names(tidydata))
names(tidydata)<-gsub("Gyro", "Gyroscope", names(tidydata))
names(tidydata)<-gsub("Mag", "Magnitude", names(tidydata))
names(tidydata)<-gsub("BodyBody", "Body", names(tidydata))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)

melted_data<-melt(tidydata, id=c("subject","activity"))
final<-dcast(melted_data, subject+activity ~ variable, mean)

write.table(final, "final_dataset.txt", row.names = FALSE, quote = FALSE)
