library(dplyr)
library(tidyr)

if(! all(file.exists("test/X_test.txt", "test/y_test.txt", "test/subject_test.txt",
                     "train/X_train.txt", "train/y_train.txt", "train/subject_train.txt",
                     "activity_labels.txt", "features.txt"))) {
    stop("Not all required data files could be found")
}

# 1. Merges the training and the test sets to create one data set.

# Training data
training <- read.table("train/X_train.txt") # actual data
activity_id <- read.table("train/y_train.txt") # activity id for each row
subject_id <- read.table("train/subject_train.txt") # subject id for each row
d1 <- cbind(subject_id[[1]], activity_id[[1]], training) # combine columns into one dataset

# Same as above for test data
test <- read.table("test/X_test.txt")
activity_id <- read.table("test/y_test.txt")
subject_id <- read.table("test/subject_test.txt")
d2 <- cbind(subject_id[[1]], activity_id[[1]], test)

# Combine training and testing data in one dataset
d <- tbl_df(rbind(d1, d2))



# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Variable names are stored in features.txt
vnames <- read.table("features.txt", stringsAsFactors = FALSE)
names(d) <- c("subject", "activity", vnames[[2]]) # Above we added two extra columns for subject and activity id

# Only keep variables with mean or std in their name. Also keep first two
# columns because they contain subject and activity id.
d <- d[c(1:2,grep("(mean|std)\\()", names(d)))]

# Remove all variables whose names begin with a non-capital "f" because they
# represent Fournier transformations of the original data and thus can be calculated
# later on when needed.
d <- d[-grep("^f", names(d))]

# Remove all variables whose name contains "Mag" because they contain the
# calculated magnitude of the vector (x,y,z) and thus can also be calculated
# later on when needed.
d <- d[-grep("Mag", names(d))]



# 3. Uses descriptive activity names to name the activities in the data set

# Activity names are stored in in activity_labels.txt
anames <- read.table("activity_labels.txt")
d[2] <- factor(d[[2]], levels = anames[[1]], labels = tolower(anames[[2]]))



# 4. Appropriately labels the data set with descriptive variable names.

# See step 2 where variables are already named. Now clean the names up a bit.
names(d) <- tolower(sub("\\()", "", names(d)))
names(d) <- gsub("-", ".", names(d))
names(d) <- sub("^t", "", names(d))

# Tidy up: at this moment the variable names contain values as wel (e.g.
# gravityacc.mean.x contains information on the variable measured [gravityacc]
# and the type of measurement [mean.x]
d <- mutate(d, observation = row_number()) %>%
     gather(variable, value, -subject, -activity, -observation) %>%
     separate(variable, c("measurement", "variable"), "\\.", extra = "merge") %>%
     spread(variable, value) %>%
     select(observation, subject, activity, measurement, mean.x:std.z) %>%
     arrange(observation, measurement)

d$measurement <- factor(d$measurement)

# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
averages <- select(d, -observation) %>%
            group_by(subject, activity, measurement) %>%
            summarize_each(funs(mean)) %>%
            arrange(subject, activity, measurement)



# Clean up workspace and free memory. Leave only dataframes "d" and "averages".
rm(activity_id, anames, d1, d2, subject_id, test, training, vnames)
gc()