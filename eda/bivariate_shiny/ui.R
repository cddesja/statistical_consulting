load("ws_data.Rdata")
library("shiny")

shinyUI(fluidPage(
  fluidRow(
    column(2),
    column(4,
           selectInput("dep", label = h3("Dependent Variable"), 
                               choices = names(ws_data), 
                               selected = 1)),
    column(4,
           selectInput("ind", label = h3("Independent Variable"), 
                               choices = names(ws_data), 
                               selected = 1))),
  plotOutput("plot")))
