library(rpart)
library(cvTools)

# Get classes from training set
y <- training_set[, 42]
# Get attributes from training set
xDataFrame = data.frame(training_set[, 0:41])
# Add columns names
colnames(xDataFrame) <- attributes_names

# Number of folds for crossvalidation
K = 10

# Create k-fold crossvalidation partition
CV <- cvFolds(length(y), K=K)
# Set up vectors that will store sizes of training and test sizes
CV$TrainSize <- c()
CV$TestSize <- c()

# Pruning levels
prune <- seq(from=0, to=0.05, length.out=10)

# Variable for classification error
Error_train = matrix(rep(NA, times=K*length(prune)), nrow=K)
Error_test = matrix(rep(NA, times=K*length(prune)), nrow=K)

for(k in 1:K){
  print(paste('Crossvalidation fold ', k, '/', K, sep=''))
  
  # Extract training and test set
  X_train <- xDataFrame[CV$which!=k, ];
  y_train <- y[CV$which!=k];
  X_test <- xDataFrame[CV$which==k, ];
  y_test <- y[CV$which==k];
  CV$TrainSize[k] <- length(y_train)
  CV$TestSize[k] <- length(y_test)
  
  Xdatframe_train <- data.frame(X_train)
  colnames(Xdatframe_train) <- attributes_names
  #classassignments <- class_names[y_train+1]
  
  # construct formula to fit automatically to avoid typing in each variable name
  (fmla <- as.formula(paste("y_train ~ ", paste(attributes_names, collapse= "+"))))
  
  # fit classification tree
  mytree <- rpart(fmla, data=Xdatframe_train,control=rpart.control(minsplit=1, cp=0), parms=list(split='information'), method="class")
  
  Xdatframe_test <- data.frame(X_test)
  colnames(Xdatframe_test) <- attributes_names
  
  # Compute classification error
  for(n in 1:length(prune)){ # For each pruning level
    print(paste("Pruning level : ", n))
    mytree_pruned <- prune(mytree,prune[n])
    predicted_classes_train<- class_names[predict(mytree_pruned, newdat=Xdatframe_train, type="vector")]
    predicted_classes_test<- class_names[predict(mytree_pruned, newdat=Xdatframe_test, type="vector")]
    Error_train[k,n] = sum(as.character(y_train) != predicted_classes_train)
    Error_test[k,n] = sum(as.character(y_test) != predicted_classes_test)
  }
  
}

# Plot classification error
# Chose the pruning level with the lowest test error
plot(c(min(prune), max(prune)), c(min(colSums(Error_train)/sum(CV$TrainSize), colSums(Error_test)/sum(CV$TestSize)), max(colSums(Error_train)/sum(CV$TrainSize), colSums(Error_test)/sum(CV$TestSize))), main='US Census decision tree: Holdout crossvalidation', xlab = 'Pruning level', ylab='Classification error', type="n")
points(prune, colSums(Error_train)/sum(CV$TrainSize), col="blue")
points(prune, colSums(Error_test)/sum(CV$TestSize), col="red")
legend('bottomright', legend=c('Training error', 'Test error'), fill=c("blue", "red"))
