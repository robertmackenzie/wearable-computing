# Wearable Computing Telemetry

The source data is described in [UCI HAR Dataset/README.txt](UCI%20HAR%20Dataset/README.txt).

The processing script `run_analysis.R` produces two datasets.

It combines the training and test datasets and sanitises the column names, selecting a subset of the input data features, and producing the output dataset `wearable_telemetry.txt`, with these variables.

* activity <chr> - the type of activity carried out by the subject while collecting telemetry.
* subject <num> - the unique id of the subject.
* 66 further variables, which are a projection of the features described in [UCI HAR Dataset/features_info.txt](UCI%20HAR%20Dataset/features_info.txt) to the mean and standard deviation variables only.

Each record represents a 2.56 second window of measurement, which is the same as the source data.

The processing script then summarises the above dataset, producing the output dataset `wearable_telemetry_mean_by_activity_subject.txt`, with these variables.

* activity <chr> - the type of activity carried out by the subject while collecting telemetry.
* subject <num> - the unique id of the subject.
* 66 further variables, which are the mean values of the above dataset.

Each record is the mean of all (activity, subject) pairs for each feature.
