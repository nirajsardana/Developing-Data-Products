library(shiny)
shinyUI(fluidPage(
  ###############################################################################
  #Input Section
  ###############################################################################
  titlePanel("Example of Text, Numeric, Radio Button, Checkbox, Date Inputs"),
  sidebarLayout(
    sidebarPanel(
      textInput("iname", "Enter your Name:", ""),
      numericInput('iage', 'Enter your Age (Numeric input)', 0, min = 0, max = 10, step = 1),
      radioButtons("igender", "Gender:",
                   c("Male" = "MALE",
                     "Female" = "FEMALE")),
      checkboxGroupInput("ihobby", "Hobbies:", 
                         c("SPORTS" = "Sports", 
                           "MOVIES" = "Movies",
                           "MUSIC" = "Music"), selected=0),
      dateInput("idob", "Enter Date of Birth:")
    ),
    mainPanel(
      h4('You Name is: '), verbatimTextOutput("oname"),
      h4('Your Age is: '), verbatimTextOutput("oage"),
      h4('Your Gender is: '),verbatimTextOutput("ogender"),
      h4('Your Hobbies are: '),verbatimTextOutput("ohobby"),
      h4('Your Date of birth is: '),verbatimTextOutput("odob")
    )
  ),
  
  ###############################################################################
  #Dataset Section
  ###############################################################################
  titlePanel("Example of displaying Dataset"),
  
  sidebarLayout(
    sidebarPanel(      
      selectInput("dataset", "Choose a dataset:", choices = c("rock", "pressure", "cars")),
      numericInput("obs", "Number of observations to view:", 10)
    ),
    mainPanel(      
      # Show a summary of the dataset and an HTML table with the requested number of observations
      verbatimTextOutput("summary"),
      tableOutput("view")
    )
  ),
  
  ###############################################################################
  #Slider Section
  ###############################################################################
  titlePanel("Example of Sliders"),
  
  sidebarLayout(
    # Sidebar with sliders that demonstrate various available options
    sidebarPanel(
      # Simple integer interval
      sliderInput("integer", "Integer:", 
                  min=0, max=1000, value=500),
      
      # Decimal interval with step value
      sliderInput("decimal", "Decimal:", 
                  min = 0, max = 1, value = 0.5, step= 0.1),
      
      # Specification of range within an interval
      sliderInput("range", "Range:",
                  min = 1, max = 1000, value = c(200,500)),
      
      # Provide a custom currency format for value display, with basic animation
      sliderInput("format", "Custom Format:", 
                  min = 0, max = 10000, value = 0, step = 2500,
                  format="$#,##0", locale="us", animate=TRUE),
      
      # Animation with custom interval (in ms) to control speed, plus looping
      sliderInput("animation", "Looping Animation:", 1, 2000, 1, step = 10, 
                  animate=animationOptions(interval=300, loop=T))
      ),
      
      # Show a table summarizing the values entered
      mainPanel(
        tableOutput("values")
      )
  ),
  
  ###############################################################################
  #Tabsets Section
  ###############################################################################
  titlePanel("Example of Tabsets"),
  sidebarLayout(
    # Sidebar with controls to select the random distribution type
    # and number of observations to generate. Note the use of the br()
    # element to introduce extra vertical spacing
    sidebarPanel(
      radioButtons("dist", "Distribution type:",
                   list("Normal" = "norm",
                        "Uniform" = "unif",
                        "Log-normal" = "lnorm",
                        "Exponential" = "exp")),
      br(),
      
      sliderInput("n", 
                  "Number of observations:", 
                  value = 500,
                  min = 1, 
                  max = 1000)
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("plot")), 
        tabPanel("Summary", verbatimTextOutput("summary1")), 
        tabPanel("Table", tableOutput("table"))
     ) 
  )
  )
))