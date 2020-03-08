library(reshape)
library(wordcloud)
library(tm)
library(snowballc)
library(Rweka)

for(k in 1:num_cluster){
	set.seed(20)
	fit.km <- kmeans()
	ratio_ss[k] <- (fit.kma$tot.withinss)/(fit.km$totss)
}

plot(ratio_ss, type = "b", xlab = "k")

