library(shiny)
library(datasets)
shinyServer(
  function(input, output) {
    
    ###############################################################################3
    # Input Section
    ###############################################################################3
    output$oname <- renderPrint({input$iname})
    output$oage <- renderPrint({input$iage})
    output$ogender <- renderPrint({input$igender})
    output$ohobby <- renderPrint({input$ihobby})
    output$odob <- renderPrint({input$idob})
    
    # Dataset Section
    # Return the requested dataset
    datasetInput <- reactive({
      switch(input$dataset,
             "rock" = rock,
             "pressure" = pressure,
             "cars" = cars)
    })
    ###############################################################################
    # Generate a summary of the dataset
    ###############################################################################
    output$summary <- renderPrint({
      dataset <- datasetInput()
      summary(dataset)
    })
    
    # Show the first "n" observations
    output$view <- renderTable({
      head(datasetInput(), n = input$obs)
    })
    
    ###############################################################################
    #Slider Section
    ###############################################################################
    # Reactive expression to compose a data frame containing all of the values
    sliderValues <- reactive({
      
      # Compose data frame
      data.frame(
        Name = c("Integer", 
                 "Decimal",
                 "Range",
                 "Custom Format",
                 "Animation"),
        Value = as.character(c(input$integer, 
                               input$decimal,
                               paste(input$range, collapse=' '),
                               input$format,
                               input$animation)), 
        stringsAsFactors=FALSE)
    }) 
    
    # Show the values using an HTML table
    output$values <- renderTable({
      sliderValues()
    })
   
    ##############################################################################
    # Tabset Section
    ##############################################################################
    # Reactive expression to generate the requested distribution. This is 
    # called whenever the inputs change. The renderers defined 
    # below then all use the value computed from this expression
    data <- reactive({  
      dist <- switch(input$dist,
                     norm = rnorm,
                     unif = runif,
                     lnorm = rlnorm,
                     exp = rexp,
                     rnorm)
      
      dist(input$n)
    })
    
    # Generate a plot of the data. Also uses the inputs to build the 
    # plot label. Note that the dependencies on both the inputs and
    # the 'data' reactive expression are both tracked, and all expressions 
    # are called in the sequence implied by the dependency graph
    output$plot <- renderPlot({
      dist <- input$dist
      n <- input$n
      
      hist(data(), 
           main=paste('r', dist, '(', n, ')', sep=''))
    })
    
    # Generate a summary of the data
    output$summary1 <- renderPrint({
      summary(data())
    })
    
    # Generate an HTML table view of the data
    output$table <- renderTable({
      data.frame(x=data())
    })
    
  }
)