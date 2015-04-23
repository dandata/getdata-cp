library("dplyr")

# loading description data
var.names <- read.table('features.txt', colClasses = 'character')[, 2]
activity.labels <- read.table('activity_labels.txt', col.names = c('Activity.Id', 'Activity.Name'))

# loading train data and subsetting it for mean and std columns
train.data <- read.table('./train/X_train.txt', col.names = var.names)
train.data <- train.data[, which(grepl('mean\\(|std', x = var.names, perl = T))]

# loading train subjects and activities and binding it to train data frame
train.subject <- read.table('./train/subject_train.txt', col.names = 'Subject')
train.activity <- read.table('./train/y_train.txt', col.names = 'Activity.Id')
train.data <- cbind(train.subject, full_join(activity.labels, train.activity)[, 2], train.data)
colnames(train.data)[2] <- 'Activity'

# loading test data and subsetting it for mean and std columns
test.data <- read.table('./test/X_test.txt', col.names = var.names)
test.data <- test.data[, which(grepl('mean\\(|std', x = var.names, perl = T))]

# loading test subjects and activities and binding it to test data frame
test.subject <- read.table('./test/subject_test.txt', col.names = 'Subject')
test.activity <- read.table('./test/y_test.txt', col.names = 'Activity.Id')
test.data <- cbind(test.subject, full_join(activity.labels, test.activity)[, 2], test.data)
colnames(test.data)[2] <- 'Activity'

# merging test and train data
all.data <- full_join(test.data, train.data)

# aggregating data by subject and activity
averaged.data.by.subject.and.activity <- aggregate(all.data, list(Subject = all.data$Subject, Activity = all.data$Activity), mean)

# dropping duplicate columns and reordering by subject number
averaged.data.by.subject.and.activity <- averaged.data.by.subject.and.activity[, -c(3, 4)]
averaged.data.by.subject.and.activity <- arrange(averaged.data.by.subject.and.activity, Subject)

# updating column names to be relevant with content
colnames(averaged.data.by.subject.and.activity)[3:68] <- gsub('^(t|f)', '', var.names[which(grepl('mean\\(|std', x = var.names, perl = T))])

# saving new data set to text file
write.table(averaged.data.by.subject.and.activity, row.names = F, file = 'averaged-data.txt')
