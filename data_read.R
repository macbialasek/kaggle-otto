# Directory path with data downloaded from Kaggle:

setwd("C:/Users/maciek/Desktop/Studia dok/Courses/kaggle-otto/data")

# Imported libraries:

library(dplyr)

# Read train data:

dataTrain <- read.csv("train.csv")
str(dataTrain)

# Sample data for quick manipulations/plotting:

dataTrainSample <- dataTrain[sample(nrow(dataTrain), 5000), ]

#Is there method to visualise data for insight?
#These two plots looks similar, so only information I can get from them is that my sample
#representative

plot(~target,dataTrainSample)
plot(~target,dataTrain)


