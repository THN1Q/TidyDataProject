# Course Project for "Getting and Cleaning Data", JHU Data Science Specialization

This repo contains R script and Code Book for the preparation of a tidy data set using the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Project overview

This project uses a Human Activity Recognition database from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html). The dataset contains recordings of a series of experiments, mapping the movements of 30 subjects against the measurement of an accelerometer and gyroscope embedded in a waist-mounted mobile device (Samsung Galaxy S II). The goals of the project are:

1. To collect the recordings of all 30 subjects participating in the experiment in one continuous dataset.
2. To extract only summary variables (mean values and standard deviation) from the original list of 561 variables and to provide descriptive names for the selected variables.
3. To output a new tidy dataset containing averages of the selected summary variables for each subject/activity pair.

## Running the script

 1. Download the [data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extract in your R working directory (*running `getwd()` in R console will help you locate it*). At this point you should have a ***UCI HAR Dataset*** folder in your working directory, exactly reflecting the `UCI HAR Dataset.zip` structure.
 2. Run the R script `run_analysis.R` found in this repo; required libraries for running the script: `plyr` (*`install.packages("plyr")`*)
 3. The tidy dataset will be output in your working directory as `tidy.txt`
 4. Information about the original UCI HAR data, important decisions and assumptions during the cleaning process and variable descriptions of the resulting tidy dataset can be found in the [Code Book](https://github.com/THN1Q/TidyDataProject/blob/master/CodeBook.md).