library(dplyr, warn.conflicts = FALSE)
library(purrr, warn.conflicts = FALSE)

feature_labels <- read.table("./UCI HAR Dataset/features.txt") %>%
  pull(2)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt") %>%
  pull(2)

activity <- readLines("./UCI HAR Dataset/test/y_test.txt") %>%
  map_chr(\(x) pluck(activity_labels, as.numeric(x)))
subject <- as.numeric(readLines("./UCI HAR Dataset/test/subject_test.txt"))
test_features <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(test_features) <- feature_labels
summary_features <- test_features %>%
  select(contains("-mean()") | contains("-std()"))
colnames(summary_features) <- colnames(summary_features) %>%
  gsub("\\(|\\)", "", .) %>%
  gsub("-", "_", ., fixed = TRUE) %>%
  gsub(",", "_", ., fixed = TRUE) %>%
  tolower()
test_data <- cbind(activity, subject, summary_features)

activity <- readLines("./UCI HAR Dataset/train/y_train.txt") %>%
  map_chr(\(x) pluck(activity_labels, as.numeric(x)))
subject <-
  as.numeric(readLines("./UCI HAR Dataset/train/subject_train.txt"))
train_features <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(train_features) <- feature_labels
summary_features <- train_features %>%
  select(contains("-mean()") | contains("-std()"))
colnames(summary_features) <- colnames(summary_features) %>%
  gsub("\\(|\\)", "", .) %>%
  gsub("-", "_", ., fixed = TRUE) %>%
  gsub(",", "_", ., fixed = TRUE) %>%
  tolower
train_data <- cbind(activity, subject, summary_features)

combined_data <- rbind(train_data, test_data)

write.table(combined_data, "wearable_telemetry.txt", row.names = FALSE)

mean_by_activity_subject <- combined_data %>%
  group_by(activity, subject) %>%
  summarise_all(mean)

write.table(mean_by_activity_subject, "wearable_telemetry_mean_by_activity_subject.txt", row.names = FALSE)
