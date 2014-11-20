## This script assumes that the folder /UCI HAR Dataset containing 
## the Samsung activity data resides in the working directory

library(dplyr)
library(plyr)

## Read the activity labels.
activityLabels <- read.table("./UCI HAR DataSet/activity_labels.txt")
names(activityLabels) <- c("index","description")

## Read the features file.
## These are the column names of the test and training files.
columnNames <- read.table("./UCI HAR DataSet/features.txt")
names(columnNames) <- c("index", "description")

## Clean up the column names
columnNames$description <- sub("()","",columnNames$description,
   fixed = TRUE)
columnNames$description <- sub("BodyBody", "Body",
   columnNames$description, fixed = TRUE)
columnNames$description <- make.names(columnNames$description)

## Read the test files. There are 3.
subjectTest <- read.table("./UCI HAR DataSet/test/subject_test.txt")
names(subjectTest) <- "subject"

activityTest <- read.table("./UCI HAR DataSet/test/y_test.txt")
names(activityTest) <- "activity"

dataTest <- read.table("./UCI HAR DataSet/test/X_test.txt")
names(dataTest) <- columnNames$description

## Read the training files. There are 3.
subjectTrain <- read.table("./UCI HAR DataSet/train/subject_train.txt")
names(subjectTrain) <- "subject"

activityTrain <- read.table("./UCI HAR DataSet/train/y_train.txt")
names(activityTrain) <- "activity"

dataTrain <- read.table("./UCI HAR DataSet/train/X_train.txt")
names(dataTrain) <- columnNames$description

## Combine the subject, activity, and data frames into a single
## data frame for both training and test data
dataTest <- cbind(subjectTest, activityTest, dataTest)
dataTrain <- cbind(subjectTrain, activityTrain, dataTrain)

## Combine the test and training data into a single data frame
data <- rbind(dataTest, dataTrain)

## Create factors from the subject and activity columns
## Level the activity factors with activityLabels
data$subject <- as.factor(data$subject)
data$activity <- as.factor(data$activity)
levels(data$activity) <- activityLabels$description

## Extract the columns containing mean and std data
## Identify the columns with mean and std data
colExtract <- sort(c(grep(".mean",names(data), fixed = TRUE)
   ,grep(".std",names(data), fixed = TRUE)))
dataExtract <- data[,c(1,2,colExtract)]

## Identify the columns with Freq data for removal
colFreq <- grep("Freq", names(dataExtract), fixed = TRUE)
dataExtract <- dataExtract[,-colFreq]

## Calculate the mean of each column,
## grouped by subject and activity
dataSummary <- dataExtract%>% group_by(subject, activity) %>%
   summarise_each(funs(mean))

## Write the tidy data to a file
write.table(dataSummary, file = "dataSummary.txt",
            row.names = FALSE, sep = ",")