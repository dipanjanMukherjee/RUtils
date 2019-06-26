###########
#trend chart without summarization
#######

require(grid)
require(ggplot2)
myfile <- tempfile()

pdf(file = myfile, height = 30, width = 15)


metricplot <- ggplot(data = avg_metrics_tbl, aes(x=loggedtime,
              y=value,group = counter, col = counter)) +
  geom_hline(data = avg_metrics_tbl)+
  geom_text_repel(data = avg_metrics_tbl) +
  ggtitle("%CPU USAGE")+
  facet_wrap(C("site","host","macine_type"), labeller = "label_both", ncol = 1, scales = "free") +
  theme(axis.text.x = element_text(angle = 90))+
  theme(axis.text.y = element_text(angle = 0))+
  geom_hline(data = avg_temp_tbl, aes(yintercept = avg_tmp_tbl$mean_val), colour = "purple", linetype = "dashed")

grid.newpage()
grid.draw(cbind(ggplotGrob(metricplot), ggplotGrob(tempplot), size = "last"))
dev.off()
cat("look at : ", myfile,"\n")