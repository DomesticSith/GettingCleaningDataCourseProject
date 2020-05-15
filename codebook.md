# Codebook
## End Project Submission for the 
## "Getting and Cleaning Data" Course on Coursera

***
### Purpose of this document
This purpose of this document is to provide detail in three areas:  
1. The source of the raw data used in the course project  
2. The logic used to process that data in the run_analysis.R script  
3. The variables provided in the output file.  

***
### 1. Source of data


The data for the project has been downloaded from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available at the original source location:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Not every file in the dataset is used in this analysis; these are the files that are used and a brief description of their purpose.

File  | Purpose
------|-------------
activity_labels.txt | Provides meaningful labels to the numeric code for each activity tracked
features.txt | Provides meaningful labels for each variable measured and provided in the datasets
/test/X_test.txt | The data captured by the set of test subjects.  One row per observation, one column per variable measured (feature)
/test/y_test.txt | The activity ID linked to each observation in the X_test dataset
/test/subject_test.txt | The subject ID linked to each observation in the X_test dataset
/train/X_train.txt | The data captured by the set of training subjects.  One row per observation, one column per variable measured (feature)
/train/y_train.txt | The activity ID linked to each observation in the X_train dataset
/train/subject_train.txt  | The subject ID linked to each observation in the X_train dataset




***
### 2. Script Logic
The script needs to read the required files from the data provided, reduce the dataset to show only variables giving the mean or standard deviation for each measurementand then return an independent tidy dataset providing the average of each variable for each activity and each subject.  

To this end, the script is broken up into steps which are commented in the script file.  

**_Step 0. Set variables to be used in script_**  
Here we set the regex expression which is used to identify the measures to include in our output file.  By default we are looking for any measure which includes the string "mean()" or "std()" which specifically excludes any variables measuring meanFreq() or which use a mean variable as part of the parameters of their calculation such as angle(tBodyGyroJerkMean,gravityMean).  

We also provide the URL for retrieving the source data if it is not already present in the working directory. 

**_Step 1. Download file from cloud location if required and unzip_**  
Download the zip file if it is not present.  Unzip it if the folder does not exist.  

**_Step 2. Read in reference data_**  
Read the activity labels and features datasets.  Reduce the features dataset by applying the regex pattern to the variable name to leave only the feature ID and descriptions in which we are interested.  

**_Step 3. Read in test data, reduce and add labels & subjects_**  
Read in the X_test data and assign the feature IDs to the column names.  Select only the columns from the full X_test dataset where the feature ID is in the subset created in step 2 above.  

Read the activity labels and the subject data related to the test dataset.  

Use cbind() to combine the activity labels, subject IDs and test values for the test subject group.  

**_Step 4. Read in train data, reduce and add labels & subjects_**  
Repeat step 3 but with the train dataset instead of the test one.

**_Step5. Merge test & train data, name activities, gather in to long format._**  
Use rbind() to combine the final test and train datasets.  

Reshape the data into a long format such that each variable column becomes one row in the dataframe.  This allows us to mutate the feature ID from the column heading into the more descriptive label.  Having these descriptive names as variable values rather than column names is a deliberate choice as it allows greater readability of the long descriptions.  

The activity ID column is renamed to Activity and the numeric code is replaced with a text description.  

Finally, the data is grouped by activity, subject and variable and summarised with a mean calculation for each group.

**_Step 6. Write output to file_**  
Write the output to a text file.

***
### 3. Output File


Column | Name           |  Class 
-------|----------------|--------
1      | activity       | character (see below for 6 possible values)
2      | subjectid      | integer (range 1:30)
3      | variable       | character (see below for 66 possible values)
4      | mean(variable) | numeric


**activity possible values:**  
WALKING  
WALKING_UPSTAIRS  
WALKING_DOWNSTAIRS  
SITTING  
STANDING  
LAYING  

**variable possible values:**  
Please refer to the source location link above for a full description of each measurement.  
tBodyAcc-mean()-X  
tBodyAcc-mean()-Y  
tBodyAcc-mean()-Z  
tBodyAcc-std()-X  
tBodyAcc-std()-Y  
tBodyAcc-std()-Z  
tGravityAcc-mean()-X  
tGravityAcc-mean()-Y  
tGravityAcc-mean()-Z  
tGravityAcc-std()-X  
tGravityAcc-std()-Y  
tGravityAcc-std()-Z  
tBodyAccJerk-mean()-X  
tBodyAccJerk-mean()-Y  
tBodyAccJerk-mean()-Z  
tBodyAccJerk-std()-X  
tBodyAccJerk-std()-Y  
tBodyAccJerk-std()-Z  
tBodyGyro-mean()-X  
tBodyGyro-mean()-Y  
tBodyGyro-mean()-Z  
tBodyGyro-std()-X  
tBodyGyro-std()-Y  
tBodyGyro-std()-Z  
tBodyGyroJerk-mean()-X  
tBodyGyroJerk-mean()-Y  
tBodyGyroJerk-mean()-Z  
tBodyGyroJerk-std()-X  
tBodyGyroJerk-std()-Y  
tBodyGyroJerk-std()-Z  
tBodyAccMag-mean()  
tBodyAccMag-std()  
tGravityAccMag-mean()  
tGravityAccMag-std()  
tBodyAccJerkMag-mean()  
tBodyAccJerkMag-std()  
tBodyGyroMag-mean()  
tBodyGyroMag-std()  
tBodyGyroJerkMag-mean()  
tBodyGyroJerkMag-std()  
fBodyAcc-mean()-X  
fBodyAcc-mean()-Y  
fBodyAcc-mean()-Z  
fBodyAcc-std()-X  
fBodyAcc-std()-Y  
fBodyAcc-std()-Z  
fBodyAccJerk-mean()-X  
fBodyAccJerk-mean()-Y  
fBodyAccJerk-mean()-Z  
fBodyAccJerk-std()-X  
fBodyAccJerk-std()-Y  
fBodyAccJerk-std()-Z  
fBodyGyro-mean()-X  
fBodyGyro-mean()-Y  
fBodyGyro-mean()-Z  
fBodyGyro-std()-X  
fBodyGyro-std()-Y  
fBodyGyro-std()-Z  
fBodyAccMag-mean()  
fBodyAccMag-std()  
fBodyBodyAccJerkMag-mean()  
fBodyBodyAccJerkMag-std()  
fBodyBodyGyroMag-mean()  
fBodyBodyGyroMag-std()  
fBodyBodyGyroJerkMag-mean()  
fBodyBodyGyroJerkMag-std()  
 
