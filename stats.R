library(pastecs)

get_stats <- function (data){
  colnames(data) <- attributes_names
  
  # Separate numerical and factor columns
  nums <- sapply(data, is.numeric)
  factors <- sapply(data, is.factor)
  
  # Get summary stats for numerical attributes
  print('Repartition for each numerical attribute')
  print(stat.desc(data[, nums], desc=F))
  print('===============================')
  
  # Get repartition of each category for each factor attribute
  print('Repartition for each categorical attribute')
  print(summary(data[, factors]))
  print('===============================')
  
  i = 0
  res = c()
  print('Percentage repartition for each categorical attribute')
  for (col in colnames(data)){
    i = i + 1
    if(!is.na(col) & !factors[col]) next
    print(paste('============', col, '=========='))
    print(prop.table(table(data[, i])))
  }
}

get_stats(training_set)
