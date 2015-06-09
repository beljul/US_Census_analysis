library(shiny)
library(ggplot2)
library(pastecs)

shinyServer(function(input, output) {
  # Generate a summary of the attribute
  output$summary <- renderTable({
    dataset = get(input$dataset)
    attribute = input$attribute

    if (is.numeric(dataset[, attribute])){
      df = as.data.frame(stat.desc(dataset[, attribute], desc=F))
      colnames(df)[1] <- attribute
    }
    if (is.factor(dataset[, attribute])) {
      df = prop.table(table(dataset[, attribute]))
    }
    df
  })
  
  # Get extreme values of the attribute
  #output$extreme <- renderUI({
  #  dataset = get(input$dataset)
  #  attribute = input$attribute
  #  if (!is.numeric(dataset[, attribute])){
  #    paste("This attribute ", attribute, " is non-numerical.")
  #  } else {
  #    res = getOutliers(dataset[, attribute])
  #    min = paste("Minimal value: ", res$yMin)
  #    max = paste("Maximal value: ", res$yMax)
  #    HTML(paste(min, max, sep = '<br/>'))
  #  }
  #})
  
  # Get boxplot of the attribute
  output$boxplot <- renderPlot({
    dataset = get(input$dataset)
    attribute = input$attribute
    ggplot(dataset, aes_string(x='Gain', y=attribute, fill='Gain')) + geom_boxplot() +
      stat_summary(fun.y=mean, geom="point", shape=5, size=4)
  })
})