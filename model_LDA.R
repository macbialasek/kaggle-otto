# Directory path with data downloaded from Kaggle:

setwd("C:/Users/maciek/Desktop/Studia dok/Courses/kaggle-otto/data")

# Imported libraries:

library(dplyr)
library(MASS)

# Read train data:

dataTrain <- read.csv("train.csv")
str(dataTrain)

# Sample data:

dataTrainSample <- dataTrain[sample(nrow(dataTrain), 5000), ]

dataTestSample <- dataTrain[sample(nrow(dataTrain), 1000), ]

#LDA model

lda.fit <- lda(target~., data=dataTrainSample)
lda.fit
lda.pred <- predict(lda.fit,dataTestSample)
data.frame(lda.pred)[1:5,]
table(lda.pred$class,dataTestSample$target)
mean(lda.pred$class==dataTestSample$target)
