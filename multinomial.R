myiris <- iris

#select the pivot/baseline/refernce outcome
myiris$SpeciesReleveled <- relevel(myiris$Species, ref = "virginica")
levels(myiris$SpeciesReleveled)

#divide myiris into training and test data
set.seed(1234)
training_data_size <- floor(0.60 * nrow(myiris))
training_index <- sample(1 : nrow(myiris), training_data_size)

#exclude species column from training and test data
training_data <- myiris[training_index, c(-5)]
testing_data <- myiris[-training_index, c(-5)]

#build the multinomial log reg model
library(nnet)
model <- multinorm(formula = SpeciesReleveled ~ ., data = training_data)
print(model)

#select a few random observations from testing data
random_test_obs <- testing_data[c(6,13,22,34,49,53),]
print(random_test_obs, row.names = F)

#predict probabilities associated with each outcome of the target of random observations
predicted_probability <- data.frame(predict(model, random_test_obs, type = "prob"))

#display the predicted probabilites for the random observations from testing data
print(predicted_probability, row.names = F)

#sum the probabilities for each random observations and display
predicted_probability <- data.frame(predicted_probability, apply(predicted_probability, 1, sum))
colnames(predicted_probability)[4] <- "sum"
print(predicted_probability, row.names = F)

#determine the most probable outcome associatedd with the predicted probabilities
predicted_class <- data.frame(predict(model, random_test_obs, type = "class"))
colnames(predicted_class) <- c("predicted class")

#display the predicted outcomes for the random observations from testing data
predicted_probability <- subset(predicted_probability, select = c(-4))
predicted_class <- data.frame(predicted_probability, predicted_class)
print(predicted_class, row.names = F)

#extract the actual values of the random observations from testing data
actual_class <- random_test_obs$SpeciesReleveled

#compare the actual values with predicted outcomes for the random observations ffrom testing data
predicted_class <- subset(predicted_class, select = c(4))
comparison_data <- data.frame(actual_class, predicted_class)
print(comparison_data, row.names =F)

#determine the most probable outcomes for the entire testing data
predicted_class <- predict(model, testing_data, type = "class")

#extract the actuall valies from the testing data
actual_class <- testing_data$SpeciesReleveled

#create a confusion matrix
addmargins(table(actual_class, predicted_class))







