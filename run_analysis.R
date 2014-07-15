# This script tidies up data from the UCI HAR dataset and outputs a tidy dataset,
# containing averages of the summary variables (mean and std) generated during
# the HAR experiment. For information about the original UCI HAR data, important 
# decisions and assumptions during the cleaning process and variable descriptions
# of the resulting tidy dataset please refer to the Code Book.

# Loading necessary packages.
require(plyr)

# Step 1: Collect all parts of the experiment data in one continuous dataset.

# Step 1.1: Read-in the train data (70% of the experiment data) and add the 
# corresponding Subject and Activity codes.
train <- read.table("./UCI HAR Dataset/train/X_train.txt", nrows = 7352, 
                    colClasses = "numeric", comment.char = "")
subjectsTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
activitiesTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
train <- cbind(subjectsTrain, activitiesTrain, train)

# Step 1.2: Read-in the test data (30% of the experiment data) and add the 
# corresponding Subject and Activity codes.
test <- read.table("./UCI HAR Dataset/test/X_test.txt", nrows = 2947,
                   colClasses = "numeric", comment.char = "")
subjectsTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activitiesTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
test <- cbind(subjectsTest, activitiesTest, test)

# Step 1.3: Create one dataset containing all the data for further cleaning.
dataSet <- rbind(train, test)

# Step 2: Replace the Activity codes with descriptive names.
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
dataSet[, 2] <- as.factor(dataSet[, 2])
levels(dataSet[, 2]) <- activities[, 2]

# Step 3: Read in the variable names, select the summary variables
# (ending in mean() and std(), check the Code Book for further information)
# and subset the dataset.
variables <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
variables$V3 <- grepl("mean()", variables$V2, fixed = TRUE)
variables$V4 <- grepl("std()", variables$V2, fixed = TRUE)
extract <- which(variables$V3 == TRUE | variables$V4 == TRUE)
dataSet <- dataSet[, c(1, 2, extract +2)]

# Step 4: Create descriptive variable names (for transformation logic, please
# refer to the Code Book) and associate with the dataset.
varNames <- variables$V2[extract]
varNames <- sub("^t", "TimeSignals", varNames)
varNames <- sub("^f", "FrequencySignals", varNames)
varNames <- sub("Acc", "Acceleration", varNames)
varNames <- sub("Gyro", "Velocity", varNames)
varNames <- sub("Mag", "Magnitude", varNames)
varNames <- sub("-X", "Xaxis", varNames)
varNames <- sub("-Y", "Yaxis", varNames)
varNames <- sub("-Z", "Zaxis", varNames)
varNames <- sub("-mean\\(\\)", "MeanValue", varNames)
varNames <- sub("-std\\(\\)", "StandardDeviation", varNames)
varNames <- sub("BodyBody", "Body", varNames)
names(dataSet) <- c("Subject", "Activity", varNames)

# Step 5: Create a new dataset with averages of the selected variables for each
# Subject/Activity pair and write it into tidy.txt.
tidyData <- ddply(dataSet, c("Subject", "Activity"), numcolwise(mean))
write.table(tidyData, file = "tidy.txt")