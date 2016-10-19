# Getting and Cleaning Data Course Project

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

#Step 1.
 Download dataset to sampledata directory
 Unzip dataSet to /sampledata directory

#Step 2.
 Merge  training and the test sets to create one data set:
 Read trainings tables
 Read testing tables
 Read feature vector
 Read activity labels
 Assign column names
 Merging all data in one set

#Step 3.
Extract only the measurements on the mean and standard deviation for each measurement
Create vector for defining ID, mean and standard deviation
Make nessesary subset from setAllInOne

#Step 4.
Use descriptive activity names to name the activities in the data set
Create a second, independent tidy data set with the average of each variable for each activity and each subject 

#Step 5.
Make second tidy data set
Write second tidy data set in txt file

The result is shown in attached sec_tidy_data _set.txt file