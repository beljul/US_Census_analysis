library(rpart)
# Get classes from training set
y <- training_set[, 42]
# Get attributes from training set
xDataFrame = data.frame(training_set[, 0:41])
# Add columns names
colnames(xDataFrame) <- attributes_names
# Compute formula for decision tree
(fmla <- as.formula(paste("y ~ ", paste(attributes_names, collapse= "+"))))
# Compute the decision tree itself
mytree <- rpart(fmla, data=xDataFrame, control=rpart.control(minsplit=1, cp=0), parms=list(split='information'), method="class")
mytree <- prune(mytree, 0.005)
# Get classes from testing set
y_test <- testing_set[, 42]
# Get attributes from testing set
testDataFrame = data.frame(testing_set[, 0:41])
# Add columns names
colnames(testDataFrame) <- attributes_names

# Compute the prediction from previous decision tree
pred <- predict(mytree, newdat=testDataFrame, type='vector')
# Print the error rate
# Gini : 6.58%
# Entropy : 6.38%
# Entropy based on pruning level from 10-cross validation : 5.05%
error_test = sum(as.character(y_test) != class_names[pred])
print(error_test/length(y_test)*100)

# Print confusion matrix
table(as.character(y_test), class_names[pred])
