library(RCurl)
library(sqldf)
require(dplyr)
library(rCharts)
library(shinydashboard)
library(shiny)
library(leaflet)
library(htmltools)
##### set working directory

##setwd("C:/Users/sabra/Desktop/JScriptExample/VanCityBusinesses")

#### import data

###wayfind <- read.csv("data/wayfinding_maps.csv", header = TRUE)
# bus <- read.csv("data/businesses_2015.csv", header = TRUE)
ifelse(file.exists( "bus1.csv")==FALSE,
       download.file("https://dl.dropboxusercontent.com/u/3709256/businesses_2015.csv", "bus1.csv" )
        ,
       x <- 0
       )
bus <- read.csv("bus1.csv", header = TRUE)
bus <- bus[complete.cases(bus)==TRUE,]



###  

is1 <- sqldf("select *, IssuedYear*100+IssuedMonth YearMonth from bus 
             where IssuedYear >= 2014
             ")

r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()



##### lists for contectual menus

areas <- c('01-West End', '02-Central Business/Downtown','03-Strathcona', '07-Kitsilano')
btype <- c('Computer Services', 'Educational','Entertainment Services', 'Financial Services')
compsub <- c(
  "Analysis"
  ,"Animation"
  ,"Data Processing"
  ,"Database Management"
  ,"Design"
  ,"Graphics"
  ,"Information"
  ,"Integration"
  ,"Internet"
  ,"Network"
  ,"Other"
  ,"Programming"
  ,"Software"
  ,"Word Processing"
)
edusub <-  c(
  "Career Guidance"
  ,"Evaluation Service"
  ,"Interpreter/Translator"
  ,"Other"
  ,"Student Placement"
  ,"Student Recruiting"
  ,"Technical Writer"
  ,"Training Facilities"
  ,"Tutor"
)

entersub <- c(
  "Actor/Stunt Person"
  ,"Aquarium"
  ,"Cartoon/Animation"
  ,"Children's Entertainment"
  ,"Composer"
  ,"Curling Rink"
  ,"Dance/Event Promoter"
  ,"Disc Jockey"
  ,"Event Coordinator"
  ,"Face Painting"
  ,"Other"
  ,"Press/Media/Reporter"
  ,"Producer"
  ,"Radio Station"
  ,"Recording/Duplication"
  ,"Song Writer"
  ,"Writer/Editor"
  
)

finsub <- c(
  "Accountant/Auditor"
  ,"Bank Machine"
  ,"Bankruptcy"
  ,"Bookkeeping Service"
  ,"Collection Agent"
  ,"Credit Card Service"
  ,"Finance Agent"
  ,"Financial Executor"
  ,"Financial Planner"
  ,"Investment Company"
  ,"Merchant Bank Loan"
  ,"Mortgage Company"
  ,"Other"
  ,"Professional Fund Raiser"
  ,"Solvency Service"
  ,"Stock Exchange"
  ,"Tax Service"
)
