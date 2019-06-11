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

head(as.character(train$Name))
length(unique(data.combined$Name))
dup.names <- as.character(data.combined[which(duplicated(as.character(data.combined$Name))),"Name"])
data.combined[which(data.combined$Name %in% dup.names),]

library(stringr)
misses <- data.combined[which(str_detect(data.combined$Name,"Miss.")),]
males <- data.combined[which(train$Sex == "male"),]

extractTitle <- function(name){
  name <- as.character(name)
  
  if (length(grep("Miss.",name)) > 0){
    return("Miss.")
  }else if (length(grep("Master.",name)) > 0){
    return("Master.")
  }else if (length(grep("Mrs.",name)) > 0){
    return("Mrs.")
  }else if (length(grep("Mr.",name)) > 0){
    return("Mr.")
  }else{
    return("Other")
  }
}
  
titles <- NULL
for (i in 1:nrow(data.combined)) {
  titles <- c(titles, extractTitle(data.combined[i,"Name"]))
}
data.combined$title <- as.factor(titles)
summary(data.combined[1:891,"Age"])

ggplot(misses[misses$Survived != "None",],aes(x = Age, fill = Survived)) +
         geom_histogram(binwidth = 5)+
         facet_wrap(~Pclass)+
         ggtitle("Pclass")+
         xlab("Age")+
         ylab("Total Count")+
         ylim(0,20)+
         labs(fill = "Survived")

Mr <- data.combined[which(data.combined$title == "Mr."),]
summary(Mr$Age)

library(randomForest)

rf.train.1 <- data.combined[1:891,c("Pclass","title","SibSp","Parch")]
rf.label <- as.factor(train$Survived)

set.seed(1234)
rf.1 <- randomForest(x=rf.train.1,y=rf.label,importance = TRUE,ntree = 1000)
rf.1
varImpPlot(rf.1)

  

