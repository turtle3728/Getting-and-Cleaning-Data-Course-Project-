# Getting-and-Cleaning-Data-Course-Project-

* This is the course project for the Getting and Cleaning Data Coursera course.
* The included R script, run_analysis.R, conducts the following:
1. Download the dataset from web if it does not already exist in the working directory.
2. Read both the train and test datasets and merge them into x, y and subject respectively. Also, change all of column names referring to activity labels.
3. Extract only measurements containing "mean" and "std". Also, change the order of columns to "code", "subject", "activity", ...
4. Load the data(x's) feature, activity info and extract columns named including 'mean' and 'standard'. Also, modify column names to descriptive activity names. (^t to time, ^f to frequency, Acc to Accelerometer, etc.)
5. Generate 'Final Dataset' that consists of the average (mean) of each variable for each subject and each activity groups. The result is shown in the file final_dataset.txt.
