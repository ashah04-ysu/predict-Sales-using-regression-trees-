#A
packages <- c('ISLR2', 'caret', 'tidyverse', 'ggthemes', 'rpart', 'rpart.plot', 
              'knitr', 'kableExtra')
sapply(packages, require, character.only = TRUE)
data(OJ)
set.seed(1)

inTrain <- createDataPartition(OJ$Purchase, p = 800/1070, list = FALSE)
training <- OJ[inTrain,]
testing <- OJ[-inTrain,]

#B
rpart_model <- rpart(Purchase ~ ., data = training, 
                     method = 'class',
                     control = rpart.control(cp = 0))
summary(rpart_model, cp = 1)

#The summary demonstrates that LoyalCH is by far the most critical 
#element in deciding which orange juice a consumer will purchase.

postResample(predict(rpart_model, 
                     training, type = 'class'), 
             training$Purchase) %>%
kable
#LoyalCH is so far the most important variable

#C
rpart_model


#D
#install.packages('rpart.plot')
library("rpart.plot")
rpart.plot(rpart_model)

# The plot depicts the same outcomes as 
# the output. We can use the plot to estimate which 
# brand of orange juice a consumer will buy if we 
#know information about them.

#E
pred <- predict(rpart_model, testing, type = 'class')

caret::confusionMatrix(pred, testing$Purchase)


#F
rpart_cv_model <- train(training[,-1], training[,1],
                        method = 'rpart',
                        trControl = trainControl(method = 'cv', number = 10),
                        tuneGrid = expand.grid(cp = seq(0, 0.5, length.out = 10)))
rpart_cv_model

#G
plot(rpart_cv_model)


#H
rpart_cv_model$bestTune %>% kable
rpart_cv_model$results %>% kable

#I
set.seed(1)
rpart_tuned <- rpart(Purchase ~ ., data = training, method = 'class',
                     control = rpart.control(cp = 0.02))
rpart_tuned


rpart.plot(rpart_tuned)


#J
postResample(predict(rpart_model, 
                     training,
                     type = 'class'), training$Purchase) %>% kable
postResample(predict(rpart_tuned, 
                     training,
                     type = 'class'), training$Purchase) %>% kable
#The training accuracy of the unpruned model is higher. 
#It signifies that the training set is a good match for the testing set.


#K
postResample(predict(rpart_model, 
                     testing,
                     type = 'class'), testing$Purchase) %>% kable
postResample(predict(rpart_tuned, 
                     testing,
                     type = 'class'), testing$Purchase) %>% kable

#The accuracy of the unpruned model is higher.