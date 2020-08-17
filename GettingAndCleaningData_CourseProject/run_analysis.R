#Load library, download fine and unzip file
library(dplyr)
file <- "UCI_HAR_Dataset.zip"
furl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(furl, file)
unzip(file)

#Assignation of data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = "code")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names = "code")

#Step 1: Merge the training and test sets to create one data set
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
dataset <- cbind(subject, y, x)

#Step 2: Extract only the measurements on the mean and standard deviation for each measurement.
tidy_data <- dataset %>%
  select(subject, code, contains("mean"), contains("std"))

#Step3: Use descriptive activity names to name the activities in the data set.
tidy_data$code <- factor(tidy_data$code, ordered = TRUE, labels= c("LAYING", "SITTING", "STANDING", "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS"))

#Step4: Appropiately label the data set with descriptive variable names
names(tidy_data)[2] <- "Activity"
names(tidy_data) <- gsub("^t", "T", names(tidy_data))
names(tidy_data) <- gsub("^f", "Freq", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Acc", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyr", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Mag", names(tidy_data))
names(tidy_data) <- gsub("tBody", "tBody", names(tidy_data))
names(tidy_data) <- gsub("mean", "Mean", names(tidy_data))
names(tidy_data) <- gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-freq()", "Freq", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("angle", "Ang", names(tidy_data))
names(tidy_data) <- gsub("gravity", "Gr", names(tidy_data))
names(tidy_data) <- gsub(".._mean", "", names(tidy_data))
names(tidy_data) <- gsub("...X_mean", "", names(tidy_data))


#Step5: Creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject.
clean_dataset <- tidy_data %>%
  group_by(subject, Activity) %>%
  summarise_all(list(mean = mean))
clean_dataset <- clean_dataset[order(subject)]
write.table(clean_dataset, "CleanDataset.txt", row.names = FALSE, quote = FALSE)
