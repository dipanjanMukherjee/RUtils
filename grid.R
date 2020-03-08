myfile <- tempfile()

pdf(file = myfile, height = 5, width = 10)

metricplot <- ggplot()

grid.newpage()

grid.draw(cbind(ggplotGrob(metricplot))

dev.off()

cat("look at", myfile, "\n")
