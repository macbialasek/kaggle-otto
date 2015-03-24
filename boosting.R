require(gbm)
#koniecznie zmodyfikować (subset data?), ten model długo pracuje!
boost.kag=gbm(target~.,data=dataTrain,distribution="multinomial",n.trees=1000,shrinkage=0.01,interaction.depth=4)
summary(boost.kag)
plot(boost.kag,i="feat_14")
plot(boost.kag,i="feat_15")

predictors <- summary(boost.kag)
predictors.important <- predictors[1:20,]
pred.c <- predictors.important$var
write.csv(predictors.important,"predictors.csv")

boosting.prediction <- predict(boost.kag, newdata=dataTest, type="response",n.trees=100)
df.bp <- data.frame(boosting.prediction,check.names=T)
submit_boost <- cbind(id,df.bp)
colnames(submit_boost) = c("id","Class_1","Class_2","Class_3","Class_4","Class_5","Class_6",
                           "Class_7","Class_8","Class_9")
write.csv(submit_boost, 'boosting.submit.csv', quote=FALSE, row.names = FALSE)
