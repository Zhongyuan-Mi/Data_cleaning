## this is the final project for Data Cleaning

The Project took the data from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The original data and related documents are stored in the Dataset folder.

### Dataset output
Three tidy datasets were created using the run_analysis.R script
* __master.csv__ contain the combined training and test datasets from the original datasets with cleaned variable name and activity description
* __subset_mean_std.csv__ is a subset of master.csv with only mean and std measurement for all the subjects (only variable with "mean()" or "std()" in the original datasource are taken)
* __subject_act_mean_value.csv__ calculated the mean of all the variables in the subset_mean_std.csv for six activities of all 30 subjects

### Codebook
* Please refer to codebook1.txt for datasets master.csv and subset_mean_std.csv
* Please refer to codebook2.txt for subject_act_mean_value.csv

### Script
The analysis was done in the run_analysis.R
Please refer to the comment in the code for detail.
To run this code, please setup the R working directory to where you store the script.
Please don't keep the dataset folder in the same work space.