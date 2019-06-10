train <- read.csv("train.csv",header = TRUE)
test <- read.csv("test.csv",header = TRUE)
test.survived <- data.frame(Survived = rep("None", nrow(test)), test[,])
test.survived <- test.survived[c(2,1,3,4,5,6,7,8,9,10,11,12)]
data.combined <- rbind(train,test.survived)

data.combined$Survived <- as.factor(data.combined$Survived)
data.combined$Pclass <- as.factor(data.combined$Pclass)
str(data.combined)

library(ggplot2)

train$Pclass <- as.factor(train$Pclass)
str(train)

ggplot(train, aes(x=Pclass,fill = factor(Survived))) +
  geom_bar(width=0.5) +
  xlab("Pcclass") +
  ylab("Total Count")+
  labs(fill = "Survived")