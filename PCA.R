library(ggplot2)
library(ggbiplot)

apply_PCA <- function(data){
  indx <- sapply(data, is.factor)
  data_numeric = training_set
  data_numeric[indx] <- lapply(data_numeric[indx], function(x) as.numeric((x)))
  
  data_numeric.pca <- prcomp(data_numeric, retx=TRUE, center=TRUE, scale=TRUE)
  
  scores = as.data.frame(data_numeric.pca$x)
  scores$class = factor(data_numeric$V42)
  
  return(scores)
}

scores <- apply_PCA(training_set)

training_factors_set.pca$sdev

# Print PCA
ggplot(data = scores, aes(x = PC1, y = PC2, label = rownames(scores))) +
  geom_hline(yintercept = 0, colour = "gray65") +
  geom_vline(xintercept = 0, colour = "gray65") +
  geom_point(aes(colour=class)) +
  ggtitle("PCA plot of US Census")


