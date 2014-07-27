WS = getwd()

##get the header of the data
HeaderData = read.table("Dataset/features.txt")
Header_origin <-as.character(HeaderData[,2])

##process the header to replace all the symbols like "(", ")", "_", "," with "."

Header_low <- tolower(Header_origin)
Header_proc1 <- gsub("\\(|\\)|,|-", "\\.", Header_low)
Header_proc2 <- gsub("(\\.)+","\\.", Header_proc1)
Header_final <- sub("\\.$", "", Header_proc2)

##get the training data
subData_tr <- read.table("Dataset/train/subject_train.txt",col.names = "subject")

actData_tr <- read.table("Dataset/train/y_train.txt",col.names = "activity.code")

trainData <- read.table("Dataset/train/X_train.txt",col.names = Header_final)

train_main <- cbind(subData_tr,actData_tr,trainData)

##get the test data

subData_ts <- read.table("Dataset/test/subject_test.txt",col.names = "subject")

actData_ts <- read.table("Dataset/test/y_test.txt",col.names = "activity.code")

testData <- read.table("Dataset/test/X_test.txt", col.names = Header_final)

test_main <- cbind(subData_ts,actData_ts,testData)

##merge Data
m <- rbind(train_main, test_main)

##label the activity

label_data <- read.table("Dataset/activity_labels.txt")
act_label = as.character(label_data[,2])

m[,"activity.txt"] <- cut(m[,"activity.code"], breaks = 6, labels = act_label)

##export the merged database
write.csv(m, file = "master.csv",row.names=FALSE)


##select the mean() and std() related var

Header_merge <- c("subject","activity.code",  Header_low,"activity.txt")

l1 <- grep("std\\(\\)|mean\\(\\)",Header_merge)
l <- c(1,2,l1,564)

##create the data set with the mean and std of the measurement
refine_data <- m[,l]

write.csv(refine_data, file = "subset_mean_std.csv",row.names=FALSE)

##calculate the mean of all var for all the activity of each subject
library(reshape2)

res <- melt(refine_data, id = c("subject", "activity.code", "activity.txt"))
mean_table <- dcast(res, subject + activity.txt ~ variable, mean)

mean_table_origin_var <- names(mean_table)
names(mean_table)[3:68] <- paste0(names(mean_table)[3:68], ".mean")

write.csv(mean_table, file = "subject_act_mean_value.csv",row.names=FALSE)


## code book 1
CB_1 <- data.frame("Index" = seq(along = names(m)),
                   "new_variable_name" = names(m), 
                   "old_variable_name" = c("subject ID", "activity code", 
                                           Header_origin, "activity description"))

write.table(CB_1, file = "codebook1.txt",sep=" ",row.names=FALSE)
## code book 2
CB_2 <- data.frame("Index" = seq(along = mean_table_origin_var),
                   "variable_name_in_subset_mean_std" = mean_table_origin_var, 
                   "variable_name_in_subject_act_mean_value" = names(mean_table))
write.table(CB_2, file = "codebook2.txt",sep=" ",row.names=FALSE)

