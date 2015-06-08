# Apply PCA on training_set
scores = apply_PCA(training_set)
y <- scores$class

# Get first two components from training PCA set
xDataFrame = scores[, 1:2]
# Compute formula for logistic regression
(fmla <- as.formula(paste("y ~ ", paste(colnames(scores)[1:2], collapse= "+"))))

# Fit logistic regression model
w_est = glm(fmla, family=binomial(link="logit"), data=xDataFrame[, 1:2]);

# Apply PCA on testing set
scores_test = apply_PCA(testing_set)
y_test <- scores$class

# Get first two components from testing PCA set
testDataFrame = scores_test[, 1:2]# Add columns names

# Evaluate the logistic regression for the new data object
pred = predict.glm(w_est, newdata=testDataFrame, type="response")
error_test = sum((as.numeric(y_test)-1)!=(pred>0.5));
# Print the error rate 
# 6.20%
print(error_test/length(y_test)*100)
