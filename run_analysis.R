Student: Muhammad Azfar Faizan 			   
######################################################

# Cleaning the workspace
rm(list=ls())

################# Section 1 #########################

#Step 1: Setting the directory
setwd('/Users/hp/Downloads/UCI HAR Dataset/');

# Step 2: Reading the data from directory and also training data which include data in .txt files
features     = read.table('./features.txt',header=FALSE); 
activityType = read.table('./activity_labels.txt',header=FALSE); 
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); 
xTrain       = read.table('./train/x_train.txt',header=FALSE); 
yTrain       = read.table('./train/y_train.txt',header=FALSE); 

# Step 3: Assiging column names in training data
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";

# Step 4: Merging all training data imported from training folder
trainingData = cbind(yTrain,subjectTrain,xTrain);

# Step 5: Read in the test data from test
subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

# Step 6: Assigning column names in testing data
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";


# Step 7: Merging all testing data imported from test folder
testData = cbind(yTest,subjectTest,xTest);


# Step 8: Merging training and test data to create a final data set
finalData = rbind(trainingData,testData);

# Step 9: Vector for the column names from the finalData, for setting up mean and stddev columns
colNames  = colnames(finalData); 


################# Section 2 #####################

# Step 1: Logical Vector that containing TRUE values for mean and stddev
LV = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Step 2: Storing subset in a new table
finalData = finalData[LV ==TRUE];


################# Section 3 #####################

# Step 1: Merging finalData with the acitivityType table 
finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);

# Step 2: Updating colNames vector for adding new column names 
colNames  = colnames(finalData); 

################# Section 4 #####################

# Step 1: Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Step 2: Reassigning the new descriptive column names to the finalData set
colnames(finalData) = colNames;

################# Section 5 #####################

# Step 1: Storing in a new table, finalDataNoActivityType without the activityType column
finalDataNoActivityType  = finalData[,names(finalData) != 'activityType'];

# Step 2: Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
NewCleanedData    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);

# Step 3: Merging the tidyData with activityType to include descriptive acitvity names
NewCleanedData= merge(NewCleanedData,activityType,by='activityId',all.x=TRUE);

# Step 4: Writing NewCleanedData set in a text file
write.table(NewCleanedData, './NewCleanedData.txt',row.names=TRUE,sep='\t');
