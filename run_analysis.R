run_analysis <- function() {
	# Loads the reshape and dplyr library
	library(reshape2)
	library(dplyr)

	# Check if there is a folder "/data" in our working directory if not, then creates it
	if(!file.exists("data")){
		dir.create("data")
	}

	# Download the data from the web using the "wininet" method since we have a Windows machine
	fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileURL, destfile = "./data/UCIHAR.zip", method = "wininet")

	# Unzips the downloaded file into the data directory
	unzip("./data/UCIHAR.zip")

	# At this point we look at the files in the directories and read them using read.table()

	# We first read in the test files
	X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
	y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
	subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

	# We then read in the train files

	X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
	y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
	subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

	# By looking at the dimensions of the data we form the following merged data
	test_data <- cbind(subject_test,y_test)
	test_data <- cbind(test_data,X_test)
	train_data <- cbind(subject_train,y_train)
	train_data <- cbind(train_data,X_train)
	merged_data <- rbind(test_data,train_data)

	# Reads in the feature names, where each row represents a column in the merged data
	feature_names <- read.table("./UCI HAR Dataset/features.txt", sep = " ")

	# Extracts the list of columns associated with the mean or standard deviation using the grep command
	# From the features_info.txt file we know these are associated with "mean" or "std"
	means <- feature_names[grepl(".*mean.*", ignore.case = TRUE, feature_names$V2), ]
	stds <- feature_names[grepl(".*std.*", ignore.case = TRUE, feature_names$V2), ]
	feature_names_ms <- rbind(means,stds)
	feature_names_ms <- feature_names_ms[order(feature_names_ms$V1),]	
	ms_columns <- feature_names_ms[,1]
	ms_column_names <- feature_names_ms[,2]

	# We first name the columns of the merged data using integers which we will then use to filter by mean and std
	names(merged_data) <-c("Subject_ID","Activity_ID",1:ncol(X_test))

	# Selects only the data related to the mean and standard deviation
	merged_data_sub <- merged_data[,c("Subject_ID","Activity_ID",ms_columns)]

	# Reads in the activity label names
	labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep = " ")

	# Replaces the activity ID with a descriptive activity name
	for (i in 1:nrow(merged_data_sub)) {
		act_id <- merged_data_sub[i,2]
		merged_data_sub[i,2] <-as.character(labels[act_id,2])
	}

	# Labels the data set with descriptive variable names
	names(merged_data_sub) <-c("Subject_ID","Activity_Name",as.character(ms_column_names))

	# Designates which columns represent factor variables and which represent measurements
	merged_melt <- melt(merged_data_sub,id=c("Subject_ID","Activity_Name"),measure.vars =c(as.character(ms_column_names)))

	# Takes the average of each measurement by subject and activity
	averaged_data <- dcast(merged_melt, Subject_ID + Activity_Name ~ variable, mean)

	# Creates new descriptive variable names to reflect that the values are now averages of the measurements
	new_names <- paste("Average.of.",as.character(ms_column_names), sep="")
	names(averaged_data) <-c("Subject_ID","Activity_Name",new_names)

	# Orders the averaged data by Subject_ID
	ordered_data <- averaged_data[order(averaged_data$Subject_ID),]

	# Writes the tidy data to a text file
	tidy_data <- write.table(ordered_data, "tidy_data.txt",row.name=FALSE)
}
