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

write.csv(submit, 'submit.csv', quote=FALSE, row.names = FALSE)

#1.05 on benchmark in Kaggle
