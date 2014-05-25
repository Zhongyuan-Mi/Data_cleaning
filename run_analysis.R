WS = getwd()
##get the training data
Trainpath = paste (WS ,"/Dataset/train/X_train.txt", sep="")
trainData <- read.table(Trainpath)

##get the test data
Testpath = paste (WS ,"/Dataset/test/X_test.txt", sep="")
TestData <- read.table(Testpath)

##merge Data
m <- rbind(trainData, TestData)