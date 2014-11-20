Coursera_Getting_and_Cleaning_Data
==================================

Course project for Getting and Cleaning Data

The script file, run_analysis.R, reads and manipulates eight text files,
writing the final summary of their data to dataSummary.txt. The files are;

activity_labels.txt
features.txt
subject_test.txt
y_test.txt
X_test.txt
subject_train.txt
y_train.txt
X_train.txt

The first files to be read are activity_labels.txt and features.txt. These 
will provide labels for the activity factors and the column names for the
larger data set. The file features.txt required some cleaning as it contains
characters that are not legal for R column names.

The files subject_test and subject_train contain the identifier for the 
subject of each measurement. The files y_test and y_train contain the identifier
for the activity of each measurement. The files X_test and X_train contain the 
actual data of each measurement.

After reading each file, the test files were merged columnwise, the train files 
were merged columnwise, and the resuling two files were merged rowwise to produce 
one large file. The subject and activity columns were converted to factors and 
the activity labels were applied to the activity factor. The data columns were 
named using the labels from features.txt.

As we are only interested in data comumns with mean and std summaries, all other
columns were removed. Finally, the mean of each data column was computed for each 
group of subject and activity. That summary was written as a comma separated text 
file to dataSummary.txt.
