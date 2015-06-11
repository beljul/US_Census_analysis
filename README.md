# US_Census_analysis
This is a R project in order to analysis data sample from US Census. The aim is to predict one of the attribute (the gain per year, that means more or less than 50k$).

## Import data
You just need to use the file import.R which provides the main variables needed to perform analysis.

## Basic statistics
The file stats.R is depreciated, it can be still used but the information provided in output is not very user friendly. That's why a shiny dashboard has been implemented (inside stats directory) in order to visualize basic statistics for each attribute and boxplots. You can find an example of the dashboard in results/shiny\_example.png.

## Decision Tree model
This model has been generated from all of our attributes. Two methods has been tested : Gini and Entropy, finaly the Entropy is the best one (in terms of error rate ~ 6.4%). Moreover at the end the confusion matrix is printed.

In addition to improve our error rate (to decrease it), we performer a 10-fold cross validation you can see in the file cross\_validation-decision\_tree.R. The cross validation takes a long time to be executed, that's why you can find the result in results/holdout-CV-decision_tree.png. Based on that we defined the most optimized pruning level for the decision tree, thanks to that we obtained an error rate ~ 5%.

## Logistic regression
The cost to perform this model is more important than decision, that's why we decided to generate it based on Principal Components Analysis (in order to work with only the two main attributes). You can find the PCA function will apply in PCA.R, moreover at the end of the script the PCA is applied. However you can directly observe result in results/training\_set\_PCA.png.

The PCA is directly called inside the script logistic_regression.R where the prediction has been done. We get an error rate around 6.2%.
