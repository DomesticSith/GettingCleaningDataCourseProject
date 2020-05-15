library(dplyr)
library(tidyr)
## Set variables to be used in script
featureselect <- "(mean|std)\\(\\)"
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

##Download file from cloud location if required and unzip
if(!file.exists("Dataset.zip")){ download.file(fileurl, "Dataset.zip", method = "curl") }
if(!file.exists("./UCI HAR Dataset")){ unzip("Dataset.zip") }

##Read in reference data
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("activityid", "activity"), colClasses = "character")
features <- read.table("./UCI HAR Dataset/features.txt",col.names = c("featureid", "feature"), colClasses = "character")
featuresreduced <- features[grepl(featureselect, features$feature),]

##Read in test data, reduce and add labels & subjects
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(testdata) <- features$featureid          #feature itself is too long to provide unique names for a search so use featureid
testreduced <- select(testdata, featuresreduced$featureid)

testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("activityid"), colClasses = "character")
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subjectid"))

testfinal <- cbind(testlabels, testsubject, testreduced) 

##Read in training data, reduce and add labels & subjects
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(traindata) <- features$featureid         #feature itself is too long to provide unique names for a search so use featureid
trainreduced <- select(traindata, featuresreduced$featureid)

trainlabels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("activityid"), colClasses = "character")
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subjectid"))

trainfinal <- cbind(trainlabels, trainsubject, trainreduced) 

##Merge test & train data, name activities, gather in to long format
summarydata <- rbind(testfinal, trainfinal) %>%
            gather("variable", "value", -(activityid:subjectid)) %>%
            mutate(activityid = activitylabels[activityid,2], variable = featuresreduced[variable, 2]) %>%
            rename(activity = activityid) %>%
            group_by(activity,subjectid,variable) %>%
            summarise(mean(value))

##Write output to file
write.table(summarydata,"summarydata.txt")


