# Directory path with data downloaded from Kaggle:

setwd("C:/Users/maciek/Desktop/Studia dok/Courses/kaggle-otto/data")

# Imported libraries:

library(dplyr)
library(MASS)

# Read train data, test data, submission file:

dataTrain <- read.csv("train.csv")[,-1]
dataTest <- read.csv("test.csv")[,-1]
submit <- read.csv("sampleSubmission.csv")
str(dataTrain)

# Sample data:

dataTrainSample <- dataTrain[sample(nrow(dataTrain), 5000), ]

dataTestSample <- dataTrain[sample(nrow(dataTrain), 1000), ]

#LDA model

lda.fit <- lda(target~., data=dataTrain)
lda.fit
lda.pred <- predict(lda.fit,dataTestSample,type="prob")
data.frame(lda.pred)[1:5,]
table(lda.pred$class,dataTestSample$target)
mean(lda.pred$class==dataTestSample$target)

#test for submission

predicted <- predict(lda.fit, newdata=dataTest, type="prob")$class

lda.fit <- lda(target~., data=dataTrain)
lda.prediction <- predict(lda.fit, newdata=dataTest, type="prob")
submit[,2:10] <- predict(lda.fit, newdata=dataTest, type="prob")$posterior

write.csv(submit, 'lda.submit.csv', quote=FALSE, row.names = FALSE)

#1.029 on benchmark in Kaggle
#Quick check on QDA
qda.fit <- qda(target~.,data=dataTrain)
qda.prediction <- predict(qda.fit, newdata=dataTest, type="prob")
qda.submit <- submit
qda.submit[,2:10] <- predict(qda.fit, newdata=dataTest, type="prob")$posterior
write.csv(qda.submit, 'qda.submit.csv', quote=FALSE, row.names = FALSE)
#...which gives 6 on benchmark... lot, lot worse

#tuning of LDA???
