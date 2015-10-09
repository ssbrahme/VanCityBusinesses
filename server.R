shinyServer(function(input, output) {
  
  output$z <- renderUI({
    switch(input$y,
            "Computer Services" = selectInput("sub","Sub-Services",
                                              choices = compsub, selected= "Software") ,
            
            "Educational"  = selectInput("sub", "Sub-Services",
                                         choices = edusub, selected = "Career Guidance") ,
            
            
            "Entertainment Services" = selectInput("sub", "Sub-Services", 
                                                   choices = entersub, selected = "Aquarium" ) ,
            "Financial Services" = selectInput("sub", "Sub-Services", 
                                               choices = finsub , selected = "Bank Machine" 
                                               )
            
      
    )
  })
  
  output$subs <- renderPrint({input$sub})
  
  ## Chart Data 1
  ChartData1 <- reactive({
    data.frame(filter(is1, LocalArea == input$x, Status == "Issued") %>%
                 group_by( YearMonth) %>%
                 summarise(Businesses = n()), row.names=NULL)
  })
  
  
  
  output$LicenseChart <- print(renderPlot({
    barplot(  ChartData1()$Businesses, 
              names.arg = ChartData1()$YearMonth,   
              main = "Businesses Opened each Year-Month" ,
                 xlab = "YearMonth" , ylab = "No. of Businesses",
                 col = "#99deff"
    )
   
  }))
  
  ## Chart data 2
  ChartData2 <- reactive({
    data.frame(filter(is1, LocalArea == input$x) %>%
                 group_by( Status) %>%
                 summarise(Businesses = n()), row.names=NULL)
  })
  
  
  
  output$StatusChart <- print(renderPlot({
    barplot(  ChartData2()$Businesses, 
              names.arg = ChartData2()$Status,   
              main = "Businesses Status" ,
              xlab = "Status" , ylab = "No. of Businesses",
              col = "#99deff"
    )
  })
  )
  
  
  ### filter data function

  filteredData <- reactive({
    bus[bus$LocalArea == input$x & bus$BusinessType == input$y & bus$BusinessSubType == input$sub,]
  })
  
  
#### Render Leaflet Map  
   
  output$vanmap <- renderLeaflet({
    leaflet() %>%
    addProviderTiles("Hydda.Full") %>%  setView(-123.12, 49.28, zoom = 14)
  })

###
  
  
  observe({
    leafletProxy("vanmap", 
    data =  filteredData())  %>% clearShapes() %>%
    addCircles(~Longitude, ~Latitude,
               
               popup = paste(sep = "<br/>",
                     paste0("<b><a href='www.google.com'>",filteredData()$BusinessTradeName,"</a></b>"),
                     "Employees:",
                     as.character(filteredData()$NumberOfEmployees)
               )
               ,
               
               # popup = paste(filteredData()$BusinessTradeName, filteredData()$NumberOfEmployees ) ,
               radius = 3, color= ifelse(input$x == "02-Central Business/Downtown", "red",ifelse(input$x=="01-West End", "blue" ,"green")) , fillOpacity = 0.5) 
#     %>%
#     addPopups(~Longitude, ~Latitude, ~htmlEscape(filteredData()$BusinessTradeName))
#       
    
    })  


  
    
})




