library(shiny)
shinyUI(fluidPage(
  titlePanel("Basic stats on an attribute"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:",
                  choices = c("training_set", "testing_set"),
                  selected = "training_set"),
      selectInput("attribute", "Choose an attribute:",
                  choices = attributes_names)
    ),
    mainPanel(
      h4("Summary"),
      htmlOutput("summary"),
      #h4("Extreme values"),
      #htmlOutput("extreme"),
      h4("Boxplot"),
      plotOutput("boxplot")
    )
  )
))