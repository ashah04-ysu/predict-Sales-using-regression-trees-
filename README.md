# Predict Sales using Regression Trees
##Introduction
This code is a demonstration of building and evaluating a decision tree model using the rpart package in R. The data used is the OJ dataset from the ISLR2 package. The goal of this model is to predict the brand of orange juice a consumer will purchase.

##Packages Used
The following packages are used in this code:

ISLR2,
caret,
tidyverse,
ggthemes,
rpart,
rpart.plot,
knitr,
kableExtra,
## Model Building
1. The data is split into a training set (800 observations) and a testing set (270 observations).
2. A decision tree model is built using the rpart function with the Purchase variable as the response and all other variables as predictors. The rpart.control argument is used to set the complexity parameter (cp) to 0, indicating that the tree should not be pruned.
3. The summary of the model and a plot of the tree are generated using the summary and rpart.plot functions, respectively.
4. The model's accuracy is evaluated using the postResample function and a confusion matrix generated using the confusionMatrix function from the caret package.
## Model Tuning
1. The model is tuned using 10-fold cross-validation with the train function from the caret package. The grid of values for the cp is set from 0 to 0.5 with 10 equally spaced values.
2. The best cp value is selected based on the accuracy of the model, and a new decision tree model is built using this value.
3. The accuracy of the tuned model is compared to the accuracy of the original model using the postResample function.
## Results
The results show that the unpruned decision tree model has higher accuracy on both the training and testing sets. This suggests that the training set is a good match for the testing set. The most important predictor for this model is the LoyalCH variable, which indicates the customer's loyalty to the chain.
