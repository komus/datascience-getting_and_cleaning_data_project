
#create a file Run_Analysis.R, then save the file in the location where the dataset has been extracted
# set the working directory to the current folder that is working
#read all the data from the the textfile given in the dataset
xtrain <- read.table('./train/x_train.txt',header=FALSE);
ytrain<- read.table('./train/y_train.txt', header=FALSE);
subjecttrain <-read.table('./train/subject_train.txt', header=FALSE);
xtest <- read.table('./test/X_test.txt', header=FALSE);
ytest <- read.table('./test/y_test.txt', header=FALSE);
subjecttest <- read.table('./test/subject_test.txt', header=FALSE);
#merging the data, we ll use rbind function
  ## merging the datas from the train folder
mergeX = rbind(xtest, xtrain);
mergeY = rbind(ytest, ytrain);
mergeSubject = rbind(subjecttrain,subjecttest);
  ##merge the two merge using row bind
mergefinal = cbind(mergeX, mergeY);
##output the merge data to a textfile called finalmergeoutput
write.table(mergefinal, "FinalTestOutput.txt", row.name=FALSE )

#solvinf the second question
#reading the features table
features <- read.table("features.txt");
#MeanStd <- grep("-(mean|std)\\(\\)", features[, 2]);
MeanStd <-  grep(".*Mean.*|.*Std.*", features[,2])
mergeX <- mergeX[, MeanStd];
names(mergeX) <- features[MeanStd, 2]
names(mergeX) <- gsub("\\(|\\)", "", names(mergeX))
names(mergeX) <- tolower(names(mergeX))

#solving the third question
activity <- read.table("activity_labels.txt")
activity[, 2] = gsub("_", "", tolower(as.character(activity[, 2])))
mergeY[,1] <- activity[mergeY[,1], 2]
names(mergeY) <- "activity"

#solving the fourth and fifth question
names(mergeSubject) <- "subject"
mergefinal <- cbind(mergeX, mergeY, mergeSubject);
write.table(mergefinal, "tidydatadone12.txt")
#creating avg
#load library plyr
library(plyr)
averagemergefinal <- ddply(mergefinal, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averagesmergefinal, "tidydata.txt", row.name=FALSE)
