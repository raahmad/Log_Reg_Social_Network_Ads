rm(list=ls())

#Load the csv files
Age<-read.csv("Age.csv",sep = ",",header = T)
Gender<-read.csv("Gender.csv",sep = ",",header = T)
Purchased<-read.csv("Purchased.csv",sep = ",",header = T)
Salary<-read.csv("Salary.csv",sep = ",",header = T)

#In Excel Workbook "Social Network Ads"
#The average age in 37.655
#The average estimated salary is 69742.5

#Title the User ID column
Age$ï..Row.Labels
names(Age)[names(Age) == "ï..Row.Labels"]<-"User ID"
names(Gender)[names(Gender) == "ï..Row.Labels"]<-"User ID"
names(Purchased)[names(Purchased) == "ï..Row.Labels"]<-"User ID"
names(Salary)[names(Salary) == "ï..Row.Labels"]<-"User ID"

#Merge all the data frames together
library(dplyr)
model_df<-Age %>% left_join(Gender, by="User ID")
model_df<-model_df %>% left_join(Salary, by="User ID")
model_df<-model_df %>% left_join(Purchased, by="User ID")

#Convert all na values to 0
model_df[is.na(model_df)]<-0

#Null columns that we do not need since it is repetitive
model_df$Age.Below.Average<-NULL
model_df$Female<-NULL
model_df$Salary.Below.Average<-NULL
model_df$Not.Purchased<-NULL

#Age Above Average will have a 1 for the Age.Above.Average Column
#Age Below Average will have a 0 for the Age.Above.Average Column

#Male will have a 1 for the Male Column
#Female will have a 0 for the Male Column

#Salary Above Average will have a 1 for the Salary.Above.Average Column
#Salary Below Average will have a 0 for the Salary.Above.Average Column

#Make sure all columns are categorical
model_df$Age.Above.Average<-as.factor(model_df$Age.Above.Average)
model_df$Male<-as.factor(model_df$Male)
model_df$Salary.Above.Average<-as.factor(model_df$Salary.Above.Average)
model_df$Purchased<-as.factor(model_df$Purchased)

str(model_df)

model_df$`User ID`<-NULL

#Create training set, testing set, logistic regression model
#Partition is 80/20
library(caret)
inTrain_model_df <- createDataPartition(y = model_df$Purchased, p = .80, list = FALSE)
training_model_df <- model_df[inTrain_model_df,]
testing_model_df<- model_df[-inTrain_model_df,]
logistic_purchased<-glm(Purchased ~ ., data = training_model_df, family = "binomial")
summary(logistic_purchased)

#Backwards Elimination

#Whether person is male or female is not statistically significant in predicting if someone
#purchased a product or not

#Re-Create training set, testing set, logistic regression model without "male" column
#Partition is 80/20
library(caret)
inTrain_model_df <- createDataPartition(y = model_df$Purchased, p = .80, list = FALSE)
training_model_df <- model_df[inTrain_model_df,]
testing_model_df<- model_df[-inTrain_model_df,]
logistic_purchased<-glm(Purchased ~ Age.Above.Average+Salary.Above.Average, data = training_model_df, family = "binomial")
summary(logistic_purchased)


#Data frame if someone is below average age and has below average salary
new.data.Purchaed<-as.data.frame(matrix(c(0,0),nrow = 1))
new.data.Purchaed
colnames(new.data.Purchaed)<-c("Age.Above.Average","Salary.Above.Average")
new.data.Purchaed[,1]<-as.factor(new.data.Purchaed[,1])
new.data.Purchaed[,2]<-as.factor(new.data.Purchaed[,2])


#Predicted probability of someone who is below average age and has below average salary
#will purchase a product
prob_Purchased1<-predict.glm(logistic_purchased,newdata = new.data.Purchaed, type = "response")
prob_Purchased1<-as.data.frame(prob_Purchased1)
#Roughly 7.6% probability
#Result recorded in Probability.xlsx

#Data frame if someone is above average age and has below average salary
new.data.Purchased2<-as.data.frame(matrix(c(1,0),nrow = 1))
new.data.Purchased2
colnames(new.data.Purchased2)<-c("Age.Above.Average","Salary.Above.Average")
new.data.Purchased2[,1]<-as.factor(new.data.Purchased2[,1])
new.data.Purchased2[,2]<-as.factor(new.data.Purchased2[,2])


#Predicted probability of someone who is above average age and has below average salary
#will purchase a product
prob_Purchased2<-predict.glm(logistic_purchased,newdata = new.data.Purchased2, type = "response")
prob_Purchased2<-as.data.frame(prob_Purchased2)
#Roughly 44.3% probability
#Result recorded in Probability.xlsx

#Data frame if someone is below average age and has above average salary
new.data.Purchased3<-as.data.frame(matrix(c(0,1),nrow = 1))
new.data.Purchased3
colnames(new.data.Purchased3)<-c("Age.Above.Average","Salary.Above.Average")
new.data.Purchased3[,1]<-as.factor(new.data.Purchased3[,1])
new.data.Purchased3[,2]<-as.factor(new.data.Purchased3[,2])


#Predicted probability of someone who is below average age and has above average salary
#will purchase a product
prob_Purchased3<-predict.glm(logistic_purchased,newdata = new.data.Purchased3, type = "response")
prob_Purchased3<-as.data.frame(prob_Purchased3)
#Roughly 22% probability
#Probability recorded in Probability.xlsx

#Data frame if someone is above average age and has above average salary
new.data.Purchased4<-as.data.frame(matrix(c(1,1),nrow = 1))
new.data.Purchased4
colnames(new.data.Purchased4)<-c("Age.Above.Average","Salary.Above.Average")
new.data.Purchased4[,1]<-as.factor(new.data.Purchased4[,1])
new.data.Purchased4[,2]<-as.factor(new.data.Purchased4[,2])


#Predicted probability of someone who is above average age and has above average salary
#will purchase a product
prob_Purchased4<-predict.glm(logistic_purchased,newdata = new.data.Purchased4, type = "response")
prob_Purchased4<-as.data.frame(prob_Purchased4)
#Roughly 73.2% probability
#Probability recorded in Probability.xlsx