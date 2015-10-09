

dashboardPage(
  dashboardHeader(title = "Business Mapper"),
  dashboardSidebar(
    selectInput(
      inputId = "x",
      label = "Choose Neighborhood",
      areas,
      selected = "02-Central Business/Downtown"
    )
    ,
    
    selectInput(
      inputId = "y",
      label = "Choose Type of Business",
      choices = btype,
      selected = "Computer Services"
    ) ,
    
    
    uiOutput("z") 
  ),
    

  dashboardBody(
    fluidRow(
      column(6, offset = 3,
             p("Welcome to the Vancouver Business Mapper! Select the Neightborhood, business type and business sub-type from the drop-down options.
               Clicking on the points on the map will reveal Business Names and no. of employees. Data courtesy: Vancouver Open Data Catalouge" 
               )
      )
      ),
     leafletOutput("vanmap"),
   
   #showOutput("LicenseChart","nvd3") , showOutput("StatusChart","nvd3"),
   fluidRow(plotOutput("LicenseChart", height = 300) , plotOutput("StatusChart", height = 300)),
   verbatimTextOutput("subs") 
    ) 
      
)

