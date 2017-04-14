# load the packages that we needs for this job.
library(data.table)
library(dplyr)

#load and read the data sets activity_labels and features.
actl <- read.table('C:/Users/usuario/Desktop/UCI HAR Dataset/activity_labels.txt')
feat <- read.table('C:/Users/usuario/Desktop/UCI HAR Dataset/features.txt')
actl <- actl[,2]
feat <- feat[,2]

#working with test data set.
#load and read the files: X_test, y_test, and subject_test.
# uses read.table for this action, also it can read .txt files.
x.test <- read.table('C:/Users/usuario/Desktop/UCI HAR Dataset/test/X_test.txt')
y.test <- read.table('C:/Users/usuario/Desktop/UCI HAR Dataset/test/y_test.txt')
s.test <- read.table('C:/Users/usuario/Desktop/UCI HAR Dataset/test/subject_test.txt')

# put the names of the features and save it that contain mean and std.
names(x.test) <- feat
features <- grepl("mean|std", feat)
x.test <- x.test[,features]

#create a new variable, and rename it.
y.test[,2] <- actl[y.test[,1]]
names(y.test) <- c("Activity_ID", "Activity_Label")
names(s.test) <- "subject"

#bind the test data.
test.data <- cbind(as.data.table(s.test), y.test, x.test)

#working with train data set.
##load and read the files: X_test, y_test, and subject_test.
x.train <- read.table('C:/Users/usuario/Desktop/UCI HAR Dataset/train/X_train.txt')
y.train <- read.table('C:/Users/usuario/Desktop/UCI HAR Dataset/train/y_train.txt')
s.train <- read.table('C:/Users/usuario/Desktop/UCI HAR Dataset/train/subject_train.txt')

# put the names of the features and save it that contain mean and std.
names(x.train) <- feat
x.train <- x.train[,features]

#create a new variable, and rename it.
y.train[,2] <- actl[y.train[,1]]
names(y.train) <- c("Activity_ID", "Activity_Label")
names(s.train) <- "subject"

#bind the train data.
train.data <- cbind(as.data.table(s.train), y.train, x.train)

# join the test and train data by rows.
data <- rbind(test.data,train.data)

#create and write the tidy data with the means of the variables.
tidy.data <- data %>% group_by(subject,Activity_Label) %>% summarize_each('mean',`tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-meanFreq()`)

write.table(tidy_data, file = "C:/Users/usuario/Desktop/UCI HAR Dataset/tidy.data.txt")


