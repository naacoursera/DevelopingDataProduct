library(shiny)
data(mtcars)
mfit = lm(mpg ~ wt + disp + cyl, data=mtcars)

shinyServer(function(input, output) {
  newmpg <- reactive({
    newcar = data.frame(wt=as.numeric(input$wt), disp=as.numeric(input$disp), cyl=as.numeric(input$cyc))
    newmpg <- predict(mfit, newcar)[[1]]

  })
  
  output$text <- renderUI({

    HTML(paste(sprintf("<h2>Documentation</h2>"),
               sprintf("This program make use the 1974 Motor Trend US Magazine Dataset (mtcars) to predict car's mpg."),
               sprintf("The prediction use multivariate linear regression method"),
               sprintf("<br>"),
               sprintf("User need to use the side bar to set the number of cylinders, car weight and displacement. After that, press the 'Calculate MPG?' button, the desired input and the predicted MPG will be computed and shown below."),
               sprintf("<br>"),
               sprintf("<h4>You set the car to have:</h4>"),
               sprintf("Number of Cylinderes:<b> %s</b>", input$cyc),
               sprintf("Car Weight: <b>%s (lb/1000)</b>", input$wt),
               sprintf("Displacement: <b>%s (cu.in.)</b>", input$disp),
               sprintf("<br/>"),
               sprintf("<h3>Predicted MPG: %f Miles/(US) gallon</h3>", newmpg()),
               sep="<br/>"))
  })
})