## About
This repo contains files for processing UCI Har Dataset.

## Files description

###### run_analysis.R
Processes data from UCI Har Dataset files. These dataset files must be located in the same directory as this file to work properly. Output filename will be averaged-data.txt. Dataset could be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###### codebook.md
Contains description with variables of output file.

###### README.md
This file.

## Processing and analysis procedure
There are two datasets for data – train and test. For each dataset data was taken from X\_train.txt and X\_test.txt files respectively. Each dataset was subsetted only for mean and standart deviation columns. After that each dataset was merged with coressponding subject and activity. Before this merge activity was merged with its labels. After all train and test datasets were merged in one big dataset.

Merged dataset was aggregated by subject and activity taking each variable mean. Column names have been prettied to look nice and to be relevant with its content.
