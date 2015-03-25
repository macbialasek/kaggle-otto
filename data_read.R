# Directory path with data downloaded from Kaggle:

setwd("C:/Users/maciek/Desktop/Studia dok/Courses/kaggle-otto/data")

# Imported libraries:

library(dplyr)
library(corrplot)
library(caret)

# Read train data:

dataTrain <- read.csv("train.csv")[,-1]
dataTest <- read.csv("test.csv")[-1]
submit <- read.csv("sampleSubmission.csv")
str(dataTrain)

# Sample data:

dataTrainSample <- dataTrain[sample(nrow(dataTrain), 10000), ]

dataTestSample <- dataTrain[sample(nrow(dataTrain), 5000), ]

# Data scaling, centering, correlation matrix
train.scaled <- scale(dataTrain[1:93],center=TRUE,scale=TRUE)
corMatTrain <- cor(train.scaled)
corrplot(corMatTrain, order = "hclust")

# Correlation filter

highlyCor <- findCorrelation(corMatTrain, 0.70)
datMyFiltered.scale <- train.scaled[,-highlyCor]
corMatTrain <- cor(datMyFiltered.scale)
corrplot(corMatTrain, order = "hclust")

# train data after filtering

dataTrain.scaled <- data.frame(cbind(datMyFiltered.scale,dataTrain$target))


