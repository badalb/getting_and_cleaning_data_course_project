library(plyr)

# Download dataset to sampledata directory

if(!file.exists("./sampledata")){dir.create("./sampledata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./sampledata/Dataset.zip")

# Unzip dataSet to /sampledata directory
unzip(zipfile="./sampledata/Dataset.zip",exdir="./sampledata")


# Merge  training and the test sets to create one data set:
# Reading trainings tables
x_train <- read.table("./sampledata/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./sampledata/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./sampledata/UCI HAR Dataset/train/subject_train.txt")
      
# Reading testing tables
x_test <- read.table("./sampledata/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./sampledata/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./sampledata/UCI HAR Dataset/test/subject_test.txt")
      
# Reading feature vector
features <- read.table('./sampledata/UCI HAR Dataset/features.txt')
      
# Reading activity labels
activityLabels = read.table('./sampledata/UCI HAR Dataset/activity_labels.txt')
      
# Assigning column names
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
      
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
      
colnames(activityLabels) <- c('activityId','activityType')
      
# Merging all data in one set:
 mrg_train <- cbind(y_train, subject_train, x_train)
 mrg_test <- cbind(y_test, subject_test, x_test)
 setAllInOne <- rbind(mrg_train, mrg_test)


# Extract only the measurements on the mean and standard deviation for each measurement

#Read column names
colNames <- colnames(setAllInOne)

# Create vector for defining ID, mean and standard deviation
mean_and_std <- (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
      
# Make nessesary subset from setAllInOne
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
      
# Use descriptive activity names to name the activities in the data set
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                                   by='activityId',
                                   all.x=TRUE)
        
# Create a second, independent tidy data set with the average of each variable for each activity and each subject 
      
# Make second tidy data set 
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
      
# Write second tidy data set in txt file
write.table(secTidySet, "sec_tidy_data _set.txt", row.name=FALSE)