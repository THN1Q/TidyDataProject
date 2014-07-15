# Code Book

Structure:

1. Background information about the original dataset; 
2. Step-by-step description of the cleaning process and decisions taken
3. Description of the variables in the resulting tidy dataset.

## Background information

Data: [origin](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), [download location](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The Human Activity Recognition database has been created from the recordings of 30 volunteers within an age bracket of 19-48 years performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The measurements in the dataset are resulting from its embedded accelerometer and gyroscope that captured the 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

## Cleaning process

**Step 1: Collect all parts of the experiment data in one continuous dataset:** the original data has been randomly partitioned into two sets - train data (70% of the observations) and test data (30%). Additionally, the Activity and Subject labels for each observation are provided in separate files. The first part of the R script combines all of these parts into a single dataset, used in the next steps.

**Step 2: Replace the Activity codes with descriptive names:** once all of the data has been put together, the coding (1-6) for each of the activities is replaced with the descriptive activity names provided in the data package and listed above.

**Step 3: Extract only summary variables (mean and std) for further manipulation:** for the purpose of the project, we need only the variables containing the mean and standard deviation for each measurement. To this end only variables containing `mean()` and `std()` are selected. This ensures the presence of only one type of variables in the tidy data set, namely mean and standard deviation values of each measurement (on each axis where applicable). Other variables containing `mean` (e.g. `fBodyGyro-meanFreq()-Z`) contain different data (e.g. mean frequency, not mean of the particular z-axis measurement) and therefore would violate the tidy data principle **Each type of observational unit forms a table.** For indepth discussion of the tidy data principles please refer to Hadley Wickham's [Tidy Data paper](http://vita.had.co.nz/papers/tidy-data.pdf).

**Step 4: Create descriptive variable names for each of the variables in the subset:** for the purpose of better human readability the following 3 steps are taken: 

1. expand any abbreviations into full words, e.g. `t` -> `TimeSignals`; `Acc` -> `Acceleration`, `Gyro` -> `Velocity` (as the measurement taken by the Gyroscope is *3-axial angular velocity*); '-X' -> `Xaxis`, etc.;
2. due to the resulting length of the variables CamelCase is used to increase readability;
3. illegal characters (e.g. `()`) and coding mistakes in the original dataset, e.g. (`BodyBody`, instead of `Body`) have been removed. 

**Step 5: Create a new tidy dataset with averages of the selected summary variables for each Subject/Activity pair and write it into tidy.txt:** for the final averaging the variables is used `ddply` in combination with `numcolwise`. The resulting dataset has 180 rows (30 subjects * 6 activities), i.e. each observation forms a row, and 68 variables (the ID pair + 66 measurement averages), i.e. each variable forms. As discussed in **Step 3** the subsetting of the original dataset follows the principle that a table/dataset should contain exactly one type of observational unit. According to the above we consider this a tidy dataset and after executing the R script it will be stored in `tidy.txt` file in your working directory.

## Variable descriptions

The variables selected from the original database come from the accelerometer and gyroscope 3-axial raw signals TimeSignalsAccelerationXYZaxis and TimeSignalsVelocityXYZaxis. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeSignalsBodyAccelerationXYZaxis and TimeSignalsGravityAccelerationXYZaxis) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeSignalsBodyAccelerationJerkXYZaxis and TimeSignalsBodyVelocityJerkXYZaxis). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeSignalsBodyAccelerationMagnitude, TimeSignalsGravityAccelerationMagnitude, TimeSignalsBodyAccelerationJerkMagnitude, TimeSignalsBodyVelocityMagnitude, TimeSignalsBodyVelocityJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FrequencySignalsBodyAccelerationXYZaxis, FrequencySignalsBodyAccJerkXYZaxis, FrequencySignalsBodyGyroXYZaxis, FrequencySignalsBodyAccelerationMagnitude, FrequencySignalsBodyAccelerationJerkMagnitude, FrequencySignalsBodyVelocityMagnitude, FrequencySignalsBodyVelocityJerkMagnitude. 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- TimeSignalsAccelerationXYZaxis
- TimeSignalsGravityAccelerationXYZaxis
- TimeSignalsBodyAccelerationJerkXYZaxis
- TimeSignalsVelocityXYZaxis
- TimeSignalsBodyVelocityJerkXYZaxis
- TimeSignalsBodyAccelerationMagnitude
- TimeSignalsGravityAccelerationMagnitude
- TimeSignalsBodyAccelerationJerkMagnitude
- TimeSignalsBodyVelocityMagnitude
- TimeSignalsBodyVelocityJerkMagnitude
- FrequencySignalsBodyAccelerationXYZaxis
- FrequencySignalsBodyAccelerationJerkXYZaxis
- FrequencySignalsBodyVelocityXYZaxis 
- FrequencySignalsBodyAccelerationMagnitude
- FrequencySignalsBodyAccelerationJerkMagnitude
- FrequencySignalsBodyVelocityMagnitude
- FrequencySignalsBodyVelocityJerkMagnitude

The tidy dataset contains **average values (means)** of the following variables for each of these signals (for each axis of these signals where relevant):

- MeanValue
- StandardDeviation.