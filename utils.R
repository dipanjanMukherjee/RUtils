library(plotly)

#value of x asthetic
xaxiscolumn <- data[[input$x]]

#value of y asthetic
yaxiscolumn <- data[[input$y]]

differentsymbols <- c('circle', 'cross', 'square', 'circle-open', 'square-open', 'star')

p <- plotly::plot_ly(data, type = "scatter3d", x = xaxiscolumn, y = yaxiscolumn, z = zaxisinput, color = firstfacet, 
                     colors = "Set1", symbol = secondfacet, symbols = differentsymbols, marker = list(size = 8), 
                     size = I(3), text = ~paste(input$x , ':', xaxisinput, '<br>'))


#filter file based on facet
df <- df[df[,input$facet] %in% input$columns, ]

df_null <- df[,is.na(input$facet)]
df <- df[,!is.na(input$facet)]


#
auto <- function(matrix){
  finallist <- vector()
  for(i in 1:nrow(matrix)){
    label <- data.frame(matrix[i, order(matrix[i,], decreasing = TRUE)])
    
    if(any(label[1,1] > 0)){
      if(any(label[2,1] > 0)){
        if(any(label[3,1] > 0)){
          val <- paste(rownames(label)[1:3], collapse = "-")
        }
        else{
          val <- paste(rownames(label)[1:2], collapse = "-")
        }
        else{
          val <- paste(rownames(label)[1], collapse = "-")
        }
      }
      finallist[i]<- val
    }
    alpha <- finallist
    return(as[1:length(alpha)])
  }
}