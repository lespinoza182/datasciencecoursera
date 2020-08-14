Data used for run_analysys. R was downloades from UCI HAR Dataset
URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Variables:
  features <- features.txt
    Correspond to the accelerometer and gyroscope 3-axual raw signals
  activities <- activity_labels.txt
    List of activities that correspond to actions performed during measurements, as well as its codes
  subject_test <- subject_test.txt
  subject_train <- subject_train.txt
  x_test <- x_test.txt
  y_test <- y_test.txt
  x_train <- x_train.txt
  y_train <- y_train.txt
  
  x <- merge of x_train and x_test
  y <- merge of y_train and y_test
  subject <- merge of subject_train and subject_test
  dataset <- merge of subject, x and y
  
  tidy_data <- The subset of dataset by subject and code columns, and mean, std for each measurement
  
  Name replacement: 
  Words starting with t replaced w/ Time
  Words starting with f replaced w/ Frecuency
  Acc column replaced by Accelerometer
  Gyro column replaced by Gyroscope
  BodyBody column replaced by Body 
  Mag column replaced by Magnitude
  
  clean_dataset is the result of summarizing tidy_data
  CleanDataset.txt is the result of exporting clean_dataset