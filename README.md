README
========================================================
The R script run_analysis.R works that way, that the code underneatheach comment performes a specific operation of getting, reshaping or summarizing data.The README is constructed in the way that headings are corresponding to comments in the script.

## Set working directory
The code checks, whether the folder 'Data project' exist in the current working directory and if not creates this folder.

This step can be easily and an own working directory can be chosen.

## Load necessary packages
This script is using the R package 'data.table', so the code ensures the data.table package is installed and loaded. The installation will be performed, if necessary.

## Download data
A variable datafile is created containin the data source string. Following the zip folder containg the data is loaded and stored in the specified working directory as Dataset.zip. The function zip "unzips" the Dataset folder and stores pathstrings of all unzipped files into the varaible Dataset.

## Import data
The readLines and read.table function are reading the data into R as a text vector resp. numeric matrix.
  * features - contains names of all measurments
  * lable - contains the factorized activity data beloning to each observation
  * subjects - contains the factorized subject data beloning to each observation
  * data - contains the measurment data, each row contains one observation, each column one measurment variable

## Creating meaningful activity names
The factorized activity data is meaningfully renamed. Therefore the encoding of the activity data is loaded into R by teh readLines function. The numeric extension for the factorization is removed and all text is converted into lower case text for higher convinience in later analysis.

Finally redundant variables are removed.

## Extract data for mean and standard deviation
The grep function is used to extract all measurment names from the features vector that contain the expression mean or std followed by a non character sign. In this case all measurments that end with mean() or std(). Following the subset 'Data' containing only these measurments is created from the 'data' matrix. Variables names are converted into the measurment names from the feature vector.

The redundant matrix 'data' is removed.

## Build datatable
The data.table function is used to combine the 'subjects' vector, the 'activity' vector and the 'Data' table nto one data table named 'Data'.

## Extract new dataset
The melt function is used to reshape the 'Data' table in a form, were contains on cloumn for the 'subjects' id, one column for the 'activity' id and one column for all measurements. Following the dcast.data.table function reshapes the 'Data' table into a new table 'tidyData' containg only the mean for all measurements of each subjects for the single activities.

In the end all objects are removed except the tidyData dataset and a csv output of the tidyData set to a txt file is made.

