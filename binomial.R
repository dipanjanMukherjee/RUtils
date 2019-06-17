library(ISLR)
data("Default")

str(Default)

temp <- Default

temp$default <- ifelse(temp$default == "No", 0, 1)

plot(x = temp$balance, y = temp$default, xlab = "balance", ylab = "default", main = "balance vs default")

#
set.seed(1234)
training_data_size <- floor(0.75 * nrow(Default))
training_index <- sample(1:nrow(Default), training_data_size)
training_data <- Default[training_index, c(3,1)]
testing_data <- Default[-training_index, c(3,1)]

#build the binomial log reg model
model <- glm(formula = default ~ balance, data = training_data, family = binomial(link = "logit"))
print(model)

#set graphical parameters
op <- par(no.readonly = T)
par(lwd = 2)

temp <- Default

temp$default <- ifelse(temp$default == "No", 0, 1)
plot(x = temp$balance, y = temp$default, xlab = "x", ylab = "f(x)", main = "Logistic regression model")

curve(predict(model, data.frame(balance = x), type = "response"), col = "blue", add = TRUE)
par(op)

#select random
random_test_obs <- testing_data[c(27, 174, 242, 254, 787, 1709),]
print(random_test_obs, row.names = F)

predicted_probability <- data.frame(predict(model, random_test_obs, type = "response"))

print(predicted_probability, row.names = F)

temp <- rep("No", nrow(random_test_obs))
temp[predicted_probability > 0.5] <- "Yes"
predicted_class <-data.frame(as.factor(temp))
colnames(predicted_class) <- c("predicted class")

predicted_class <- data.frame(predicted_probability, predicted_class)
print(predicted_class, row.names  = F)

actual_class <- random_test_obs$default

predicted_class <- subset(predicted_class, select = c(2))
comparison_data <- data.frame(actual_class, predicted_class)
print(comparison_data, row.names = F)

predicted_probability <- predict(model, testing_data, type = "response")

temp <- rep("No", nrow(testing_data))
temp[predicted_probability > 0.5] <- "Yes"
predicted_class <- as.factor(temp)

actual_class <- testing_data$default

addmargins(table(actual_class, predicted_class))


#
glimpse(adult)

#
adult_workclass <- adult %>% filter(!(workclass == " ?"))

#
adult_native$inncome <- as.factor(ifelse(adult_native$income == adult_native$income[1], "No", "Yes"))

