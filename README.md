This file contains information on the run_analysis.r script made for the Coursera "Getting and cleaning data" course. The script modifies the "messy" dataset on recognition of human activity using smartphone sensor data. See the original dataset's README-original.txt for more information.

The run_analysis.r file does the following:
1. Merges the training and the test sets (contained in "X_train.txt" and "X_test.txt") to create one data set and adds a column containing the activity and test subject identifier to each row (each measurement) as specified in "y_[x].txt" and "subject_[x].txt" (where [x] is either "test" or "train").

2. Extracts only the measurements on the mean and standard deviation for each measurement. It does this by searching the variable names (which are contained in "features.txt") for the string "mean" or "std". All secondary calculated variables (see "features_info.txt") are deleted as these do not belong in our final tidy dataset (and if needed can be calculated from the measurements contained in our final dataset).

3. Uses descriptive activity names to name the activities in the data set, which are defined in "activity_labels.txt"

4. Appropriately labels the data set with descriptive variable names. Variables are already named in step 2 using predefined shorthand names such as "gravityacc-mean()-x". Because these variable names are "messy" and actually contain data themselves (the type of measurement, e.g. "gravityacc"), two changes are made: the dataset is tidied by splitting the variable names into the true variable name component (e.g. mean()-x) and the component which is actually not a variable name but data itself (e.g. the type of measurement, "gravityacc"). The type of measurement is stored in the variable "measurement" and the actual numeric data is stored in cleaned up variable names such as mean.x and std.x. The resulting dataset adheres to the three principles of a tidy dataset: each variable forms a column, each observation forms a row and each type of observational unit forms a table.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


See CODEBOOK.MD for the variables that are contained in the final modified (tidy) dataset.