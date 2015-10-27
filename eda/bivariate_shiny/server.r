library("ggplot2")
library("shiny")
library("magrittr")
load("ws_data.Rdata")
shinyServer(function(input, output) {
    output$plot <- renderPlot({
      names <- c(input$ind, input$dep)
      data_tmp <- ws_data[,names]
      data_ws <- data.frame(ind = data_tmp[,1], dep = data_tmp[,2])
      ggplot(aes(y = dep, x = ind), data = data_ws) + geom_point(col = "#642E68") +
        geom_smooth(col = "#2A1824") + xlab(paste(input$ind)) + ylab(paste(input$dep)) + theme_bw()
})
})