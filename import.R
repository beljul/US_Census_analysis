# Get csv training file into a data frame variable.
training_set <- read.csv("data/census_income_learn.csv", header=FALSE, quote="")
testing_set <- read.csv("data/census_income_test.csv", header=FALSE, quote="")