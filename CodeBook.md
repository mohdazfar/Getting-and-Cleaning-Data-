#CodeBook.md

###Data
Data was extracted from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Data was about wearable computing.  Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#TASKS
###Section 1
The following files were read and merged together create a complete dataset joining training and testing datasets.
- features.txt
- activity_labels.txt
- x_train.txt
- y_train.txt
- x_test.txt
- y_test.txt
- subject_train.txt
- subject_test.txt

###Section 2
Logical vector was created using "grepl()" which search for related pattern of words and return them if pattern is TRUE. So in our case measurements related to mean and std dev were gathered.

###Section 3
Merge data subset on the basis of activity ID.

###Section 4
Variables were name properly by removing any irrelevant names from the headers using "gsub()".

###Section 5
A new txt file was created "NewCleanedData.txt" which contained the clean data. It was done using write.table(). 
