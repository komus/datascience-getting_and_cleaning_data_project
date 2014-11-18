#create a file Run_Analysis.R, then save the file in the location where the dataset has been extracted
# set the working directory to the current folder that is working
#read all the data from the the textfile given in the dataset
xtrain <- read.table('./train/x_train.txt',header=FALSE);
ytrain<- read.table('./train/y_train.txt', header=FALSE);
subjecttrain <-read.table('./train/subject_train.txt', header=FALSE);
xtest <- read.table('./test/X_test.txt', header=FALSE);
ytest <- read.table('./test/y_test.txt', header=FALSE);
subjecttest <- read.table('./test/subject_test.txt', header=FALSE);
#merging the data, we ll use cbind function
  ## merging the datas from the train folder
mergeTest = cbind(subjecttest,xtest, ytest);
mergeTrain = cbind(subjecttrain, xtrain, ytrain);
  ##merge the two merge using row bind
mergefinal = rbind(mergeTest, mergeTrain);
##output the merge data to a textfile called finalmergeoutput
write.table(mergefinal, "FinalTestOutput.txt", row.name=FALSE )

#solvinf the second question
reading the features table
features <- read.table("features.txt");
MeanStd <- grep("-(mean|std)\\(\\)", features[, 2]);
mergeTest <- mergeTest[, MeanStd];
names(mergeTest) <- features[MeanStd, 2]

#solving the third question
activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
mergeTrain[,1] = activities[mergeTrain[,1], 2]
names(mergeTrain) <- "activity"

#solving the fourth and fifth question

names(S) <- "subject"
mergefinal <- rbind(mergeTest, mergeTrain);
write.table(mergefinal, "tidydatadone.txt")
