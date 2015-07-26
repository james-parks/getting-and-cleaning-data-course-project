## Code Book

We have two factor variable names.

Subject_ID designates the volunteer. The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years, labelled 1 to 30.

Activity_Name designates the activity name. The activity names are WALKING, WALKING_UPSTAIRS,	WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING. 
These activities were performed with the volunteer wearing a smartphone (Samsung Galaxy S II) on the waist.
	
The remaining variables are all averages of measurements. These averages are normalized and bounded within [-1,1]. 

The following codes are used for the prefixes:

"Average.of." designates that the value is an average of several measurements for a given activity and subject.

"t" designates the time domain.	These time domain signals were captured at a constant rate of 50 Hz.

"f" designates the frequency domain.

"Acc" designates the measurement came from the accelerometer.

"Gyro" designates the measurement came from the gyroscope.

"-XYZ" is used to denote 3-axial signals in the X, Y and Z directions.

"Body" designates that the measurement coming from the accelerometer or gyroscope is related to the body.

"Gravity" designates the measurement coming from the accelerometer or gyroscope is related to gravity.

"Jerk" designates the jerk of the body linear acceleration or angular velocity.

"Mag" designates the magnitude of these three-dimensional signals calculated using the Euclidean norm.

The prefixes related to these measurements are
Average.of.tBodyAcc-XYZ
Average.of.tGravityAcc-XYZ
Average.of.tBodyAccJerk-XYZ
Average.of.tBodyGyro-XYZ
Average.of.tBodyGyroJerk-XYZ
Average.of.tBodyAccMag
Average.of.tGravityAccMag
Average.of.tBodyAccJerkMag
Average.of.tBodyGyroMag
Average.of.tBodyGyroJerkMag
Average.of.fBodyAcc-XYZ
Average.of.fBodyAccJerk-XYZ
Average.of.fBodyGyro-XYZ
Average.of.fBodyAccMag
Average.of.fBodyAccJerkMag
Average.of.fBodyGyroMag
Average.of.fBodyGyroJerkMag

The following suffixes were then attached to the list of prefixes above:

-mean(): Mean value
-std(): Standard deviation
-angle(): Angle between to vectors

Additional vectors were obtained by averaging the signals in a signal window sample. These were used on the angle() variable:
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean