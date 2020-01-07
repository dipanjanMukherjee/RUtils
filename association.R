## covariance
mpgrel <- subset.data.frame(cars93, select = c("MPG.city", "EngineSize", "Horsepower"))
cov(mpgrel)

#shapiro walk test 
stats::shapiro.test(cars93$Turn.circle)
stats::qqplot()

#spearman rho
first10hp <- head(cars$Horsepower, 10)
first10hp <- sort(first10hp, decreasing = TRUE)
rankfirst10hp <- rank(first10hp)

cor(cars$Horsepower, cars$MPG.city, method = "spearman")

cor.test(cars$RPM, cars$MPG.city)

#kendall tau
first24rpm <- rank(head(cars93$RPM, 25))
first25mpgl <- rank(head(cars93$MPG.city, 25))

combo <- matrix(x(first24rpm, first25mpgl), nrow = 25, ncol = 2)

combo[19:21,]

rpmvalues <- c(18.0, 12.4,8.5)
mpgvalues <- c(14.0, 20.5, 14.0)
cor(rpmvalues, mpgvalues, method = "kendall")

##
# association b/w qualitative/categorical variables
addmargins( table(cars93$DriveTrain, cars93$Type))

##
# degree of freedom
qchisq(p = 1-0.05, df =10)

table(cars93$DriveTrain, cars93$Type)
matcat <- as.matrix(table(carss93$DriveTrain, cars93$Type))
chisq.test(matcat)

addmargins(table(origin_trans))
manfn <- function(x) if(x=='Yes') 1 else 0
manual <- sapply(x = cars93$Man.trans.avail, FUN = manfn)
originfn <- function(x) if (x=='USA') 1 else 0
origin <- sapply(x = cars93$Origin, FUN = originfn)
cor(manual, origin)


#
phi <- cor(manual, origin)
phisq <- phi^2
chi <- chisq.test(as.matrix(table(origin_trans)))
chisq_statistics <- chi$statistic
exp_phisq <- chisq_statistics/nrow(origin_trans)


# shanon's entropy
library(entropy)
mach_freq <- c(4,4,4,4)
entropy.empirical(mach_freq, unit = "log2")

#kullback leibler divergence
actual_freq <- c(162,162,152,185,158,181)
uniform_freq <- c(164,164,164,164,164,164)
KL.empirical(actual_freq, uniform_freq, unit="log2")