
df <- as.data.frame(raw_vec) %>% separate(raw_vec, c("loggedtime", "collection"), "[\r\n]")

filter(tbl, counter == "%cooler rate")

tbl <- tbl_df(df)
avg_metrics_tbl <- metrics_tbl %>% group_by(host, counter) %>% summarise(mean_val = mean(value))

glimpse(avg_metrics_tbl)

ggplot(data = metrics_tbl, aes(x = loggedtime, y = value, group = counter, col = counter)) + geom_line()
	+ labs(x = "logged time", y = "% usage")
	+ geom_hline(data = group_metrics_tbl, aes(yintercept = group_metrics_tbl$mean_val, colour = factor(counter))
	, linetype = "dashed", size = 0.5, show.legend = T)
	+ facet_wrap(~host, scales = "free", ncol = 1)
	+ theme(axis.text, x = element_text(angle = 90))
	+ theme(axis.text, y = element_text(angle = 0 ))
	+ coord_cartesian(ylim = c(0,50))

