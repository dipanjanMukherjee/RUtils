##########
### rough svm
##########

data("iris")

plot(Sepal.Width, Sepal.Length, col = Species)

model <- svm(Species ~ ., data = iris)
summary(model)


tuneSvm <- tune(svm, yFeature~., data = iris, kernel = "radial", ranges = list(cost = 10^(-2:2), gamma = c(.25,.5,1,2)))

finalSvm <- svm(Species ~ ., data = iris, kernel = "radial", cost = 0.1, gamma = 0.5)


bestModel <- tuneSvm$best.model
yPredict <- predict(bestModel, testData)
table(predict = yPredict, truth = testData$yFeature)

#############
### svm on iris data
###############
library(e1071)

irisPart = iris[,c(1,2,5)]
attach(irisPart)
plot(Sepal.Width, Sepal.Length, col = Species)

xFeature <- subset(irisPart, select =~ Species) # feature to use
yFeature <- Species #feature to predict


model <- e1071::svm(Species ~., data = irisPart)
summary(model)

tuneSVM <- e1071::tune(svm, train.x = xFeature, train.y = yFeature, kernel = "radial", 
                       ranges = list(cost = 10^(-2:2), gamma = c(0.25, 0.5, 1, 2)))

# cross validation
# tc <- tune.control(cross = 5)
# priorir_svm <- tune.svm(svm, y = trainY, cost = 0.1, gamma = 0.1, tunecontrol =tc)

print(tuneSVM)

finalSVM <- e1071::svm(Species ~., data = irisPart, kernel = "radial", cost = 0.01, gamma = 0.01)

plot(finalSVM, irisPart)

#change kernel to linear
finalSVMLinear <- e1071::svm(Species ~ ., data = irisPart, kernel = "linear", cost = 10, gamma = 0.25)

plot(finalSVMLinear, irisPart)

finalSVM2 <- e1071::svm(Species ~., data = irisPart, kernel = "radial", cost = 100, gamma = 100)

#high cost and gamma may overfit
plot(finalSVM2, irisPart)
