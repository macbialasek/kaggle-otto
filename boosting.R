require(gbm)
boost.kag=gbm(target~.,data=dataTrain,distribution="multinomial",n.trees=1000,shrinkage=0.01,interaction.depth=4)
summary(boost.kag)
plot(boost.kag,i="feat_14")
plot(boost.kag,i="feat_15")

predictors <- summary(boost.kag)
predictors.important <- predictors[1:20,]
pred.c <- predictors.important$var
write.csv(predictors.important,"predictors.csv")

boosting.prediction <- predict(boost.kag, newdata=dataTest, type="response",n.trees=100)
df.bp <- data.frame(boosting.prediction)
