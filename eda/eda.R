#
# Load required packages
#

library("ggplot2")
library("Lahman")
library("dplyr")
library("shiny")
library("htmlTable")
library("factoextra")
library("corrplot")

# Data checks
str(Teams)
summary(Teams)

# Select most relevant variables
ws_data <- Teams %>% 
  filter(yearID > 1950) %>%
  select(W, R, AB, H, X2B, X3B, HR, BB, SO, 
         SB, CS, HBP, SF, RA, ER, ERA, CG, SHO, SV, HA, HRA, 
         BBA, SOA, E, DP, FP, attendance, BPF, PPF)

## For the presentation
ws_five_sum <- data.frame(Min = apply(ws_data, 2, min, na.rm = T), 
                          Q1 = apply(ws_data, 2, quantile, 1/4, na.rm = T), 
                          Med = apply(ws_data, 2, median, na.rm = T),
                          Mean = apply(ws_data, 2, mean, na.rm = T), 
                          Q3 = apply(ws_data, 2, quantile, 3/4, na.rm = T), 
                          Max = apply(ws_data, 2, max, na.rm = T))

ws_five_sum %>%
  htmlTable() %>% cat()

# Find the correlations with wins
ws_data %>%
  cor(use = "complete.obs") %>%
  as.data.frame() %>%
  mutate(Variables = rownames(.)) %>%
  select(Variables, W) %>% arrange(W)
  # %>%  ## this part is just for the presentation
  # htmlTable(rnames = FALSE, header = c("Predictor", "Wins")) %>%
  # cat()

## Correlation plot
ws_data %>%
  cor(use = "complete.obs") %>%
  corrplot(order="hclust", tl.col="black", cl.pos = "n")

## Shiny application for bivariate pltos
shinyApp(
  ui = fluidPage(
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
    plotOutput("plot")), 
  server = function(input, output) {
    output$plot <- renderPlot({
      names <- c(input$ind, input$dep)
      data_tmp <- ws_data[,names]
      data_ws <- data.frame(ind = data_tmp[,1], dep = data_tmp[,2])
      ggplot(aes(y = dep, x = ind), data = data_ws) + geom_point(col = "#642E68") +
        geom_smooth(col = "#2A1824") + xlab(paste(input$ind)) + ylab(paste(input$dep)) + theme_bw()
  })
  })

## Marginal plot of wins
qplot(W, data = ws_data, fill = I("#642E68"), col = I("white")) + ylab("") + xlab("") + theme(panel.background = element_rect(fill = "black"), panel.grid.major = element_line(color = "black"), panel.grid.minor = element_line(color = "black"), plot.background =    element_rect(colour = "black", fill = "black"), axis.text = element_text(color = "white"))

## Box and whisker plot
ws_data$attendance.f <- cut(ws_data$attendance, breaks = quantile(ws_data$attendance))
levels(ws_data$attendance.f) <- c("Low", "Medium-Low", "Medium-High", "High")
ggplot(aes(y = W, x = attendance.f, fill = attendance.f), data = na.omit(ws_data)) + geom_boxplot(outlier.colour = "white", color = I("white")) + theme(panel.background = element_rect(fill = "black"), panel.grid.major = element_line(color = "black"), panel.grid.minor = element_line(color = "black"), plot.background =    element_rect(colour = "black", fill = "black"), axis.text = element_text(color = "white"), legend.position="none", axis.text.x = element_text(color = "black"), axis.ticks.x = element_line(color = "black")) + scale_fill_manual(values = c("#1B346C", "#01ABE9", "#E5C39E", "#F54B1A"))

## Principal Components
ws_data %>%
  select(-W,-attendance.f) %>%
  na.omit() %>%
  prcomp(center = TRUE, scale = TRUE) %>%
  fviz_pca_biplot(label = "var", col.var = "#F54B1A", col.ind = "#1B346C") + theme(panel.background = element_rect(fill = "black"), panel.grid.major = element_line(color = "black"), panel.grid.minor = element_line(color = "black"), plot.background =    element_rect(colour = "black", fill = "black"), axis.text = element_text(color = "#C3CED0"), legend.position="none", axis.ticks.x = element_line(color = "#C3CED0")) 

